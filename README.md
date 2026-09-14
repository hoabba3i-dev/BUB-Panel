<div align="center">

# BUB Panel

### Free Multi-Service VPN Management Panel · Main + Multi-Node

<p>
  <a href="#quick-install"><img alt="Quick Install" src="https://img.shields.io/badge/Quick_Install-00C8D7?style=for-the-badge&logo=linux&logoColor=white"></a>
  <a href="https://github.com/hoabba3i-dev/BUB-Panel/releases/latest"><img alt="Latest Release" src="https://img.shields.io/badge/Latest_Release-v0.1.60-16A34A?style=for-the-badge&logo=github&logoColor=white"></a>
</p>

<p>
  <a href="https://t.me/bub_tunnel"><img alt="Telegram Channel" src="https://img.shields.io/badge/Telegram_Channel-@bub__tunnel-229ED9?style=for-the-badge&logo=telegram&logoColor=white"></a>
  <a href="https://t.me/Bubtunnel_support"><img alt="Support" src="https://img.shields.io/badge/Support-@Bubtunnel__support-229ED9?style=for-the-badge&logo=telegram&logoColor=white"></a>
  <a href="https://app.tonkeeper.com/transfer/UQBW2lkxmJl4ryQaylRz_F3ICbYdJhUjvSqKKq2OeAPnoLsl"><img alt="Donate TON" src="https://img.shields.io/badge/Donate-TON-0098EA?style=for-the-badge&logo=ton&logoColor=white"></a>
</p>

<sub>TON: <code>UQBW2lkxmJl4ryQaylRz_F3ICbYdJhUjvSqKKq2OeAPnoLsl</code></sub>

<p>
  <a href="#english"><kbd>🇬🇧 English</kbd></a>&nbsp;&nbsp;
  <a href="#persian"><kbd>🇮🇷 فارسی</kbd></a>
</p>

<p>
  <a href="https://github.com/hoabba3i-dev/BUB-Panel/releases"><img alt="Version" src="https://img.shields.io/badge/version-0.1.60-00C8D7?style=flat-square"></a>
  <a href="https://github.com/hoabba3i-dev/BUB-Panel/actions/workflows/ci.yml"><img alt="Release verification" src="https://github.com/hoabba3i-dev/BUB-Panel/actions/workflows/ci.yml/badge.svg"></a>
  <a href="https://go.dev/"><img alt="Go" src="https://img.shields.io/badge/Go-1.25%2B-00ADD8?style=flat-square&logo=go&logoColor=white"></a>
  <a href="LICENSE"><img alt="License" src="https://img.shields.io/badge/license-Free--Use-00C8D7?style=flat-square"></a>
  <a href="https://github.com/hoabba3i-dev/BUB-Panel/stargazers"><img alt="GitHub Stars" src="https://img.shields.io/github/stars/hoabba3i-dev/BUB-Panel?style=flat-square&logo=github"></a>
</p>

**One panel. Multiple VPN protocols. Main server + independently managed nodes.**

</div>

---

<a id="english"></a>

## English

BUB Panel is a multi-service VPN management platform for VPN services, users, traffic policies, remote nodes and operational tasks from one Web Panel and one interactive terminal Manager.

The public repository contains the installer, documentation, release metadata and verified runtime assets. The complete Go source tree remains private and is not published in the public Git history.

## Features

### Dashboard

The live dashboard shows system load, network throughput, connection activity and VPN transport state at a glance.

<p align="center">
  <img src="https://github.com/user-attachments/assets/d9dc5b97-4237-4355-8d1e-03a8b049c11a" alt="BUB Panel dashboard" width="820">
</p>

### VPN and proxy services

| Service | Current scope |
|---|---|
| OpenVPN | TCP + UDP, independent BUB-managed instances |
| WireGuard | Native WireGuard management |
| AmneziaWG | Obfuscated WireGuard-compatible service |
| Cisco / ocserv | TCP mode |
| IKEv2 / IPsec | BUB-managed strongSwan runtime |
| L2TP / IPsec | Shared BUB-managed IPsec runtime |
| SSTP | Managed SSTP service |
| SoftEther | Managed SoftEther service |
| Telegram Proxy | Telemt-based proxy management |

#### Service management

