# BUB Panel v0.1.60 Release Checklist

A public release is allowed only after all required gates are complete.

## Static gates

- [ ] `go test ./...`
- [ ] `go vet ./...`
- [ ] `go test -race ./...` where supported
- [ ] `bash -n` for every shell script
- [ ] `node --check` for every JavaScript file
- [ ] linux/amd64 Panel + Agent build
- [ ] linux/arm64 Panel + Agent build
- [ ] release runtime bundle contains no private Go source
- [ ] SHA256SUMS generated from final release assets
- [ ] release binaries built with the approved obfuscating release builder

## Data and upgrade gates

- [ ] Fresh install
- [ ] Upgrade from the current production baseline
- [ ] PostgreSQL users preserved
- [ ] SQLite users preserved where applicable
- [ ] Backup creation and verification
- [ ] Restore on a replacement installation
- [ ] OpenVPN PKI/CA/CRL preserved
- [ ] No destructive schema reset

## Node lifecycle gates

- [ ] Add Node
- [ ] Repair Agent
- [ ] Reclaim Agent
- [ ] Remove Node
- [ ] Remove Node deletes only BUB Panel Agent assets
- [ ] No unrelated service is stopped, killed, disabled, removed or reconfigured
- [ ] Main and Agent report the same release version

## VPN service matrix

For every supported protocol on Main and on a remote Node:

- [ ] Install
- [ ] Start
- [ ] Stop
- [ ] Restart
- [ ] Create user
- [ ] Generate/download client configuration
- [ ] Connect
- [ ] Pass traffic
- [ ] Account traffic
- [ ] Enforce quota
- [ ] Disable an active user
- [ ] Block reconnect while disabled
- [ ] Delete user
- [ ] Uninstall
- [ ] Reinstall

## Multi-node isolation

- [ ] Same port can be reused on different targets
- [ ] Port conflict is checked only on the selected target/transport
- [ ] Foreign listener causes BUB install rejection, not process termination
- [ ] UI install/uninstall/pending/error state never leaks between targets
- [ ] IKEv2/L2TP shared UDP 500/4500 ownership works on Main and Node

## Web UI

- [ ] Desktop
- [ ] Mobile
- [ ] Responsive layout
- [ ] Persian default
- [ ] English contains no Persian input placeholders
- [ ] Server selector
- [ ] Modals
- [ ] Loading/pending/error states
- [ ] No browser-native confirm dialogs
- [ ] No duplicate cards
- [ ] Correct TCP/UDP labels
- [ ] Blank selectable ports fail explicitly
- [ ] Fixed mandatory ports are read-only

## Security

- [ ] Authentication/session tests
- [ ] CSRF tests
- [ ] Rate-limit tests
- [ ] API token scope tests
- [ ] Secret encryption/backup tests
- [ ] No password/private key/token/recovery secret in logs
- [ ] Release archive contains no server credentials or private keys
- [ ] HTTPS guidance present in documentation

## Publish

- [ ] Tag is `v0.1.60`
- [ ] Public repository contains no private Go source
- [ ] Release assets uploaded
- [ ] SHA256SUMS uploaded
- [ ] Release notes finalized
- [ ] Install instructions verified from a clean server
- [ ] Manager automatic update verified against the published release
