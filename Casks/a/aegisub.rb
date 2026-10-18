cask "aegisub" do
  version "3.5.1"
  sha256 "593ecfec16e9d318677bb123cb382eace1b81e75f58716f0f3e3b1df31e752e6"

  url "https://github.com/TypesettingTools/Aegisub/releases/download/v#{version}/Aegisub-#{version}-arm64.dmg"
  name "Aegisub"
  desc "Create and modify subtitles"
  homepage "https://github.com/TypesettingTools/Aegisub/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Aegisub.app"

  uninstall quit: "com.aegisub.aegisub"

  zap trash: [
    "~/Library/Application Support/Aegisub",
    "~/Library/Preferences/com.aegisub.aegisub.plist",
    "~/Library/Saved Application State/com.aegisub.aegisub.savedState",
  ]
end
