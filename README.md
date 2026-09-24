<div align="center">

# BUB Panel

### Free Multi-Service VPN Management Panel · Main + Multi-Node

<p>
  <a href="#quick-install"><img alt="Quick Install" src="https://img.shields.io/badge/Quick_Install-00C8D7?style=for-the-badge&logo=linux&logoColor=white"></a>
  <a href="https://github.com/hoabba3i-dev/BUB-Panel/releases/latest"><img alt="Latest Release" src="https://img.shields.io/badge/Latest_Release-v0.2.1-16A34A?style=for-the-badge&logo=github&logoColor=white"></a>
</p>

<p>
  <a href="#donate"><img alt="Donate" src="https://img.shields.io/badge/❤️_Donate-Support-00C8D7?style=for-the-badge"></a>
  <a href="https://t.me/bub_tunnel"><img alt="Telegram Channel" src="https://img.shields.io/badge/Telegram-Channel-229ED9?style=for-the-badge&logo=telegram&logoColor=white"></a><img alt="Telegram Channel" src="https://img.shields.io/badge/Telegram-Channel-229ED9?style=for-the-badge&logo=telegram&logoColor=white"></a>
  <a href="https://t.me/Bubtunnel_support"><img alt="Support" src="https://img.shields.io/badge/Telegram-Support-229ED9?style=for-the-badge&logo=telegram&logoColor=white"></a>
</p>

<p>
  <a href="#english"><kbd>🇬🇧 English</kbd></a>&nbsp;&nbsp;
  <a href="#persian"><kbd>🇮🇷 فارسی</kbd></a>
</p>

<p>
  <a href="https://github.com/hoabba3i-dev/BUB-Panel/releases"><img alt="Version" src="https://img.shields.io/badge/version-0.2.1-00C8D7?style=flat-square"></a>
  <a href="LICENSE"><img alt="License" src="https://img.shields.io/badge/license-Free--Use-00C8D7?style=flat-square"></a>
  <a href="https://github.com/hoabba3i-dev/BUB-Panel/stargazers"><img alt="GitHub Stars" src="https://img.shields.io/github/stars/hoabba3i-dev/BUB-Panel?style=flat-square&logo=github"></a>
</p>

**One panel. Multiple VPN protocols. Main server + independently managed nodes.**

</div>

---

<a id="english"></a>

## English

BUB Panel is a multi-service VPN management platform for managing VPN services, users, traffic limits, remote nodes and operational tasks from one Web Panel and one interactive terminal Manager.

The public repository contains the installer, documentation, release metadata and official runtime assets. The complete Go source tree is not published in the public Git history.

### Dashboard

<div align="center">
  <img src="https://github.com/user-attachments/assets/dce63d83-78c5-4cd5-b77d-6a1d4ae722d8" alt="BUB Panel dashboard" width="720" />
</div>

## Features

### VPN and proxy services

| Service | Management scope |
|---|---|
| OpenVPN | Independent TCP + UDP instances |
| WireGuard | Native WireGuard management |
| AmneziaWG | WireGuard-compatible obfuscated service |
| Cisco / ocserv | TCP mode |
| IKEv2 / IPsec | Managed strongSwan runtime |
| L2TP / IPsec | Managed IPsec runtime |
| SSTP | Managed SSTP service |
| SoftEther | Managed SoftEther service |
| Telegram Proxy | Telemt-based proxy management |

### User management

- Create, disable, re-enable and delete users.
- Per-user expiration and traffic quota controls.
- Traffic accounting and online/offline visibility where supported.
- Client configuration generation and download.
- Bulk user operations.
- Active-session handling according to service capabilities.

<div align="center">
  <img src="https://github.com/user-attachments/assets/441a4755-1585-4f06-b4f0-9e1742018194" alt="BUB Panel user management" width="720" />
</div>

### Telegram Sales Bot

BUB Panel includes an integrated Telegram Sales Bot for presenting services and handling the service-order flow from Telegram. Bot configuration and sales content are managed from the Panel, including categories, products/services and payment information.

For the initial setup, use this simple order:

1. Create the required **category** first.
2. Create the **product/service** and assign it to that category.
3. Configure and verify the **payment information** used for customer orders.

When multiple panels or nodes are used, keep categories and products assigned to the intended panel so customers see the correct services.

### Main + Multi-Node

