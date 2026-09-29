# simiriva95/tap

Homebrew tap for [PortPilot](https://github.com/simiriva95/portpilot), a macOS menu bar app that shows every listening port and quits dev servers in one click.

```sh
brew install --cask simiriva95/tap/portpilot
```

PortPilot updates itself from the menu bar panel, so `brew upgrade` skips it (`auto_updates true`). To force a Homebrew upgrade anyway: `brew upgrade --cask --greedy portpilot`.

The cask is bumped automatically by PortPilot's release workflow.