Each service is managed independently with its own state, ports and actions.

<p align="center">
  <img src="https://github.com/user-attachments/assets/e5ebf625-2176-4bc7-a409-4fc8795fb360" alt="BUB Panel VPN services overview" width="820">
</p>

Installation progress is displayed directly on the selected service card while BUB Panel provisions and starts it.

<p align="center">
  <img src="https://github.com/user-attachments/assets/df45bd6f-9309-43d2-b496-16c4b6f8e246" alt="BUB Panel VPN service installation progress" width="820">
</p>

#### Port management

Variable service ports can be checked and changed from the Port Manager without mixing unrelated targets or transports.

<p align="center">
  <img src="https://github.com/user-attachments/assets/69462c7b-8703-4476-9ff4-4f53069b78cc" alt="BUB Panel port manager" width="820">
</p>

### User management

- Create, disable, re-enable and delete users.
- Per-user expiration and traffic quota controls.
- Traffic accounting and online/offline visibility where supported by the service runtime.
- Client configuration generation and download.
- Bulk user operations.
- Active-session handling and reconnect blocking according to service capabilities.

#### Quick user creation

<p align="center">
  <img src="https://github.com/user-attachments/assets/fe12624e-d0b7-4d58-83e0-13bcf0b82bc8" alt="BUB Panel quick user creation" width="820">
</p>

#### User list and controls

<p align="center">
  <img src="https://github.com/user-attachments/assets/273d0c38-601e-49f5-b52f-3ed8d41db084" alt="BUB Panel user management" width="820">
</p>

#### User subscription portal

<p align="center">
  <img src="https://github.com/user-attachments/assets/5d5302e0-f86b-4da9-b779-2263b4b4c9bc" alt="BUB Panel user subscription portal" width="820">
</p>

#### Traffic and usage

<p align="center">
  <img src="https://github.com/user-attachments/assets/faa14824-0600-4014-87ba-ebdfd5e52ab1" alt="BUB Panel traffic and usage statistics" width="820">
</p>

### Main + Multi-Node

- One Main Panel controls local services and remote BUB Panel Nodes.
- Remote Nodes run the BUB Panel Agent and only the VPN services selected for that Node.
- Service state and in-progress operations are scoped by **target + service**.
- The same port may be used on separate Nodes.
- Port conflicts are checked on the selected target and transport only.
- BUB Panel never fixes a conflict by killing an unrelated listener.

#### Add a managed Node

<p align="center">
  <img src="https://github.com/user-attachments/assets/2d4b85c3-0d82-4139-9212-cac3f3329028" alt="BUB Panel add node" width="820">
</p>

### Manager

Open the terminal Manager with:

```bash
BUB-Panel
```

The Manager provides service status, start/stop/restart, diagnostics, live logs, service removal, updates, backup/restore and maintenance operations.

#### Manager-driven service installation

<p align="center">
  <img src="https://github.com/user-attachments/assets/8923c98b-66b6-448e-b6e8-f53885d518c6" alt="BUB Panel Manager VPN service installation" width="560">
</p>

## Architecture

```text
BUB Panel Main
├── Web Panel
├── Controller / API
├── Database
├── Main Server VPN services
└── Managed Nodes
    ├── BUB Panel Agent
    ├── Node-local VPN services
    └── Node-local runtime / ports
```

Remote-node lifecycle operations are scoped to BUB Panel assets. Unrelated server software and BUB Tunnel services are outside BUB Panel ownership and must not be stopped or removed by BUB Panel maintenance operations.

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for architecture notes.

## Requirements

- Linux server with `systemd`.
- Ubuntu/Debian or supported `apt` / `dnf` / `yum` environment.
- Root access for installation and VPN service management.
- `amd64` or `arm64` architecture.
- Internet access during initial package and service provisioning.
- For Multi-Node provisioning: SSH reachability from Main to the target Node.
- For automatic public HTTPS: a domain whose DNS resolves to Main plus reachable TCP `80` and `443`.

<a id="quick-install"></a>

