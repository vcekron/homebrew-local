cask "stolendata-mpv" do
  version "0.40.0"
  sha256 "3170fb709defebaba33e9755297d70dc3562220541de54fc3d494a8309ef1260"

  url "https://laboratory.stolendata.net/~djinn/mpv_osx/mpv-arm64-#{version}.tar.gz"
  name "mpv"
  desc "Media player based on MPlayer and mplayer2"
  homepage "https://mpv.io/"

  livecheck do
    url "https://laboratory.stolendata.net/~djinn/mpv_osx/"
    regex(/mpv-arm64-(\d+(?:\.\d+)+)\.t/i)
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "mpv-arm64-#{version}/mpv.app"
  binary "#{appdir}/mpv.app/Contents/MacOS/mpv"
  manpage "mpv-arm64-#{version}/documentation/man/mpv.1"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/mpv.app"], must_succeed: false
  end

  zap trash: [
    "~/.config/mpv",
    "~/Library/Logs/mpv.log",
    "~/Library/Preferences/io.mpv.plist",
    "~/Library/Preferences/mpv.plist",
  ]
end
