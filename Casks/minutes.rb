# The seed for Casks/minutes.rb in SidPad03/homebrew-tap. release.yml copies it there on
# the first release and fills in the version and sha256. After that the tap's copy is the
# one that counts, and each release changes only those two lines.
cask "minutes" do
  version "0.1.0"
  sha256 "49bc459656c8f93fa7bcef75f0402da5eb9c4913d9655d0d9c08761ed518fb19"

  url "https://github.com/SidPad03/minutes/releases/download/v#{version}/Minutes-#{version}.dmg"
  name "Minutes"
  desc "Meeting notepad with on-device transcription and speaker names"
  homepage "https://github.com/SidPad03/minutes"

  # Minutes updates itself, so the version on disk can move ahead of the cask. Without
  # this, brew keeps trying to "upgrade" an app that already updated itself.
  auto_updates true
  # Apple silicon only (the speech models run on the Neural Engine). The app's Info.plist
  # sets LSMinimumSystemVersion 15.0; Sequoia is macOS 15, and a bare symbol means "or later".
  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "Minutes.app"

  # Settings, indexes, scratch audio, logs and the downloaded speech models. The vault is
  # wherever the user put it, and zap never touches it.
  zap trash: [
    "~/Library/Application Support/Minutes",
    "~/Library/Caches/com.sigmanet.minutes",
    "~/Library/HTTPStorages/com.sigmanet.minutes",
    "~/Library/Preferences/com.sigmanet.minutes.plist",
  ]

  caveats <<~EOS
    Minutes asks for permission to record your microphone and your calls' audio the
    first time you record. Audio and transcripts stay on this Mac.

    AI notes are optional and need Ollama (https://ollama.com):
      brew install ollama
  EOS
end
