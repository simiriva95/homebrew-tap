cask "portpilot" do
  version "0.1.1"
  sha256 "79921a7a1f7b1078e219dadf32b1e44f0ffa1251f6799f4082f3d24c7a92cb36"

  url "https://github.com/simiriva95/portpilot/releases/download/v#{version}/PortPilot-#{version}.dmg"
  name "PortPilot"
  desc "Menu bar app that lists listening ports and quits dev servers"
  homepage "https://github.com/simiriva95/portpilot"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :ventura"

  app "PortPilot.app"

  # Not signed with an Apple Developer ID: remove the quarantine flag and sign it locally,
  # the same steps as https://github.com/simiriva95/portpilot#sign-it-yourself
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/PortPilot.app"],
                   must_succeed: false
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/PortPilot.app"]
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
