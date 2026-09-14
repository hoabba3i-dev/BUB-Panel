# BUB Panel Architecture

## Overview

BUB Panel uses a **Main + Multi-Node** control-plane model. The Main server owns the web interface, API, authentication, database and desired state. Remote Nodes run the BUB Panel Agent and execute only the service changes assigned to that Node.

```text
Main Server
├── Web Panel
├── Controller / API
├── Authentication / Security
├── PostgreSQL or SQLite
├── Main-local VPN services
└── Remote Nodes
    └── BUB Panel Agent
        └── Node-local VPN services
```

## Main server responsibilities

The Main server is authoritative for:

- users and policy
- authentication and administrative sessions
- node definitions and credentials
- desired service state
- service configuration
- target-scoped port reservations
- user/node assignment
- backup and restore orchestration
- release/update control

The web process is a control plane. Restarting it must not deliberately terminate healthy VPN daemons.

## Node Agent responsibilities

A remote Node runs a small Agent that:

1. Authenticates to the Main controller.
2. Pulls its desired user/service state.
3. Applies only BUB-managed changes on that Node.
4. Reports applied revisions and runtime health.
5. Retries unapplied revisions instead of falsely acknowledging them.

The Agent is not a separate product. Main and Agent use the same BUB Panel release version.

## Ownership boundary

BUB Panel must distinguish between **BUB-owned** and **foreign** system state.

Node add, repair, reclaim and remove operations are scoped to BUB Panel Agent files and BUB-managed service artifacts. They must not stop, disable, remove or reconfigure unrelated services such as third-party VPNs, proxies, Docker workloads or other user applications.

A listener owned by a foreign service causes the requested BUB service install to fail with a port conflict. It is never resolved by killing the foreign process.

## Target isolation

Service identity is scoped by:

```text
target + service
```

The same port can therefore be used independently on different Nodes. UI transient state is also scoped by target + service, preventing install/uninstall/restart/pending/error state from leaking between Main and remote Nodes.

## Shared IPsec runtime

BUB IKEv2 and L2TP share the managed strongSwan runtime on UDP 500/4500. L2TP additionally uses UDP 1701.

The shared daemon is retained while either BUB-managed IKEv2 or L2TP still requires it. Ownership markers are used so an unrelated strongSwan installation is not silently adopted or killed.

## Persistence

BUB Panel supports SQLite and PostgreSQL. Existing database selection and user data are preserved across normal upgrades. The store is authoritative for user, node, policy and revision state.

OpenVPN PKI is external security state and is treated separately from application database state. Repair/revocation paths must use the existing verified CA/PKI and must not reinitialize an unknown deployment.

## Runtime layout

```text
/usr/local/bin/bub-panel
/usr/local/bin/bub-panel-agent
/opt/bub-panel/
/etc/bub-panel/
/etc/bub-panel-agent/
/var/lib/bub-panel/
/var/lib/bub-panel-agent/
/var/backups/bub-panel/
```

Systemd units:

```text
bub-panel.service
bub-panel-agent.service
```

## Release model

The private source tree is used to build release binaries. Public GitHub releases contain architecture-specific binaries, a runtime bundle and checksums. The runtime bundle contains web assets, operational scripts, systemd units and public documentation but not the private Go source tree.

Automatic updates verify the published checksums before replacing runtime assets.
