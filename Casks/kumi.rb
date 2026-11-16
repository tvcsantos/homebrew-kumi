cask "kumi" do
  arch arm: "arm64", intel: "x64"

  version "0.1.8"
  sha256 arm:   "22c2a79442950456da6d863c8b16d2bb456ec50975e54ad6c57e0302eef53ae3",
         intel: "5415580fbbe93fd115cb47d64158770320946216bd5d075f4cd6317e5c77787f"

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
