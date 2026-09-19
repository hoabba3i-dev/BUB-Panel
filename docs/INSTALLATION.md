# Installation and Upgrade

## Official release installation

```bash
curl -fsSL https://raw.githubusercontent.com/hoabba3i-dev/BUB-Panel/main/install.sh -o /tmp/bub-panel-install.sh
sudo bash /tmp/bub-panel-install.sh
```

The installer downloads the latest GitHub release metadata, chooses the matching `amd64` or `arm64` binaries, verifies the runtime and binaries against `SHA256SUMS`, stages the release, and invokes the BUB Panel installer.

On a fresh install the interactive order is:

1. Database backend setup.
2. Domain or public IP.
3. Web Panel port.
4. Owner username.
5. Owner password.
6. Optional custom Panel Path.
7. For a domain, automatic HTTPS with Let's Encrypt (default: yes).
7. Final installation/start.
8. One-time display of the login URL and credentials.
9. Press Enter to open the `BUB-Panel` Manager.

Upgrades do not repeat this bootstrap or replace an existing Owner account.

## Existing installation

An upgrade preserves `/etc/bub-panel`, `/var/lib/bub-panel`, existing database configuration and BUB-managed service data. The installer does not reset PostgreSQL or overwrite user records as part of a normal upgrade.

Use the Manager Update menu for normal upgrades. Automatic update uses release binaries and the runtime bundle; it does not download or build the private source tree.

## Verify

```bash
bub-panel --version
bub-panel-agent --version
systemctl is-active bub-panel
journalctl -u bub-panel -n 80 --no-pager
```

The final panel URL is built from the Domain/IP, port and optional Panel Path selected during first installation.

## Rollback preparation

Before a significant upgrade:

1. Create a BUB Panel backup.
2. Verify the backup can be read/decrypted.
3. Confirm database connectivity.
4. Keep the previous release assets and checksum file available.
5. Avoid replacing existing VPN PKI or unrelated system service configuration.
