# homebrew-kumi

Homebrew tap for [Kumi](https://tiago.santos.com.pt/kumi/) - an MCP
marketplace: browse MCP servers and install them into Claude, VS Code,
Cursor, Codex and GitHub Copilot.

## Install

```sh
brew install --cask tvcsantos/kumi/kumi
```

Installs the Kumi desktop app into `/Applications`. Upgrade with:

```sh
brew upgrade --cask kumi
```

Kumi is not notarized (no Apple Developer account); the cask clears the
Gatekeeper quarantine attribute after install so the app opens normally.

The cask tracks the latest release of the
[kumi repository](https://github.com/tvcsantos/kumi).

## License

[MIT](LICENSE)
