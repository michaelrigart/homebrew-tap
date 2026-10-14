class Tagteam < Formula
  desc "Multi-account switcher for AI coding agent CLIs"
  homepage "https://github.com/michaelrigart/tagteam"
  version "20261014.2045.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/michaelrigart/tagteam/releases/download/v20261014.2045.0/tagteam-aarch64-apple-darwin.tar.xz"
      sha256 "64c2650c06a0032e95a360139a89b37dd241cf26bb7a441fa3bcb4ec84a1f178"
    end
    if Hardware::CPU.intel?
      url "https://github.com/michaelrigart/tagteam/releases/download/v20261014.2045.0/tagteam-x86_64-apple-darwin.tar.xz"
      sha256 "e4318ef156e93641d314f0b474a59256efe90c089ce5f49a59d60c743573e5ba"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/michaelrigart/tagteam/releases/download/v20261014.2045.0/tagteam-aarch64-unknown-linux-musl.tar.xz"
      sha256 "e4ace47f150b0935b849e221a5e7efcf01f03c446f3c11b5ddb9eca7c8761149"
    end
    if Hardware::CPU.intel?
      url "https://github.com/michaelrigart/tagteam/releases/download/v20261014.2045.0/tagteam-x86_64-unknown-linux-musl.tar.xz"
      sha256 "5dad6489c7980a67b8dfe614fc6c725966974cfef6d3a5a340214e025562e1e1"
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
