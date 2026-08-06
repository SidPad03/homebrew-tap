cask "unduck" do
  version "0.1.4"
  sha256 "6b6425000bfe78d3c0717b2f30d2a8938e03de26eb08ac3457c6504780ee36c7"

  url "https://github.com/SidPad03/unduck/releases/download/v#{version}/Unduck-#{version}.dmg"
  name "Unduck"
  desc "Restores normal media volume during FaceTime and other VoIP calls"
  homepage "https://github.com/SidPad03/unduck"

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
