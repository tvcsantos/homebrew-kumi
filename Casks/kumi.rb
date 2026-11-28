cask "kumi" do
  arch arm: "arm64", intel: "x64"

  version "0.7.0"
  sha256 arm:   "0b1c07771f800dee31ed88d9730cfea5ced2f9e85b3a7bffc9972bf6ad2d4c4a",
         intel: "21200408e2e1645d72449f395a3469b962d8c39c5fd61baa5d467ff9fdc8f22d"

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