- One Main Panel manages local services and remote BUB Panel Nodes.
- Remote Nodes run the BUB Panel Agent and the VPN services selected for that Node.
- Service state and operations are isolated by target and service.
- The same port may be used on different Nodes.
- Port conflicts are checked on the selected target and transport.
- BUB Panel does not stop an unrelated listener to reclaim a port.

### Reliability and operations

- Preflight checks before service changes.
- Change preview, snapshots and rollback protection.
- Configuration drift and revision tracking.
- Retry backoff and hold-down behavior to reduce flapping.
- Bounded logs, diagnostics, health/readiness endpoints and audit events.
- Ownership-aware update and uninstall paths designed to preserve unrelated services.

### Security

- Session management and login history.
- Audit events and scoped administrative access.
- CSRF protection and secure session-cookie behavior.
- Login/API rate limiting and brute-force protection.
- Security headers including CSP, frame denial and MIME-sniffing protection.
- Encrypted backup handling.
- Explicit node/service targeting.
- Passwords, private keys, API tokens and recovery secrets must not be written to application logs.

## Architecture

```text
BUB Panel Main
├── Web Panel
├── Controller / API
├── Database
├── Main Server VPN Services
└── Managed Nodes
    ├── BUB Panel Agent
    └── Node-local VPN Services
```

BUB Panel maintenance operations are scoped to BUB Panel-owned assets. Unrelated server software is outside BUB Panel ownership.

## Requirements

- Linux server with `systemd`.
- Ubuntu/Debian or a supported `apt` / `dnf` / `yum` environment.
- Root access for installation and VPN service management.
- `amd64` or `arm64` architecture.
- Internet access during initial provisioning.
- SSH reachability from Main to remote Nodes when Multi-Node is used.
- For automatic public HTTPS: a domain pointing to Main and reachable TCP ports `80` and `443`.

<a id="quick-install"></a>

