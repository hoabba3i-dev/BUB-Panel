# Telegram Proxy integration

BUB Panel integrates Telegram MTProto Proxy as a separate `proxy` service. It does not alter the datapath or runtime configuration of WireGuard, AmneziaWG, OpenVPN, ocserv, SSTP, SoftEther, IKEv2 or L2TP.

## Runtime

- Engine: Telemt 3.5.7, pinned by release asset and SHA-256 in `scripts/service-control.sh`.
- Service: `telemt.service`, running as the unprivileged `telemt` user.
- Control API: loopback only (`127.0.0.1:9091`) with a random bearer token stored in `/etc/telemt/bub-api.token` mode `0600`.
- Listener: one shared TCP listener. Each BUB user receives an independent MTProto secret/link.
- Supported modes: FakeTLS (`tls`, default), Secure, Classic.
- Public address: the service-specific public host can use the panel public host or a custom IP/domain. Public port may differ from the local listener port.

## BUB Panel ownership

- Manager installs/uninstalls the Telegram Proxy runtime independently of VPN services.
- Web UI exposes it under **Proxy Services**.
- Port Management uses the existing service-port workflow.
- Users can enable Telegram Proxy alongside their VPN protocols.
- BUB user expiry, quota and enabled/disabled state are synchronized to Telemt; live traffic and current connection counters are collected back into the existing user accounting loop.
- User output includes a Telegram `tg://proxy` link, direct connect action, copy-link action, QR and downloadable guide.
- Subscription pages expose preview/download/QR for Telegram Proxy.

## Security and persistence

- Secrets and API tokens are never printed by the BUB scripts.
- User secrets remain in Telemt's private configuration and generated user-facing config only; the web backend does not log them.
- Telemt's API is not exposed on the public interface.
- Service setting changes preserve `[access.*]` user tables instead of rebuilding secrets.
- Backup/restore includes `/etc/telemt` and `/var/lib/telemt`.
- Removing Telegram Proxy does not stop or reconfigure any VPN service.

## v0.0.97 Web installer

Telegram Proxy can be installed directly from **Web Panel → Proxy Services**. The page always presents a compact centered install card when the runtime is not installed. The registry also repairs legacy persisted service metadata so an older `services.json` cannot hide the proxy card.

## v0.0.98 panel-native lifecycle UI

- Removed the decorative arrow from the Proxy Services card.
- Telegram Proxy install/uninstall no longer uses the browser/phone confirm dialog.
- Install and uninstall show an in-panel progress line until the backend reports the final service state.
- After installation, the card exposes Uninstall alongside runtime controls.


## v0.0.99 UI fix
- Install/uninstall actions use delegated panel-native click handlers (no browser confirm).
- Telegram branding is centered with a Telegram icon and deliberate spacing before lifecycle actions.
