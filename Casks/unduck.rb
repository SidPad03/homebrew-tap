cask "unduck" do
  version "0.1.9"
  sha256 "36e1b60067fcaca938ef891fa4363f29ea66c9f93bf55da1dcd4aecf6ce447d0"

  url "https://github.com/SidPad03/unduck/releases/download/v#{version}/Unduck-#{version}.dmg"
  name "Unduck"
  desc "Restores normal media volume during FaceTime and other VoIP calls"
  homepage "https://github.com/SidPad03/unduck"

  # Unduck replaces its own bundle from "Check for Updates…", so the version on
  # disk can move ahead of the cask. Without this, brew keeps trying to "upgrade"
  # an app that already updated itself.
  auto_updates true
  # The app's Info.plist sets LSMinimumSystemVersion 26.1; routing needs the 26.1
  # aggregate-device fix. Tahoe is macOS 26.
  depends_on macos: :tahoe

  app "Unduck.app"

  caveats <<~EOS
    Unduck needs macOS 26.1 or later, and asks for System Audio Recording
    permission on your first call.
  EOS
end
