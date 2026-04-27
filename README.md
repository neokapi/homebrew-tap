# Neokapi Homebrew Tap

Homebrew formulae for [neokapi](https://github.com/neokapi/neokapi)
projects.

## Install

```sh
brew tap neokapi/tap
```

## Available formulae

| Formula | What it installs |
|---|---|
| `neokapi/tap/kapi` | The kapi CLI (Apache-2.0). Manifest-driven plugins discovered at runtime. |
| `neokapi/tap/bowrain-cli` | kapi + the bowrain plugin (drops `kapi-bowrain` into `share/kapi/plugins/bowrain/`). After install, `kapi push` / `kapi pull` / etc. dispatch to the plugin. |
| `neokapi/tap/bowrain-cli-standalone` | (legacy) the standalone `bowrain` binary; new installs should prefer `bowrain-cli`. |
| `neokapi/tap/kapi-cli` | (legacy alias for `kapi`; will be removed in a future release.) |

## Casks

| Cask | What it installs |
|---|---|
| `neokapi/tap/kapi` | Kapi Desktop app (macOS). |
| `neokapi/tap/bowrain` | Bowrain Desktop app (macOS). Depends on `bowrain-cli`. |

## Updates

Formulae and casks here are auto-managed by
[GoReleaser](https://goreleaser.com/) running in
[neokapi/neokapi](https://github.com/neokapi/neokapi)'s release
workflow. Each tagged release pushes refreshed formulae to this repo.
