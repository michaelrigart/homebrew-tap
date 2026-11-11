class Tagteam < Formula
  desc "Multi-account switcher for AI coding agent CLIs"
  homepage "https://github.com/michaelrigart/tagteam"
  version "20261111.1935.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/michaelrigart/tagteam/releases/download/v20261111.1935.0/tagteam-aarch64-apple-darwin.tar.xz"
    sha256 "9be4ebe37f8a950d64a31ad4f0cb2730982dc3fe14e872705799cfbd7ddb6fd0"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/michaelrigart/tagteam/releases/download/v20261111.1935.0/tagteam-aarch64-unknown-linux-musl.tar.xz"
      sha256 "e5cd8d72fa01eb9f92887168788b22d54d306ae0556a8e89c038c7daaac50b6c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/michaelrigart/tagteam/releases/download/v20261111.1935.0/tagteam-x86_64-unknown-linux-musl.tar.xz"
      sha256 "7aa9904af3de547f3f09d69de3857261227e89fe0499d7f4147a2edaf1e6f73c"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
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
