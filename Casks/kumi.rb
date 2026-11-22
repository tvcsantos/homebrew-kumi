cask "kumi" do
  arch arm: "arm64", intel: "x64"

  version "0.3.0"
  sha256 arm:   "ae5acb4195243f46c2250a9c0dc16295dcc46ff6a4a2e2667f492d087b4f1474",
         intel: "2655d9d7570784571afa2821e02ce18a5cb716804f415be6b1669ad186bcaacc"

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
