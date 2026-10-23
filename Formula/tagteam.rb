class Tagteam < Formula
  desc "Multi-account switcher for AI coding agent CLIs"
  homepage "https://github.com/michaelrigart/tagteam"
  version "20261023.738.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/michaelrigart/tagteam/releases/download/v20261023.738.0/tagteam-aarch64-apple-darwin.tar.xz"
      sha256 "754a29c52ef23acbde103c16b5b495e5b2fce5db2b27a7a33f2fd221b8d02d33"
    end
    if Hardware::CPU.intel?
      url "https://github.com/michaelrigart/tagteam/releases/download/v20261023.738.0/tagteam-x86_64-apple-darwin.tar.xz"
      sha256 "5d913377a8f7102ff4e5f041da9bed60147511f42f9ddc605a3babcd3092449f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/michaelrigart/tagteam/releases/download/v20261023.738.0/tagteam-aarch64-unknown-linux-musl.tar.xz"
      sha256 "03e71d2003c65c8966f8a82e9632414f5e406a7034f16a8c593c07ad131d429e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/michaelrigart/tagteam/releases/download/v20261023.738.0/tagteam-x86_64-unknown-linux-musl.tar.xz"
      sha256 "da0be8627fd486719cf710e7c27bd0f49ee707d072e34bffa07a2a0241aa4083"
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
