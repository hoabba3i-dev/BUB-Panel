# Security Policy

## Reporting a vulnerability

Please do not publish an exploitable security issue in a public GitHub issue before a fix is available. Use the repository's private security reporting channel when enabled, or contact the maintainer privately through the official project contact listed on GitHub.

Include the affected version, component, reproducible steps, impact and any relevant sanitized logs. Never include real passwords, private keys, API tokens, recovery secrets or production user credentials.

## Operational guidance

- Use HTTPS for administrative access over untrusted networks.
- Restrict SSH access to trusted operators and prefer key-based authentication.
- Keep the Main server and managed Nodes updated.
- Back up BUB Panel state before major upgrades or migrations.
- Treat `/etc/bub-panel`, `/etc/bub-panel-agent`, database credentials and OpenVPN PKI material as sensitive.
- Do not copy an unknown CA/PKI over an existing OpenVPN deployment as a repair method.
- Verify release checksums before manual installation.

## Logging policy

Application and installer logs must not intentionally contain plaintext passwords, private keys, API tokens, recovery secrets or similar credentials. Security reports should use sanitized logs only.
