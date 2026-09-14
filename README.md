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

BUB Panel is a multi-service VPN management platform designed to manage VPN services, users, traffic policies, remote nodes and operational tasks from one web interface and one interactive Manager.

The public repository contains the installer, documentation, release metadata and verified runtime assets. The complete Go source tree remains private and is not published in the public Git history.

## Features

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

### User management

- Create, disable, re-enable and delete users.
- Per-user expiration and traffic quota controls.
- Traffic accounting and online/offline visibility where supported by the service runtime.
- Client configuration generation and download.
- Bulk user operations.
- Active-session handling and reconnect blocking according to service capabilities.

### Main + Multi-Node

- One Main Panel controls local services and remote BUB Panel Nodes.
- Remote Nodes run the BUB Panel Agent and only the VPN services selected for that Node.
- Service state and in-progress operations are scoped by **target + service**.
- The same port may be used on separate Nodes.
- Port conflicts are checked on the selected target and transport only.
- BUB Panel never fixes a conflict by killing an unrelated listener.

### Manager

After installation, open the terminal Manager with:

```bash
BUB-Panel
```

The Manager provides service status, start/stop/restart, diagnostics, live logs, service removal, update handling, backup/restore operations and BUB Panel maintenance tasks.

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

Remote-node lifecycle operations are intentionally scoped to BUB Panel assets. Unrelated server software and BUB Tunnel services are outside BUB Panel ownership and must not be stopped or removed by BUB Panel maintenance operations.

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for the architecture notes.

## Requirements

- Linux server with `systemd`.
- Ubuntu/Debian or supported `apt` / `dnf` / `yum` environment.
- Root access for installation and VPN service management.
- `amd64` or `arm64` architecture.
- Internet access during initial package and service provisioning.
- For Multi-Node provisioning: SSH reachability from Main to the target Node.
- For automatic public HTTPS: a domain whose DNS resolves to the Main server and reachable TCP ports `80` and `443`.

## Quick Install

Install the latest official release on the Main server:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/hoabba3i-dev/BUB-Panel/main/install.sh)
```

On a fresh installation, the setup flow is intentionally interactive:

```text
Database setup
      ↓
Domain / IP
      ↓
Panel port
      ↓
Owner username
      ↓
Owner password
      ↓
Custom panel path? [y/N]
      ↓
If a domain is used: Let's Encrypt HTTPS? [Y/n]
      ↓
Final installation + service start + health checks
      ↓
Final panel URL and login information
      ↓
Press Enter
      ↓
