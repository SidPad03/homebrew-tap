cask "mcp-gateway-agent" do
  version "1.0.0"
  # TODO: fill from the published DMG once agent-v1.0.0 exists:
  #   shasum -a 256 MCP-Gateway-Agent-1.0.0.dmg
  # Deliberately left wrong rather than set to :no_check — the app is ad-hoc
  # signed, so the checksum is the only thing vouching for the download, and an
  # install should fail loudly instead of fetching an unverified bundle.
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/SidPad03/unified-mcp-gateway/releases/download/agent-v#{version}/MCP-Gateway-Agent-#{version}.dmg"
  name "MCP Gateway Agent"
  desc "Connects local MCP servers to a self-hosted MCP Gateway"
  homepage "https://github.com/SidPad03/unified-mcp-gateway"

  # The repository interleaves agent-v* and gateway-v* tags, so "the latest
  # release" is regularly a gateway release with no app in it. Match the agent
  # tags specifically.
  livecheck do
    url :url
    strategy :github_releases
    regex(/^agent[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  # The app replaces its own bundle from Settings → Updates, so the version on
  # disk can move ahead of the cask. Without this, brew keeps trying to
  # "upgrade" an app that has already updated itself.
  auto_updates true
  # The app's Info.plist sets LSMinimumSystemVersion 26.0. Tahoe is macOS 26.
  depends_on macos: :tahoe

  app "MCP Gateway Agent.app"

  # Quitting stops the local MCP servers and withdraws their tools from the
  # gateway, which is what uninstalling should do.
  uninstall quit: "com.mcpgateway.agent"

  # `~/.mcp-gateway-agent` holds config.toml, the merged logs and staged update
  # binaries. The gateway API key lives in the Keychain, which brew does not
  # touch — remove it with:
  #   security delete-generic-password -s com.mcpgateway.agent
  zap trash: [
    "~/.mcp-gateway-agent",
    "~/Library/Caches/com.mcpgateway.agent",
    "~/Library/HTTPStorages/com.mcpgateway.agent",
    "~/Library/Preferences/com.mcpgateway.agent.plist",
  ]

  caveats <<~EOS
    MCP Gateway Agent is ad-hoc signed (not notarized), so on first launch macOS
    will say it cannot be opened. Right-click the app in Applications and choose
    Open, or run:
      xattr -dr com.apple.quarantine "/Applications/MCP Gateway Agent.app"

    Updates installed from inside the app are not quarantined, so this is a
    one-time step.

    Open the app, enter your gateway address, and sign in through the browser.
    There is no API key to create or paste.
  EOS
end
