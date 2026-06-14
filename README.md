# Neokapi Homebrew Tap

Homebrew formulae and casks for [neokapi](https://github.com/neokapi/neokapi).

## Install

```sh
brew tap neokapi/tap
```

## Formulae (CLI)

| Formula | What it installs |
|---|---|
| `neokapi/tap/kapi-cli` | The kapi CLI (Apache-2.0). Manifest-driven plugins discovered at runtime. |
| `neokapi/tap/bowrain-cli` | kapi + the bowrain plugin (drops `kapi-bowrain` into `share/kapi/plugins/bowrain/`). After install, `kapi push` / `kapi pull` / etc. dispatch to the plugin. |

## Casks (desktop apps, macOS)

| Cask | What it installs |
|---|---|
| `neokapi/tap/kapi` | Kapi Desktop app. |
| `neokapi/tap/bowrain` | Bowrain Desktop app. Depends on `bowrain-cli`. |

## Updates

The formulae and casks here are auto-managed by
[neokapi/neokapi](https://github.com/neokapi/neokapi)'s release workflow —
each tagged release regenerates and pushes refreshed `Formula/` and `Casks/`
entries to this repo.
