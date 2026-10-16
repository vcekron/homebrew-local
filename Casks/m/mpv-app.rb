cask "mpv-app" do
  local_macos_major = 27

  version "0.41.0,26"
  sha256 "09820c0d84f6687446b84eb9df81fcf6a26ebe869cee58ea1857d7948cfb7c71"

  url "https://github.com/mpv-player/mpv/releases/download/v#{version.csv.first}/mpv-v#{version.csv.first}-macos-#{version.csv.second}-arm.zip"
  name "mpv"
  desc "Media player based on MPlayer and mplayer2"
  homepage "https://mpv.io/"

  livecheck do
    url :url
    regex(/^mpv[._-]v?(\d+(?:\.\d+)+)[._-]macos[._-](\d+)[._-]arm\.zip$/i)
    strategy :github_latest do |json, regex|
      builds = json["assets"]&.filter_map do |asset|
        match = asset["name"]&.match(regex)
        next if match.nil? || match[2].to_i > local_macos_major

        [match[1], match[2].to_i]
      end
      best = builds&.max_by(&:last)
      next if best.nil?

      "#{best.first},#{best.last}"
    end
  end

  depends_on arch: :arm64
  depends_on macos: MacOSVersion.new(version.csv.second).to_sym

  app "mpv.app"
  binary "#{appdir}/mpv.app/Contents/MacOS/mpv"

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
