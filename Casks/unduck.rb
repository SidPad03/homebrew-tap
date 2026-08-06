cask "unduck" do
  version "0.1.2"
  sha256 "7f0ec1dea38c417c8c10821c680d047bbff887a9f841a3828522cc4edfbd8c41"

  url "https://github.com/SidPad03/unduck/releases/download/v#{version}/Unduck-#{version}.dmg"
  name "Unduck"
  desc "Restores normal media volume during FaceTime and other VoIP calls"
  homepage "https://github.com/SidPad03/unduck"

  app "Unduck.app"

  caveats <<~EOS
    Unduck is ad-hoc signed (not notarized), so on first launch macOS may block it.
    Right-click Unduck in Applications and choose Open, or run:
      xattr -dr com.apple.quarantine "/Applications/Unduck.app"

    Unduck needs macOS 26.1 or later, and asks for System Audio Recording
    permission on your first call.
  EOS
end
