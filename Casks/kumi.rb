cask "kumi" do
  arch arm: "arm64", intel: "x64"

  version "0.5.0"
  sha256 arm:   "ca2b779a5482b0660bee3516afe910069a7d00e86e90bd98602acec9711ca518",
         intel: "d807d6f26582c51e65102e1f4c93999a645119c40cdc9093c4c95638e881fd43"

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
