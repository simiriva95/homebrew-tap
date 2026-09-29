cask "portpilot" do
  version "0.1.3"
  sha256 "4c8b231b4a72997d2cb92894df1ec085e0b86f61363695f6edf1b0496bf08128"

  url "https://github.com/simiriva95/portpilot/releases/download/v#{version}/PortPilot-#{version}.dmg"
  name "PortPilot"
  desc "Menu bar app that lists listening ports and quits dev servers"
  homepage "https://github.com/simiriva95/portpilot"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :ventura

  app "PortPilot.app"

  # Not signed with an Apple Developer ID: remove the quarantine flag and sign it locally,
  # the same steps as https://github.com/simiriva95/portpilot#sign-it-yourself
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/PortPilot.app"],
        must_succeed:   false,
        writable_paths: ["PortPilot.app"],
        writable_base:  :appdir
    run "/usr/bin/codesign",
        args:           ["--force", "--deep", "--sign", "-", "{{appdir}}/PortPilot.app"],
        writable_paths: ["PortPilot.app"],
        writable_base:  :appdir
  end

  uninstall quit: "io.github.simiriva95.portpilot"

  zap trash: [
    "~/Library/Application Support/PortPilot",
    "~/Library/Preferences/io.github.simiriva95.portpilot.plist",
  ]

  caveats <<~EOS
    PortPilot is not signed with an Apple Developer ID, so this cask removes the
    quarantine flag and signs the app locally after installing it.
  EOS
end
