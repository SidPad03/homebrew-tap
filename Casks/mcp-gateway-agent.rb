cask "mcp-gateway-agent" do
  version "1.0.5"
  sha256 "0994a436d0fd709e9b453fab1a47e6a0601d7c5e59d478b1ecade97da364944c"

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

  # `auto_updates true` belongs here in principle: the app replaces its own
  # bundle from Settings → Updates, and without the flag brew keeps trying to
  # "upgrade" something that already upgraded itself.
  #
  # It is off because that self-updater does not work yet. Builds ship with an
  # empty MCPGAUpdatePublicKey until MCPGA_UPDATE_PRIVATE_KEY and
  # MCPGA_UPDATE_PUBLIC_KEY are set as repository secrets, so the app reports an
  # update and then declines to install it. `brew upgrade` skips auto_updates
  # casks unless you pass --greedy, so the flag left the app with no working
  # update path at all: not brew's, and not its own. Restore it in the same
  # change that adds the signing keys.
  #
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
