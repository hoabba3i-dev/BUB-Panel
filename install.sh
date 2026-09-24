#!/usr/bin/env bash
set -Eeuo pipefail
REPO="${BUB_PANEL_REPO:-hoabba3i-dev/BUB-Panel}"; API="https://api.github.com/repos/${REPO}/releases/latest"; WORK="$(mktemp -d "${TMPDIR:-/tmp}/bub-panel-install.XXXXXX")"; trap 'rm -rf "$WORK"' EXIT
C='\033[38;5;51m';G='\033[1;32m';D='\033[38;5;244m';R='\033[1;31m';N='\033[0m'
line(){ printf "${D}------------------------------------------------------------${N}\n"; }; step(){ printf "${C}::${N} %s\n" "$*"; }; ok(){ printf "${G} ->${N} %s\n" "$*"; }; die(){ printf "${R}ERROR:${N} %s\n" "$*" >&2;exit 1; }
[[ ${EUID:-$(id -u)} -eq 0 ]] || die 'Run this installer as root.'; clear 2>/dev/null || true; line; printf "${C}[BUB-PANEL] deploy${N}\n"; line; step 'Preparing installer dependencies'
if command -v apt-get >/dev/null 2>&1; then export DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=l APT_LISTCHANGES_FRONTEND=none; timeout --foreground --kill-after=30s 180 apt-get -o Acquire::Retries=2 -o Acquire::http::Timeout=20 -o Acquire::https::Timeout=20 update -qq </dev/null; timeout --foreground --kill-after=30s 600 apt-get install -y -qq -o=Dpkg::Use-Pty=0 -o=DPkg::Lock::Timeout=60 -o Acquire::Retries=2 -o Acquire::http::Timeout=20 -o Acquire::https::Timeout=20 curl ca-certificates python3 tar coreutils openssl </dev/null
elif command -v dnf >/dev/null 2>&1; then dnf -y -q install curl ca-certificates python3 tar coreutils openssl
elif command -v yum >/dev/null 2>&1; then yum -y -q install curl ca-certificates python3 tar coreutils openssl
else die 'Supported package manager not found (apt/dnf/yum).';fi
case "$(uname -m)" in x86_64|amd64) ARCH=amd64;;aarch64|arm64) ARCH=arm64;;*) die "Unsupported architecture: $(uname -m)";;esac
CURL=(-fL --connect-timeout 8 --max-time 300 -H 'Accept: application/vnd.github+json'); [[ -z "${BUB_PANEL_GITHUB_TOKEN:-}" ]] || CURL+=(-H "Authorization: Bearer ${BUB_PANEL_GITHUB_TOKEN}")
META="$WORK/release.json"; step 'Fetching latest release of BUB-Panel'; curl -fsSL --connect-timeout 8 --max-time 30 -H 'Accept: application/vnd.github+json' ${BUB_PANEL_GITHUB_TOKEN:+-H "Authorization: Bearer ${BUB_PANEL_GITHUB_TOKEN}"} -o "$META" "$API" || die 'Could not fetch release metadata.'
TAG=$(python3 - "$META" <<'PYTAG'
import json,sys
print(json.load(open(sys.argv[1],encoding='utf-8')).get('tag_name',''))
PYTAG
)
[[ "$TAG" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]] || die 'Latest release tag is missing or invalid.'; ok "latest release: $TAG"
RUNTIME="BUB-Panel-runtime-${TAG}.tar.gz";PANEL="bub-panel-linux-${ARCH}";AGENT="bub-panel-agent-linux-${ARCH}";SUMS=SHA256SUMS
asset_url(){ python3 - "$META" "$1" <<'PYURL'
import json,sys
j=json.load(open(sys.argv[1],encoding='utf-8'));n=sys.argv[2];print(next((a.get('browser_download_url','') for a in j.get('assets',[]) if a.get('name')==n),''))
PYURL
}
download_asset(){ local name=$1 url;url=$(asset_url "$name");[[ -n "$url" ]] || die "Release asset missing: $name";step "Downloading $name";curl "${CURL[@]}" --progress-bar -o "$WORK/$name" "$url";ok "$name"; }
for asset in "$RUNTIME" "$PANEL" "$AGENT" "$SUMS";do download_asset "$asset";done
step 'Verifying SHA256 checksums';(cd "$WORK";grep -E "  (${RUNTIME}|${PANEL}|${AGENT})$" "$SUMS"|sha256sum -c -)||die 'Checksum verification failed.';ok 'release asset checksums verified'

