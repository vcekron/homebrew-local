cask "aegisub" do
  version "3.5.0"
  sha256 "7d0701fbabcbcea1664b50e4f2726ea333721d1fbb313a3cc0c81e2a50b98cb5"

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
