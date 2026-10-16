cask "vcekron-transmission-4-1-3" do
  version "4.1.3"
  sha256 "d622736c19990262f2ab12183e1acaa5b0dad5777ddc7db0a187c06e035a7e1a"

  url "https://github.com/transmission/transmission/releases/download/#{version}/Transmission-#{version}.dmg"
  name "Transmission (frozen 4.1.3)"
  desc "Open-source BitTorrent client — version-locked for rollback/testing"
  homepage "https://transmissionbt.com/"

  livecheck do
    skip "Pinned to a specific version for rollback"
  end

  auto_updates false
  conflicts_with cask: [
    "transmission",
    "transmission@beta",
    "transmission@nightly",
  ]
  depends_on :macos

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
    This is a version-locked build (Transmission 4.1.3).
    For the latest official release from homebrew/cask:
      brew install --cask transmission
  EOS
end
