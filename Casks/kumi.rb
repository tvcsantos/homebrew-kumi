cask "kumi" do
  arch arm: "arm64", intel: "x64"

  version "0.2.0"
  sha256 arm:   "f29dd8a3e80b304975c4051c8ced3daa0032b82cc069b02bcf15ebef0e95b51a",
         intel: "49ec6dd5ef3df0f5dc62057d354d5024f499c047ca5c30a4d638450eb78abfea"

  url "https://github.com/tvcsantos/kumi/releases/download/v#{version}/Kumi-#{version}-#{arch}.dmg"
  name "Kumi"
  desc "Browse MCP servers and install them into coding agents"
  homepage "https://tiago.santos.com.pt/kumi/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Kumi.app"

  # Not notarized (no Apple Developer account): strip the Gatekeeper
  # quarantine attribute so the app opens without the "Open Anyway" dance.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-cr", "{{appdir}}/Kumi.app"],
        writable_paths: ["Kumi.app"],
        writable_base:  :appdir
  end

  zap trash: [
    "~/Library/Application Support/Kumi",
    "~/Library/Preferences/dev.tvcsantos.kumi.plist",
    "~/Library/Saved Application State/dev.tvcsantos.kumi.savedState",
  ]

  caveats <<~CAVEATS
    Kumi is not notarized (no Apple Developer account). The quarantine
    attribute is removed on install, so it opens normally. If macOS still
    blocks it, run:

      xattr -cr "#{appdir}/Kumi.app"
  CAVEATS
end