## Quick Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/hoabba3i-dev/BUB-Panel/main/install.sh)
```

Fresh setup asks for the database, domain or IP, Panel port, Owner credentials, optional custom Panel path and optional Let's Encrypt HTTPS. The installer verifies release assets before installation and preserves existing BUB Panel state during normal upgrades.

After installation, open the terminal Manager with:

```bash
BUB-Panel
```

### Variable service ports

For services with a configurable port, the Manager asks for the port before installation starts. OpenVPN asks for TCP and UDP independently and defaults to `1194` for both. Ports `80` and `443` are reserved for the Web/HTTPS endpoint. IKEv2/IPsec and L2TP/IPsec use their protocol-defined ports and are not prompted.

## Database

BUB Panel supports SQLite through `modernc.org/sqlite` and PostgreSQL through `pgx/v5`.

Normal upgrade paths are designed to preserve database state, users, service assignments, node definitions and BUB Panel configuration.

## Updates

Updates are available from **Manager → Update** and use the official GitHub release channel. Downloaded assets are checksum-verified before installation.

```bash
bub-panel --version
bub-panel-agent --version
```

## Health and readiness

```text
GET /api/health
GET /api/ready
```

`/api/health` reports application health. `/api/ready` also checks required dependencies and returns HTTP `503` when the panel is not ready to serve normally.

## Documentation

- [Architecture](docs/ARCHITECTURE.md)
- [Installation and upgrades](docs/INSTALLATION.md)
- [Security](SECURITY.md)
- [Changelog](CHANGELOG.md)
- [Releases](https://github.com/hoabba3i-dev/BUB-Panel/releases)

---

<a id="persian"></a>

<div dir="rtl">

## فارسی

**BUB Panel** یک پنل برای مدیریت چند سرویس وی‌پی‌ان است. با یک پنل وب و یک مدیر ترمینالی می‌توان سرور اصلی، نودهای راه دور، کاربران، حجم مصرفی، زمان اعتبار و سرویس‌های شبکه را مدیریت کرد.

مخزن عمومی شامل نصب‌کننده، مستندات و فایل‌های رسمی انتشار است. سورس کامل پروژه در تاریخچه عمومی گیت منتشر نمی‌شود.

### داشبورد

<div align="center">
  <img src="https://github.com/user-attachments/assets/dce63d83-78c5-4cd5-b77d-6a1d4ae722d8" alt="داشبورد BUB Panel" width="720" />
</div>

### سرویس‌های پشتیبانی‌شده

- `OpenVPN` — اتصال‌های تی‌سی‌پی و یو‌دی‌پی به‌صورت مستقل.
- `WireGuard` — مدیریت مستقیم وایرگارد.
- `AmneziaWG` — سرویس سازگار با وایرگارد با قابلیت مبهم‌سازی ترافیک.
- `Cisco / ocserv` — سرویس سیسکو در حالت تی‌سی‌پی.
- `IKEv2 / IPsec` — مدیریت اتصال مبتنی بر استرانگ‌سوان.
- `L2TP / IPsec` — مدیریت اتصال ال‌تو‌تی‌پی و آی‌پی‌سک.
- `SSTP` — نصب و مدیریت سرویس اس‌اس‌تی‌پی.
- `SoftEther` — نصب و مدیریت سافت‌اتر.
- `Telegram Proxy` — مدیریت پروکسی تلگرام مبتنی بر تلمت.

### مدیریت کاربران

- ساخت، غیرفعال‌سازی، فعال‌سازی دوباره و حذف کاربر.
- تعیین تاریخ انقضا و سقف مصرف برای هر کاربر.
- نمایش مصرف ترافیک و وضعیت آنلاین یا آفلاین در سرویس‌های پشتیبانی‌شده.
- ساخت و دانلود فایل اتصال کاربر.
- انجام عملیات گروهی روی کاربران.
- مدیریت نشست‌های فعال بر اساس قابلیت هر سرویس.

<div align="center">
  <img src="https://github.com/user-attachments/assets/441a4755-1585-4f06-b4f0-9e1742018194" alt="مدیریت کاربران BUB Panel" width="720" />
</div>

### ربات فروش تلگرام

BUB Panel دارای **ربات فروش تلگرام** یکپارچه است که برای نمایش سرویس‌ها و مدیریت روند سفارش از داخل تلگرام استفاده می‌شود. دسته‌بندی‌ها، محصولات/سرویس‌ها و اطلاعات پرداخت از داخل پنل مدیریت می‌شوند.

برای راه‌اندازی اولیه کافی است این ترتیب را رعایت کنید:

1. ابتدا **دسته‌بندی** موردنظر را بسازید.
2. سپس **محصول/سرویس** را ایجاد کرده و داخل همان دسته‌بندی قرار دهید.
3. در پایان **اطلاعات پرداخت** مورد استفاده برای سفارش کاربران را تنظیم و بررسی کنید.

در حالت چندپنلی یا چندنودی، دسته‌بندی و محصول را برای پنل موردنظر تعریف کنید تا سرویس صحیح به کاربر نمایش داده شود.

### سرور اصلی و چند نود

یک سرور اصلی می‌تواند هم سرویس‌های خودش و هم چند نود راه دور را مدیریت کند. روی هر نود، عامل BUB Panel و سرویس‌هایی که برای همان نود انتخاب شده‌اند اجرا می‌شوند.

وضعیت و عملیات هر سرویس برای همان سرور یا نود جدا نگه داشته می‌شود. بنابراین یک شماره پورت می‌تواند روی دو نود مختلف استفاده شود. بررسی تداخل پورت نیز فقط روی همان مقصد انجام می‌شود و BUB Panel برای آزادکردن پورت، سرویس نامرتبط را متوقف نمی‌کند.

### پایداری و عملیات

- بررسی شرایط لازم پیش از تغییر سرویس.
- نمایش تغییرات پیش از اجرا و تهیه نسخه بازگشت قبل از عملیات حساس.
- تشخیص اختلاف تنظیمات و وضعیت همگام‌سازی نودها.
- فاصله‌گذاری هوشمند بین تلاش‌های ناموفق برای جلوگیری از تکرار بی‌وقفه عملیات.
- ثبت رویدادهای مدیریتی، گزارش‌های محدودشده و بررسی سلامت سرویس‌ها.
- حذف و به‌روزرسانی بر اساس مالکیت BUB Panel تا سرویس‌های نامرتبط دست‌کاری نشوند.

### امنیت

- مدیریت نشست‌ها و تاریخچه ورود.
- ثبت رویدادهای مدیریتی و کنترل سطح دسترسی.
- محافظت در برابر درخواست‌های جعلی و تلاش‌های مکرر ورود.
- محدودسازی درخواست‌های ورود و رابط برنامه‌نویسی.
- سربرگ‌های امنیتی مرورگر.
- پشتیبان‌گیری رمزنگاری‌شده.
- محدودکردن عملیات به نود و سرویس انتخاب‌شده.
- رمز عبور، کلید خصوصی، توکن و اطلاعات بازیابی نباید در گزارش‌های برنامه نوشته شوند.

### معماری

```text
سرور اصلی BUB Panel
├── پنل وب
├── کنترل‌کننده و API
├── پایگاه داده
├── سرویس‌های VPN سرور اصلی
└── نودهای مدیریت‌شده
    ├── عامل BUB Panel
    └── سرویس‌های VPN همان نود
