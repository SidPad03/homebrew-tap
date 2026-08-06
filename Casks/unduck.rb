cask "unduck" do
  version "0.1.3"
  sha256 "a55a3e192b9bc5c2ad271a3d041b5e54ff732af58f71be77f2695fc18be3f1bf"

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