## Quick Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/hoabba3i-dev/BUB-Panel/main/install.sh)
```

Fresh setup is interactive and covers database configuration, public host/domain, panel port, Owner credentials, optional custom path and optional Let's Encrypt HTTPS. The installer verifies architecture-specific assets against `SHA256SUMS`, preserves existing database/configuration state during upgrades, starts the panel and prints the final login URL.

### Secure web login

The Web Panel supports password login and Passkey/WebAuthn sign-in on supported secure deployments.

<p align="center">
  <img src="https://github.com/user-attachments/assets/c2d43377-72f1-4f74-997c-3a50ca5aff9c" alt="BUB Panel secure login" width="560">
</p>

### Domain and automatic HTTPS

When a domain is entered and automatic HTTPS is accepted, BUB Panel configures a dedicated Nginx virtual host, keeps the Go listener on loopback behind the reverse proxy, obtains a Let's Encrypt certificate, redirects HTTP to HTTPS, enables renewal and preserves unrelated Nginx virtual hosts.

Example:

```text
https://panel.example.com/
https://panel.example.com/bub-panel/
```

If an IP address is used, or automatic HTTPS is declined, the installer prints the selected HTTP endpoint. Configure trusted TLS before exposing an administrative HTTP endpoint to an untrusted network.

## Databases

BUB Panel supports:

- **SQLite** using the pure-Go `modernc.org/sqlite` runtime driver.
- **PostgreSQL** using `pgx/v5` with a persistent connection pool.

Upgrade paths are designed to preserve database state, users, service assignments, node definitions and BUB Panel configuration.

## Data safety and ownership

BUB Panel distinguishes between an OS package being present and a service being **BUB-managed**. Full Uninstall and per-service removal are ownership-aware and must preserve unrelated services, packages and listeners when ownership cannot be proven.

Upgrade and backup paths are designed to preserve PostgreSQL/SQLite state, users, service assignments, node definitions, BUB Panel configuration, OpenVPN PKI/CRL, BUB-managed service ownership state and secrets required for restore/disaster recovery.

OpenVPN PKI must never be reinitialized as a shortcut when an existing real CA/PKI is present.

### Backup & Restore

<p align="center">
  <img src="https://github.com/user-attachments/assets/444d2c7c-eefe-4bf7-a8d0-14faaad44ae8" alt="BUB Panel backup and restore" width="820">
</p>

## Security

BUB Panel includes session management, login history, audit events, CSRF validation, SameSite/HttpOnly cookies, secure-cookie behavior behind trusted HTTPS, login/API rate limiting, brute-force protection, security headers, scoped access controls, encrypted backup handling, bounded command execution and explicit node/service targeting.

Passwords, private keys, API tokens and recovery secrets must never be written to application logs. Security reports should follow [SECURITY.md](SECURITY.md).

### Security Center

<p align="center">
  <img src="https://github.com/user-attachments/assets/e47e295e-1b6a-4731-96f5-f2b858523c22" alt="BUB Panel Security Center" width="820">
</p>

## Updates

Updates are available from **Manager → Update** and use the official GitHub release channel. The updater downloads architecture-specific binaries and the runtime bundle, verifies SHA-256 checksums and preserves existing database/configuration state.

```bash
bub-panel --version
bub-panel-agent --version
```

## Health and readiness

```text
GET /api/health
GET /api/ready
```

`/api/health` reports application/process health. `/api/ready` also probes the configured database and returns HTTP `503` when required dependencies are not ready.

## Performance notes

- Prefer **WireGuard** when maximum throughput and low CPU usage are the main goals and the protocol is reachable.
- Prefer **OpenVPN UDP** for lower latency; OpenVPN TCP is useful when UDP is blocked.
- **AmneziaWG** adds obfuscation-related overhead for environments where that tradeoff is useful.
- BUB Panel enables **BBR + fq** only when the host kernel reports BBR support.
- Cisco/ocserv remains TCP-only in v0.1.60.

## Release assets

An official v0.1.60 release contains exactly:

```text
bub-panel-linux-amd64
bub-panel-linux-arm64
bub-panel-agent-linux-amd64
bub-panel-agent-linux-arm64
BUB-Panel-runtime-v0.1.60.tar.gz
SHA256SUMS
```

Release binaries are produced from the private source tree, stripped/obfuscated for distribution and verified before publication.

## Repository policy

The public repository contains installer, documentation, release metadata, verification workflow and official release assets. The complete BUB Panel Go source tree is not part of the public Git history. BUB Panel is free to use under [LICENSE](LICENSE), but it is not presented as an open-source project.

## Documentation

- [Architecture](docs/ARCHITECTURE.md)
- [Installation and upgrades](docs/INSTALLATION.md)
- [Security model](SECURITY.md)
- [Changelog](CHANGELOG.md)
- [Releases](https://github.com/hoabba3i-dev/BUB-Panel/releases)

---

<a id="persian"></a>

## فارسی

**BUB Panel** یک پنل مدیریت چندسرویسی VPN است که برای مدیریت سرور اصلی، نودهای راه دور، کاربران، محدودیت ترافیک، تنظیمات اتصال، فایل‌های کانفیگ و عملیات نگهداری از یک رابط وب و یک Manager ترمینالی طراحی شده است.

مخزن عمومی شامل نصب‌کننده، مستندات، اطلاعات Release و فایل‌های Runtime رسمی است. سورس کامل Go به‌صورت عمومی داخل GitHub منتشر نمی‌شود.

### امکانات اصلی

#### داشبورد

داشبورد زنده وضعیت منابع سیستم، سرعت شبکه، اتصال‌ها و وضعیت سرویس‌های VPN را به‌صورت یکجا نمایش می‌دهد.

<p align="center">
  <img src="https://github.com/user-attachments/assets/d9dc5b97-4237-4355-8d1e-03a8b049c11a" alt="داشبورد BUB Panel" width="820">
</p>

#### سرویس‌های قابل مدیریت

| سرویس | وضعیت / کاربرد |
|---|---|
| OpenVPN | TCP و UDP به‌صورت مستقل |
| WireGuard | مدیریت WireGuard استاندارد |
| AmneziaWG | نسخه سازگار با WireGuard با قابلیت‌های Obfuscation |
| Cisco / ocserv | حالت TCP |
| IKEv2 / IPsec | مبتنی بر Runtime مدیریت‌شده strongSwan |
| L2TP / IPsec | Runtime مشترک IPsec مدیریت‌شده توسط BUB |
| SSTP | نصب و مدیریت سرویس SSTP |
| SoftEther | نصب و مدیریت SoftEther |
| Telegram Proxy | مدیریت Proxy مبتنی بر Telemt |

##### مدیریت سرویس‌های VPN

هر سرویس به‌صورت مستقل با وضعیت، پورت‌ها و عملیات مخصوص خودش مدیریت می‌شود.

<p align="center">
  <img src="https://github.com/user-attachments/assets/e5ebf625-2176-4bc7-a409-4fc8795fb360" alt="نمای کلی سرویس‌های VPN در BUB Panel" width="820">
</p>

هنگام نصب، روند نصب و راه‌اندازی همان سرویس مستقیماً داخل کارت سرویس نمایش داده می‌شود.

<p align="center">
  <img src="https://github.com/user-attachments/assets/df45bd6f-9309-43d2-b496-16c4b6f8e246" alt="نصب سرویس VPN توسط BUB Panel" width="820">
</p>

##### مدیریت پورت‌ها

<p align="center">
  <img src="https://github.com/user-attachments/assets/69462c7b-8703-4476-9ff4-4f53069b78cc" alt="مدیریت پورت‌ها در BUB Panel" width="820">
</p>

#### مدیریت کاربران

- ساخت، غیرفعال‌کردن، فعال‌کردن و حذف کاربر.
- تعیین تاریخ انقضا و حجم مصرفی برای هر کاربر.
- نمایش و ثبت مصرف ترافیک در سرویس‌هایی که Runtime آن پشتیبانی می‌کند.
- تولید و دانلود کانفیگ کلاینت.
- عملیات گروهی روی کاربران.
- کنترل Session فعال و جلوگیری از Reconnect بر اساس قابلیت هر پروتکل.

##### ساخت سریع کاربر

<p align="center">
  <img src="https://github.com/user-attachments/assets/fe12624e-d0b7-4d58-83e0-13bcf0b82bc8" alt="ساخت سریع کاربر در BUB Panel" width="820">
</p>

##### فهرست و مدیریت کاربران

<p align="center">
  <img src="https://github.com/user-attachments/assets/273d0c38-601e-49f5-b52f-3ed8d41db084" alt="مدیریت کاربران در BUB Panel" width="820">
</p>

##### پنل اشتراک کاربر

<p align="center">
  <img src="https://github.com/user-attachments/assets/5d5302e0-f86b-4da9-b779-2263b4b4c9bc" alt="صفحه اشتراک کاربر BUB Panel" width="820">
</p>

##### آمار و مصرف ترافیک

<p align="center">
  <img src="https://github.com/user-attachments/assets/faa14824-0600-4014-87ba-ebdfd5e52ab1" alt="آمار و مصرف ترافیک در BUB Panel" width="820">
</p>

### معماری Main + Multi-Node

یک Main Panel می‌تواند سرویس‌های روی سرور اصلی و چند Node مستقل را مدیریت کند. هر Node فقط BUB Panel Agent و سرویس‌هایی را اجرا می‌کند که برای همان Node انتخاب شده‌اند و وضعیت عملیات هر سرویس بر اساس **Target + Service** جدا نگه داشته می‌شود.

```text
BUB Panel Main
├── Web Panel
├── Controller / API
├── Database
├── VPN Services روی Main
└── Managed Nodes
    ├── BUB Panel Agent
    ├── VPN Services همان Node
    └── Port / Runtime همان Node