BUB-Panel Manager
```

The installer downloads the architecture-specific release assets, verifies them against `SHA256SUMS`, preserves existing configuration/database state during upgrades, creates the initial Owner account on a fresh install, starts the panel and prints the final login URL.

### Domain and automatic HTTPS

When a domain is entered and automatic HTTPS is accepted, BUB Panel:

- verifies the domain setup required for certificate issuance;
- configures a dedicated BUB Panel Nginx virtual host;
- keeps the Go web listener on loopback behind the reverse proxy;
- obtains a Let's Encrypt certificate;
- redirects HTTP to HTTPS;
- enables certificate renewal;
- uses secure public URLs and secure-cookie behavior;
- leaves unrelated Nginx virtual hosts untouched.

Example:

```text
https://panel.example.com/
```

With a custom panel path:

```text
https://panel.example.com/bub-panel/
```

If an IP address is used, or automatic HTTPS is declined, the installer prints the selected HTTP endpoint. Configure trusted TLS before exposing an administrative HTTP endpoint to an untrusted network.

## Databases

BUB Panel supports:

- **SQLite** using the pure-Go `modernc.org/sqlite` runtime driver.
- **PostgreSQL** using `pgx/v5` with a persistent connection pool.

Application queries do not spawn `sqlite3` or `psql` processes. Database CLI tools may still be used by administrative migration, backup or diagnostic scripts when appropriate.

Upgrade paths are designed to preserve database state, users, service assignments, node definitions and BUB Panel configuration.

## Data safety and ownership

BUB Panel distinguishes between an OS package being present and a service being **BUB-managed**. The Manager should report `INSTALLED` only when BUB Panel ownership/configuration state exists; a pre-existing system package alone is not treated as a BUB-installed service.

Full Uninstall and per-service removal are ownership-aware. BUB Panel must preserve unrelated services, packages and listeners when ownership cannot be proven.

Upgrade and backup paths are designed to preserve:

- PostgreSQL / SQLite state;
- users and service assignments;
- node definitions;
- BUB Panel configuration;
- OpenVPN PKI, EasyRSA state and CRL;
- BUB-managed service ownership state;
- secrets required for restore and disaster recovery.

OpenVPN PKI must never be reinitialized as a shortcut when an existing real CA/PKI is present.

## Security

BUB Panel includes administrative security controls such as:

- password hashing/derivation;
- session management and login history;
- audit events;
- CSRF validation for cookie-authenticated mutations;
- SameSite and HttpOnly session cookies;
- secure-cookie behavior behind trusted HTTPS;
- login/API rate limiting and brute-force protections;
- security headers including CSP, frame denial and MIME-sniffing protection;
- scoped administrative access controls;
- encrypted backup handling;
- bounded command execution;
- explicit node/service targeting.

Passwords, private keys, API tokens and recovery secrets must never be written to application logs. Security reports should follow [SECURITY.md](SECURITY.md).

## Updates

Updates are available from **Manager → Update** and use the official GitHub release channel.

The updater downloads architecture-specific binaries and the runtime bundle, verifies SHA-256 checksums before installation and preserves existing database/configuration state.

Check installed versions with:

```bash
bub-panel --version
bub-panel-agent --version
```

## Health and readiness

```text
GET /api/health
GET /api/ready
```

`/api/health` reports application/process health. `/api/ready` also probes the configured database and returns HTTP `503` when dependencies required by the panel are not ready.

## Performance notes

- Prefer **WireGuard** when maximum throughput and low CPU usage are the main goals and the protocol is reachable.
- Prefer **OpenVPN UDP** for lower latency; OpenVPN TCP is useful when UDP is blocked.
- **AmneziaWG** adds obfuscation-related overhead and is intended for environments where that tradeoff is useful.
- BUB Panel enables **BBR + fq** only when the host kernel reports BBR support; otherwise the existing congestion-control algorithm is left unchanged.
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

The public repository contains:

- installer;
- documentation;
- release metadata;
- verification workflow;
- official release assets.

The complete BUB Panel Go source tree is not part of the public Git history. BUB Panel is free to use under the terms in [LICENSE](LICENSE), but it is not presented as an open-source project.

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

#### سرویس‌های قابل مدیریت

| سرویس | وضعیت / کاربرد |
|---|---|
| OpenVPN | TCP و UDP به‌صورت مستقل |
| WireGuard | مدیریت WireGuard استاندارد |
| AmneziaWG | نسخه سازگار با WireGuard با قابلیت‌های Obfuscation |
| Cisco / ocserv | حالت TCP |
| IKEv2 / IPsec | مبتنی بر Runtime مدیریت‌شده strongSwan |
| L2TP / IPsec | با Runtime مشترک IPsec مدیریت‌شده توسط BUB |
| SSTP | نصب و مدیریت سرویس SSTP |
| SoftEther | نصب و مدیریت SoftEther |
| Telegram Proxy | مدیریت Proxy مبتنی بر Telemt |

#### مدیریت کاربران

- ساخت، غیرفعال‌کردن، فعال‌کردن و حذف کاربر.
- تعیین تاریخ انقضا و حجم مصرفی برای هر کاربر.
- نمایش و ثبت مصرف ترافیک در سرویس‌هایی که Runtime آن پشتیبانی می‌کند.
- تولید و دانلود کانفیگ کلاینت.
- عملیات گروهی روی کاربران.
- کنترل Session فعال و جلوگیری از Reconnect بر اساس قابلیت هر پروتکل.

### معماری Main + Multi-Node

یک Main Panel می‌تواند سرویس‌های روی سرور اصلی و چند Node مستقل را مدیریت کند.

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

هر Node فقط BUB Panel Agent و سرویس‌هایی را اجرا می‌کند که برای همان Node انتخاب شده‌اند. وضعیت و عملیات هر سرویس بر اساس **Target + Service** جدا نگه داشته می‌شود.

استفاده از یک پورت یکسان روی دو Node مختلف مجاز است. بررسی تداخل پورت فقط روی همان Target و Transport انجام می‌شود و BUB Panel برای آزادکردن پورت، سرویس نامرتبط را Kill نمی‌کند.

### نصب سریع

روی سرور Main این دستور را اجرا کنید:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/hoabba3i-dev/BUB-Panel/main/install.sh)
```