# Authenticity gate: SHA256 alone is not sufficient because a compromised publisher could replace both assets and checksums.
# The Ed25519 public key is pinned here; the corresponding private key is kept offline and is never stored in GitHub/CI.
PUBKEY="$WORK/release-ed25519-public.pem"
cat >"$PUBKEY" <<'BUBPUBKEY'
-----BEGIN PUBLIC KEY-----
MCowBQYDK2VwAyEAm3f2WwMktdRWQCPGBGDvoLjtXnVP4WZfCV0hs8H1SW0=
-----END PUBLIC KEY-----
BUBPUBKEY
MANIFEST="$WORK/signed-manifest.txt"; SIGBIN="$WORK/release-signature.bin"
python3 - "$META" "$MANIFEST" "$SIGBIN" <<'PYSIG'
import base64,json,re,sys
meta,out,sigout=sys.argv[1:]
body=json.load(open(meta,encoding='utf-8')).get('body') or ''
begin='-----BEGIN BUB PANEL SIGNED CHECKSUMS V1-----'
end='-----END BUB PANEL SIGNED CHECKSUMS V1-----'
if body.count(begin)!=1 or body.count(end)!=1:
    raise SystemExit('signed checksum block missing or ambiguous')
a=body.index(begin); b=body.index(end,a)+len(end)
manifest=body[a:b]+'\n'
m=re.search(r'(?m)^BUB_PANEL_SIGNATURE_ED25519_BASE64=([A-Za-z0-9+/]+={0,2})$',body)
if not m:
    raise SystemExit('Ed25519 release signature missing')
try: sig=base64.b64decode(m.group(1),validate=True)
except Exception: raise SystemExit('Ed25519 release signature is not valid base64')
if len(sig)!=64: raise SystemExit('Ed25519 release signature has invalid length')
open(out,'wb').write(manifest.encode('ascii'))
open(sigout,'wb').write(sig)
PYSIG
openssl pkeyutl -verify -pubin -inkey "$PUBKEY" -rawin -in "$MANIFEST" -sigfile "$SIGBIN" >/dev/null 2>&1 || die 'Release authenticity verification failed (Ed25519).'
python3 - "$MANIFEST" "$WORK/$SUMS" "$RUNTIME" "$PANEL" "$AGENT" <<'PYMATCH'
import re,sys
manifest,sums,*needed=sys.argv[1:]
rx=re.compile(r'^([0-9a-f]{64})  ([A-Za-z0-9._+-]+)$')
def parse(lines):
 d={}
 for line in lines:
  m=rx.match(line.strip('\n'))
  if m:
   if m.group(2) in d: raise SystemExit('duplicate checksum entry')
   d[m.group(2)]=m.group(1)
 return d
signed=parse(open(manifest,encoding='ascii'))
asset=parse(open(sums,encoding='ascii'))
for name in needed:
 if name not in signed: raise SystemExit('signed checksum missing: '+name)
 if asset.get(name)!=signed[name]: raise SystemExit('SHA256SUMS does not match signed release notes: '+name)
PYMATCH
ok 'release publisher signature verified (Ed25519)'
mkdir -p "$WORK/runtime";tar -xzf "$WORK/$RUNTIME" -C "$WORK/runtime" --strip-components=1;[[ -x "$WORK/runtime/scripts/install.sh" ]]||die 'Runtime bundle is incomplete.';mkdir -p "$WORK/runtime/release";install -m0755 "$WORK/$PANEL" "$WORK/runtime/release/bub-panel";install -m0755 "$WORK/$AGENT" "$WORK/runtime/release/bub-panel-agent"
"$WORK/runtime/release/bub-panel" --version|grep -Fxq "BUB Panel ${TAG}"||die 'Panel version mismatch.';"$WORK/runtime/release/bub-panel-agent" --version|grep -Fxq "${TAG#v}"||die 'Agent version mismatch.'
line;step "Installing BUB Panel ${TAG} (${ARCH})";line
if [[ -r /dev/tty ]];then bash "$WORK/runtime/scripts/install.sh" </dev/tty;else bash "$WORK/runtime/scripts/install.sh";fi
systemctl is-active --quiet bub-panel.service||die 'bub-panel.service did not become active.';ok "BUB Panel ${TAG#v} installed";ok 'service: active';ok 'manager: BUB-Panel';line
: # Manager is opened by the runtime installer after the user presses Enter.