```

استفاده از یک پورت یکسان روی دو Node مختلف مجاز است. بررسی تداخل پورت فقط روی همان Target و Transport انجام می‌شود و BUB Panel برای آزادکردن پورت، سرویس نامرتبط را Kill نمی‌کند.

#### افزودن Node مدیریت‌شده

<p align="center">
  <img src="https://github.com/user-attachments/assets/2d4b85c3-0d82-4139-9212-cac3f3329028" alt="افزودن Node در BUB Panel" width="820">
</p>

### نصب سریع

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/hoabba3i-dev/BUB-Panel/main/install.sh)
```

در نصب Fresh تنظیم دیتابیس، دامنه/IP، پورت Web Panel، Owner، مسیر اختصاصی پنل و در صورت استفاده از دامنه HTTPS خودکار Let's Encrypt انجام می‌شود. فایل‌های Release قبل از نصب با SHA-256 بررسی می‌شوند و در Upgrade اطلاعات موجود حفظ می‌شوند.

بعد از نصب Manager را با دستور زیر باز کنید:

```bash
BUB-Panel
```

#### نصب سرویس از Manager

<p align="center">
  <img src="https://github.com/user-attachments/assets/8923c98b-66b6-448e-b6e8-f53885d518c6" alt="نصب سرویس VPN از Manager BUB Panel" width="560">
