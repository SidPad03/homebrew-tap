cask "unduck" do
  version "0.1.7"
  sha256 "b47a610846f4918b090fd092872748617ccbe252ec0a03a6317051b454de51b8"

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
    Unduck is ad-hoc signed (not notarized), so on first launch macOS may block it.
    Right-click Unduck in Applications and choose Open, or run:
      xattr -dr com.apple.quarantine "/Applications/Unduck.app"

    Unduck needs macOS 26.1 or later, and asks for System Audio Recording
    permission on your first call.
  EOS
end
