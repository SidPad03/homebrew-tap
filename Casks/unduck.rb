cask "unduck" do
  version "0.1.8"
  sha256 "677cc97e86715040a7c496d1f952383edb724f6e6dc5a57033b93dfeb1d26d19"

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