</p>

#### ورود امن به Web Panel

<p align="center">
  <img src="https://github.com/user-attachments/assets/c2d43377-72f1-4f74-997c-3a50ca5aff9c" alt="صفحه ورود امن BUB Panel" width="560">
</p>

### دامنه و HTTPS خودکار

اگر دامنه وارد شود و HTTPS خودکار تأیید شود، BUB Panel Virtual Host اختصاصی Nginx را تنظیم می‌کند، Web App را پشت Reverse Proxy نگه می‌دارد، Certificate رایگان Let's Encrypt می‌گیرد، HTTP را به HTTPS ریدایرکت می‌کند و به Virtual Hostهای نامرتبط دست نمی‌زند.

```text
https://panel.example.com/
https://panel.example.com/bub-panel/
```

### دیتابیس

- **SQLite** با Driver کاملاً Go یعنی `modernc.org/sqlite`.
- **PostgreSQL** با `pgx/v5` و Connection Pool دائمی.

### تشخیص صحیح نصب سرویس‌ها

وجود یک Package در سیستم به معنی نصب‌شدن آن توسط BUB Panel نیست. Full Uninstall و Remove Service بر اساس Ownership واقعی BUB عمل می‌کنند و نباید سرویس‌ها، Packageها یا Listenerهای نامرتبط را حذف کنند.

### امنیت

بخش مدیریتی شامل مدیریت Session، Login History، Audit Events، CSRF Protection، HttpOnly/SameSite Cookie، Secure Cookie در HTTPS، Rate Limit، محافظت Brute-force، Security Headerها، Scope دسترسی، Backup رمزگذاری‌شده و اجرای Command محدود و Target-aware است.

