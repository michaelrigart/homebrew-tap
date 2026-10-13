class Tagteam < Formula
  desc "Multi-account switcher for AI coding agent CLIs"
  homepage "https://github.com/michaelrigart/tagteam"
  version "20261013.2030.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/michaelrigart/tagteam/releases/download/v20261013.2030.0/tagteam-aarch64-apple-darwin.tar.xz"
      sha256 "e7ea47753dc5389fa5a68f9760bd350c27ebd3aedfaf18ebbf2587b427326ae3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/michaelrigart/tagteam/releases/download/v20261013.2030.0/tagteam-x86_64-apple-darwin.tar.xz"
      sha256 "c6103e8c4a5f51f0a3a5b531ab6b18411fd63b52cabaf59127c688d7327abf7f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/michaelrigart/tagteam/releases/download/v20261013.2030.0/tagteam-aarch64-unknown-linux-musl.tar.xz"
      sha256 "2aa77bf0413b7e1c05df0af61ed04b9310b7264fc45d325539a5302eb3c1c502"
    end
    if Hardware::CPU.intel?
      url "https://github.com/michaelrigart/tagteam/releases/download/v20261013.2030.0/tagteam-x86_64-unknown-linux-musl.tar.xz"
      sha256 "66c660a52c9919c2e95f0186a3f910e016f05777e80bfd16bbe711a44b859716"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "tagteam"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "tagteam"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "tagteam"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "tagteam"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
