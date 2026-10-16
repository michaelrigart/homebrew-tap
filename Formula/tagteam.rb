class Tagteam < Formula
  desc "Multi-account switcher for AI coding agent CLIs"
  homepage "https://github.com/michaelrigart/tagteam"
  version "20261016.2230.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/michaelrigart/tagteam/releases/download/v20261016.2230.0/tagteam-aarch64-apple-darwin.tar.xz"
      sha256 "c3a97cf12eb53633ccf946add4b082f63f16b8f9bc1314489ebdbc9215222db2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/michaelrigart/tagteam/releases/download/v20261016.2230.0/tagteam-x86_64-apple-darwin.tar.xz"
      sha256 "fb638527c6ac1fd4bcacc02cb489c00223e1515cde3b798e9c5ca0c19e3056ba"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/michaelrigart/tagteam/releases/download/v20261016.2230.0/tagteam-aarch64-unknown-linux-musl.tar.xz"
      sha256 "96fca3b95f1fde66e6c89475e4ea0fdc928c33bc416019faa644478a5429d603"
    end
    if Hardware::CPU.intel?
      url "https://github.com/michaelrigart/tagteam/releases/download/v20261016.2230.0/tagteam-x86_64-unknown-linux-musl.tar.xz"
      sha256 "2df4caa113f26c8cdd5700f69f880399d90e9cc5a224b6896d7a068e3fab984d"
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
