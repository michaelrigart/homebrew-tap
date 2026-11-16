cask "tafl" do
  version "20261116-2103"
  sha256 "7319ae66c5db2ce7af7f93f6b2c78719cd0b839b4f00be14d917e6b539ccfe87"

  url "https://github.com/michaelrigart/tafl/releases/download/#{version}/Tafl-#{version}.zip"
  name "Tafl"
  desc "Places windows on a grid from the keyboard"
  homepage "https://github.com/michaelrigart/tafl"

  livecheck do
    url :url
    regex(/^(\d{8}-\d{4})$/i)
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :golden_gate

  app "Tafl.app", target: "/Applications/Tafl.app"

  uninstall quit: "com.michaelrigart.tafl"

  zap trash: [
    "~/.local/state/tafl",
    "~/Library/Preferences/com.michaelrigart.tafl.plist",
  ]

  caveats <<~EOS
    Tafl is signed but not notarized, so macOS blocks its first launch.
    After the first install, open System Settings > Privacy & Security and
    choose "Open Anyway" for Tafl. Upgrades should not need this again.

    Then give Tafl the Accessibility permission: its onboarding window opens
    the right page of System Settings > Privacy & Security. Upgrades keep this
    permission; if macOS asks again, repeat it.

    Quit Rectangle, or any other app that uses the same shortcuts, before you
    start Tafl: if another app holds a shortcut, Tafl gets no error, so the
    shortcut may not reach Tafl.
  EOS
end
