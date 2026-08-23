class Kimmy < Formula
  desc "Terminal client for KimmyDB"
  homepage "https://github.com/gruberchris/kimmydb"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gruberchris/kimmydb/releases/download/v0.1.0/kimmy-cli-aarch64-apple-darwin.tar.xz"
      sha256 "21e65e84dc5848dab9584d72303d28253c3bc23185150d4020fcb7b198dbc864"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gruberchris/kimmydb/releases/download/v0.1.0/kimmy-cli-x86_64-apple-darwin.tar.xz"
      sha256 "74923ff8d1bf6f96e175578c07e4f0160446b4994857fb3d19185c9aac810b10"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gruberchris/kimmydb/releases/download/v0.1.0/kimmy-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "93028b7f7e72f12bacd80b23eed11dd7353305ec4a1ffa61bac9d7d32e3346fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gruberchris/kimmydb/releases/download/v0.1.0/kimmy-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "714464dadfa92040a7a628d845e41571dc51b6786a9db83c925c20564a02999a"
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
