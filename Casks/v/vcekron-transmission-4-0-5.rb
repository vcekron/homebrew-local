cask "vcekron-transmission-4-0-5" do
  version "4.0.5"
  sha256 "6a0e6838cb247ab1ed1390ef65368b82fc74b4e72cb0e291991f26c221436bc3"

  url "https://github.com/transmission/transmission/releases/download/#{version}/Transmission-#{version}.dmg",
      verified: "github.com/transmission/transmission/"
  name "Transmission (frozen 4.0.5)"
  desc "Open-source BitTorrent client — version-locked for rollback/testing"
  homepage "https://transmissionbt.com/"

  livecheck do
    skip "Pinned to a specific version for rollback"
  end

  auto_updates false
  conflicts_with cask: "transmission@nightly"
  depends_on macos: ">= :high_sierra"

  app "Transmission.app"

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/org.m0k.transmission.sfl*",
    "~/Library/Application Support/Transmission",
    "~/Library/Caches/com.apple.helpd/SDMHelpData/Other/English/HelpSDMIndexFile/org.m0k.transmission.help",
    "~/Library/Caches/com.apple.helpd/SDMHelpData/Other/English/HelpSDMIndexFile/Transmission Help*",
    "~/Library/Caches/org.m0k.transmission",
    "~/Library/Cookies/org.m0k.transmission.binarycookies",
    "~/Library/Preferences/org.m0k.transmission.LSSharedFileList.plist",
    "~/Library/Preferences/org.m0k.transmission.plist",
    "~/Library/Saved Application State/org.m0k.transmission.savedState",
  ]

  caveats <<~EOS
    This is a version-locked build (Transmission 4.0.5).
    For the latest official release from homebrew/cask:
      brew install --cask transmission
  EOS
end