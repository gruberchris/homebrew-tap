class Kimmy < Formula
  desc "Terminal client for KimmyDB"
  homepage "https://github.com/gruberchris/kimmydb"
  version "0.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gruberchris/kimmydb/releases/download/v0.9.0/kimmy-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c5be65fc7e73acdc88b20a9623b43f1b2d4aeeaaa7627d5b97f10d39f7b4f332"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gruberchris/kimmydb/releases/download/v0.9.0/kimmy-cli-x86_64-apple-darwin.tar.xz"
      sha256 "c2607d013953c92c359fd3e9239244ccc0e4dbee922ef99c80816c3f1f7055ab"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gruberchris/kimmydb/releases/download/v0.9.0/kimmy-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "8cab6eac8a92b85b597ece49654c966c1003d6fbd859e91bb0e263b25d6945ef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gruberchris/kimmydb/releases/download/v0.9.0/kimmy-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "bcac393efd5cc0b510709c201ba2167d82cf2007746e67fcc661969d39cf8779"
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