```

عملیات نگهداری فقط روی اجزایی انجام می‌شود که متعلق به BUB Panel باشند. نرم‌افزارها و سرویس‌های نامرتبط سرور خارج از محدوده مدیریت BUB Panel هستند.

### پیش‌نیازها

- سرور لینوکسی دارای `systemd`.
- اوبونتو، دبیان یا محیط پشتیبانی‌شده مبتنی بر `apt`، `dnf` یا `yum`.
- دسترسی روت برای نصب و مدیریت سرویس‌ها.
- معماری `amd64` یا `arm64`.
- دسترسی اینترنت هنگام نصب اولیه.
- برای استفاده از چند نود، دسترسی SSH از سرور اصلی به نودها.
- برای HTTPS خودکار، دامنه‌ای که به سرور اصلی اشاره کند و پورت‌های `80` و `443` در دسترس باشند.

### نصب سریع

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/hoabba3i-dev/BUB-Panel/main/install.sh)
```

در نصب اولیه، نوع پایگاه داده، دامنه یا آی‌پی، پورت پنل، نام کاربری و رمز عبور مدیر، مسیر دلخواه پنل و HTTPS خودکار پرسیده می‌شود. نصب‌کننده قبل از نصب، فایل‌های انتشار را بررسی می‌کند و هنگام به‌روزرسانی عادی اطلاعات موجود BUB Panel را حفظ می‌کند.

بعد از نصب برای بازکردن مدیر ترمینالی:

```bash
BUB-Panel
```

### پورت سرویس‌ها

برای سرویس‌هایی که پورت قابل تغییر دارند، قبل از شروع نصب شماره پورت پرسیده می‌شود. در OpenVPN پورت‌های تی‌سی‌پی و یو‌دی‌پی جداگانه تعیین می‌شوند و مقدار پیش‌فرض هر دو `1194` است. پورت‌های `80` و `443` برای وب و HTTPS پنل رزرو هستند. IKEv2/IPsec و L2TP/IPsec از پورت‌های ثابت خود پروتکل استفاده می‌کنند.

### پایگاه داده

BUB Panel از SQLite و PostgreSQL پشتیبانی می‌کند. مسیرهای عادی به‌روزرسانی برای حفظ پایگاه داده، کاربران، سرویس‌ها، نودها و تنظیمات پنل طراحی شده‌اند.

### به‌روزرسانی

به‌روزرسانی از داخل **مدیر → به‌روزرسانی** انجام می‌شود. فایل‌های رسمی بر اساس معماری سیستم دریافت می‌شوند و قبل از نصب، مقدار SHA-256 آن‌ها بررسی می‌شود.

```bash
bub-panel --version
bub-panel-agent --version
```

### بررسی سلامت

```text
GET /api/health
GET /api/ready
```

مسیر اول سلامت برنامه را گزارش می‌دهد. مسیر دوم وابستگی‌های ضروری را هم بررسی می‌کند و اگر پنل آماده ارائه سرویس نباشد، کد `503` برمی‌گرداند.

### مستندات

- [معماری](docs/ARCHITECTURE.md)
- [نصب و به‌روزرسانی](docs/INSTALLATION.md)
- [امنیت](SECURITY.md)
- [تغییرات نسخه‌ها](CHANGELOG.md)
- [نسخه‌های منتشرشده](https://github.com/hoabba3i-dev/BUB-Panel/releases)

</div>
---

<a id="donate"></a>
<div align="center">

## ❤️ Support BUB Panel / حمایت از پروژه

**TRON / USDT — TRON Network only**

`TJbVosR66AkBC7jNVV9eYzUpWMtvmbFw9A`

**TON / USDT — TON Network only**

`UQDpumAW-3qzTQvGAOaM7A9OExcxpwatpj0UoRbTkTtm-X-s`

📢 **Telegram Channel:** [@bub_tunnel](https://t.me/bub_tunnel)  
💬 **Support:** [@Bubtunnel_support](https://t.me/Bubtunnel_support)

**BUB Panel v0.2.1**  
Free multi-service VPN management for Main + Multi-Node deployments.

</div>
