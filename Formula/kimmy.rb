class Kimmy < Formula
  desc "Terminal client for KimmyDB"
  homepage "https://github.com/gruberchris/kimmydb"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gruberchris/kimmydb/releases/download/v0.3.0/kimmy-cli-aarch64-apple-darwin.tar.xz"
      sha256 "260986f60ace1cb269688b170d8d5178e4e91f010396895bb67317015dfd6683"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gruberchris/kimmydb/releases/download/v0.3.0/kimmy-cli-x86_64-apple-darwin.tar.xz"
      sha256 "852b6b224202297f2febda59be75d103a2ecf3a693d15e64ad7c591db3348458"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gruberchris/kimmydb/releases/download/v0.3.0/kimmy-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "d509f3390d72624c1ed27f501ff76ec4f73d7ace8bf6523025a05fce02a6835b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gruberchris/kimmydb/releases/download/v0.3.0/kimmy-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "772c82e04ee462b3e9b38b43ad18f83b4de45e01d5ec2192e4c84f8a5fa84f05"
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