رمز عبور، Private Key، API Token و Recovery Secret نباید وارد Log برنامه شوند.

#### مرکز امنیت

<p align="center">
  <img src="https://github.com/user-attachments/assets/e47e295e-1b6a-4731-96f5-f2b858523c22" alt="مرکز امنیت BUB Panel" width="820">
</p>

### حفظ اطلاعات و Backup

Upgrade و Backup برای حفظ دیتابیس، کاربران، تنظیمات سرویس‌ها، Nodeها، تنظیمات BUB Panel، PKI/CRL مربوط به OpenVPN، Ownership state و اطلاعات لازم برای Restore/Disaster Recovery طراحی شده‌اند.

در OpenVPN نباید برای Repair کردن، CA/PKI واقعی موجود را با `init-pki` جدید جایگزین کرد.

#### Backup & Restore

<p align="center">
  <img src="https://github.com/user-attachments/assets/444d2c7c-eefe-4bf7-a8d0-14faaad44ae8" alt="بکاپ و بازیابی در BUB Panel" width="820">
</p>

### آپدیت

آپدیت از داخل **Manager → Update** انجام می‌شود. فایل‌های Release بر اساس معماری سیستم دانلود می‌شوند و قبل از نصب SHA-256 آن‌ها بررسی می‌شود.

```bash
bub-panel --version
bub-panel-agent --version
```

### Health Check

```text
GET /api/health
GET /api/ready
```

### فایل‌های Release رسمی v0.1.60

```text
bub-panel-linux-amd64
bub-panel-linux-arm64
bub-panel-agent-linux-amd64
bub-panel-agent-linux-arm64
BUB-Panel-runtime-v0.1.60.tar.gz
SHA256SUMS
```

### سیاست مخزن

BUB Panel رایگان است، اما سورس کامل پروژه در مخزن عمومی قرار نمی‌گیرد. GitHub عمومی برای Installer، مستندات، Verification و Releaseهای رسمی استفاده می‌شود.

### لینک‌ها

- [معماری](docs/ARCHITECTURE.md)
- [راهنمای نصب و آپدیت](docs/INSTALLATION.md)
- [امنیت](SECURITY.md)
- [تغییرات نسخه‌ها](CHANGELOG.md)
- [Releaseها](https://github.com/hoabba3i-dev/BUB-Panel/releases)

---

<div align="center">

**BUB Panel v0.1.60**  
Free multi-service VPN management for Main + Multi-Node deployments.

<a href="https://github.com/hoabba3i-dev/BUB-Panel/stargazers"><img alt="Star BUB Panel" src="https://img.shields.io/badge/⭐_Star_BUB_Panel_on_GitHub-00C8D7?style=for-the-badge&logo=github&logoColor=white"></a>

</div>

## Manager port-first installation / نصب پورت قبل از پروتکل

When a variable-port service is installed from `BUB-Panel` Manager, the Manager asks for its port **before** package/config/service installation starts. Pressing Enter keeps the safe default. OpenVPN asks `TCP port` first and then `UDP port`; its default is `1194` for both transports instead of TCP/443. WireGuard, AmneziaWG, Cisco/ocserv, SSTP, SoftEther and Telegram Proxy use the same port-first flow. Ports `80` and `443` are reserved for the Web/HTTPS endpoint. IKEv2/IPsec (`UDP 500/4500`) and L2TP/IPsec (`UDP 500/4500/1701`) are protocol-fixed and are not prompted.

در نصب سرویس‌هایی که پورتشان قابل تغییر است از داخل Manager، **قبل از شروع نصب** پورت پرسیده می‌شود. اگر فقط Enter بزنید مقدار پیش‌فرض امن استفاده می‌شود. برای OpenVPN ابتدا `TCP port` و بعد `UDP port` پرسیده می‌شود و TCP و UDP هر دو به‌صورت پیش‌فرض `1194` هستند. WireGuard، AmneziaWG، Cisco/ocserv، SSTP، SoftEther و Telegram Proxy نیز همین منطق را دارند. پورت‌های `80` و `443` برای Web/HTTPS پنل رزرو هستند. IKEv2 و L2TP چون پورت‌های استاندارد ثابت دارند، سؤال پورت ندارند.