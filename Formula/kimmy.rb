class Kimmy < Formula
  desc "Terminal client for KimmyDB"
  homepage "https://github.com/gruberchris/kimmydb"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gruberchris/kimmydb/releases/download/v0.6.0/kimmy-cli-aarch64-apple-darwin.tar.xz"
      sha256 "05d8f80a9831b2e0d42212ddccabb8b7fae1d96ee3bf60a89931451f6697480a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gruberchris/kimmydb/releases/download/v0.6.0/kimmy-cli-x86_64-apple-darwin.tar.xz"
      sha256 "8294d492be161064f5074de532d246edebf24495336e5fa70fa31dc0b4c91f21"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gruberchris/kimmydb/releases/download/v0.6.0/kimmy-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "df46e2d7665fb654076dfa0bca27afcc6ee1baf916af3b2cf6a09ae762d5ed79"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gruberchris/kimmydb/releases/download/v0.6.0/kimmy-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "03c0593d0dfa979dcff4190340b2c591630bafec58320decd2ea35e591f703f2"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

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
      bin.install "kimmy"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "kimmy"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "kimmy"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "kimmy"
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