در نصب Fresh ترتیب Setup به این شکل است:

```text
تنظیم دیتابیس
      ↓
دامنه یا IP
      ↓
پورت Web Panel
      ↓
نام کاربری Owner
      ↓
رمز عبور Owner
      ↓
آیا Panel Path اختصاصی نیاز دارید؟ [y/N]
      ↓
اگر دامنه وارد شده باشد: HTTPS خودکار با Let's Encrypt؟ [Y/n]
      ↓
نصب نهایی + Start سرویس + Health Check
      ↓
نمایش URL و اطلاعات ورود
      ↓
Enter
      ↓
ورود به BUB-Panel Manager
```

بعد از نصب، هر زمان خواستید Manager را باز کنید:

```bash
BUB-Panel
```

### دامنه و HTTPS خودکار

اگر به‌جای IP یک دامنه وارد کنید و HTTPS خودکار را تأیید کنید، BUB Panel برای همان دامنه:

- شرایط لازم برای صدور Certificate را بررسی می‌کند؛
- Virtual Host اختصاصی Nginx می‌سازد؛
- Web App اصلی را پشت Reverse Proxy روی Loopback نگه می‌دارد؛
- Certificate رایگان Let's Encrypt دریافت می‌کند؛
- HTTP را به HTTPS ریدایرکت می‌کند؛
- تمدید خودکار Certificate را فعال می‌کند؛
- Secure Cookie و رفتار HTTPS را فعال می‌کند؛
- به Virtual Hostهای نامرتبط Nginx دست نمی‌زند.

نمونه آدرس نهایی:

```text
https://panel.example.com/
```

اگر Panel Path انتخاب کرده باشید:

```text
https://panel.example.com/bub-panel/
```

اگر IP وارد شود یا HTTPS خودکار رد شود، نصب‌کننده آدرس HTTP با پورت انتخاب‌شده را نمایش می‌دهد. برای پنل مدیریتی که روی اینترنت در دسترس است استفاده از TLS معتبر توصیه می‌شود.

### دیتابیس

BUB Panel از دو حالت اصلی پشتیبانی می‌کند:

- **SQLite** با Driver کاملاً Go یعنی `modernc.org/sqlite`.
- **PostgreSQL** با `pgx/v5` و Connection Pool دائمی.

در Queryهای عادی برنامه، برای هر درخواست Process جداگانه `sqlite3` یا `psql` اجرا نمی‌شود. ابزارهای CLI دیتابیس فقط در عملیات مدیریتی مثل Backup، Migration یا Diagnostic در صورت نیاز استفاده می‌شوند.

### تشخیص صحیح نصب سرویس‌ها

وجود یک Package در سیستم به معنی نصب‌شدن آن توسط BUB Panel نیست.

