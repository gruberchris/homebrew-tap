class Kimmy < Formula
  desc "Terminal client for KimmyDB"
  homepage "https://github.com/gruberchris/kimmydb"
  version "0.10.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gruberchris/kimmydb/releases/download/v0.10.1/kimmy-cli-aarch64-apple-darwin.tar.xz"
      sha256 "107a3c6cc7e395e7497e26e803d1ff03a62e7e32193fb7680d278d3c6035c4fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gruberchris/kimmydb/releases/download/v0.10.1/kimmy-cli-x86_64-apple-darwin.tar.xz"
      sha256 "bba3d68fdd429bf96597cfb7e899f1046061f17a363f7be029a13530fe4ae1b5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gruberchris/kimmydb/releases/download/v0.10.1/kimmy-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "b2cbd1716c54c168f00dc516950284dd29d4bd3bc8826fba84b609f4e0792eff"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gruberchris/kimmydb/releases/download/v0.10.1/kimmy-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "a53ffc573e891d118d277a686f889abdcfb5d33ff971b69cf38fb9d590e070a6"
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