مثلاً اگر `/usr/sbin/openvpn` روی سیستم باقی مانده باشد ولی Config و Ownership مربوط به BUB حذف شده باشد، Manager باید نمایش دهد:

```text
OpenVPN : NOT INSTALLED
```

Full Uninstall و Remove Service بر اساس Ownership واقعی BUB عمل می‌کنند و نباید سرویس‌ها، Packageها یا Listenerهای نامرتبط را حذف کنند.

### امنیت

بخش مدیریتی BUB Panel شامل لایه‌های امنیتی مختلف است، از جمله:

- مدیریت Sessionها؛
- Login History و Audit Events؛
- CSRF Protection؛
- HttpOnly / SameSite Cookie؛
- Secure Cookie در HTTPS؛
- Rate Limit برای Login و API؛
- محافظت در برابر Brute-force؛
- Security Headerها مثل CSP و Frame Deny؛
- سطح دسترسی و Scope برای عملیات مدیریتی؛
- Backup رمزنگاری‌شده؛
- اجرای Command محدود و Target-aware.

رمز عبور، Private Key، API Token و Recovery Secret نباید وارد Log برنامه شوند.

### حفظ اطلاعات و Backup

مسیرهای Upgrade و Backup برای حفظ موارد زیر طراحی شده‌اند:

- دیتابیس PostgreSQL یا SQLite؛
- کاربران و تنظیمات سرویس‌ها؛
- اطلاعات Nodeها؛
- تنظیمات BUB Panel؛
- PKI و CRL مربوط به OpenVPN؛
- Ownership state سرویس‌های BUB؛
- اطلاعات لازم برای Restore و Disaster Recovery.

در OpenVPN نباید برای Repair کردن، CA/PKI واقعی موجود را با `init-pki` جدید جایگزین کرد.

### آپدیت

آپدیت از داخل **Manager → Update** انجام می‌شود. فایل‌های Release بر اساس معماری سیستم دانلود می‌شوند و قبل از نصب SHA-256 آن‌ها بررسی می‌شود.

نمایش نسخه:

```bash
bub-panel --version
bub-panel-agent --version
```

### Health Check

```text
GET /api/health
GET /api/ready
```

`/api/health` سلامت خود برنامه را گزارش می‌دهد. `/api/ready` علاوه بر آن وابستگی دیتابیس را هم بررسی می‌کند و اگر پنل برای پاسخ‌گویی کامل آماده نباشد HTTP `503` برمی‌گرداند.

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

When a variable-port service is installed from `BUB-Panel` Manager, the Manager asks for its port **before** package/config/service installation starts. Pressing Enter keeps the safe default. OpenVPN asks `TCP port` first and then `UDP port`; its default is now `1194` for both transports instead of TCP/443. WireGuard, AmneziaWG, Cisco/ocserv, SSTP, SoftEther, and Telegram Proxy use the same port-first flow. Ports `80` and `443` are reserved for the Web/HTTPS endpoint. IKEv2/IPsec (`UDP 500/4500`) and L2TP/IPsec (`UDP 500/4500/1701`) are protocol-fixed and are not prompted.

در نصب سرویس‌هایی که پورتشان قابل تغییر است از داخل Manager، **قبل از شروع نصب** پورت پرسیده می‌شود. اگر فقط Enter بزنید مقدار پیش‌فرض امن استفاده می‌شود. برای OpenVPN ابتدا `TCP port` و بعد `UDP port` پرسیده می‌شود و دیگر TCP روی `443` پیش‌فرض نیست؛ TCP و UDP هر دو به‌صورت پیش‌فرض `1194` هستند. برای WireGuard، AmneziaWG، Cisco/ocserv، SSTP، SoftEther و Telegram Proxy نیز همین منطق اجرا می‌شود. پورت‌های `80` و `443` برای Web/HTTPS پنل رزرو هستند. IKEv2 و L2TP چون پورت‌های استاندارد ثابت دارند، سؤال پورت ندارند.
