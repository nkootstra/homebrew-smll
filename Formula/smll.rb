class Smll < Formula
  desc "Tiny wrapper that compresses noisy command output for coding agents"
  homepage "https://github.com/nkootstra/smll"
  license "MIT"

  # Source fallback for platforms without a prebuilt bottle (e.g. macOS Intel).
  # Version is inferred from the tag in the source URL; brew audit --strict
  # rejects a redundant top-level `version` declaration for GitHub-tag URLs.
  # Anchor: source-url (bump-formula.py rewrites the next line)
  url "https://github.com/nkootstra/smll/archive/refs/tags/v1.0.4.tar.gz"
  # Anchor: source-sha256 (bump-formula.py rewrites the next line)
  sha256 "b3314e1795bfac9ec4d0fcc4eb0ffa068a3c187c64d54cd0ad2b4424a346c589"
  depends_on "zig" => :build

  on_macos do
    on_arm do
      # Anchor: macos-arm64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.0.4/smll-1.0.4-aarch64-apple-darwin.tar.gz"
      # Anchor: macos-arm64-sha256 (bump-formula.py rewrites the next line)
      sha256 "7c08794cd9b37abd4150589ab655e79f8473d816b684c36c119e12e8eb2ec644"
    end
  end

  on_linux do
    on_intel do
      # Anchor: linux-x86_64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.0.4/smll-1.0.4-x86_64-linux-gnu.tar.gz"
      # Anchor: linux-x86_64-sha256 (bump-formula.py rewrites the next line)
      sha256 "4ad5927e23df3b7b6dbb5e2b2c4f8984232c1c653e2ab4a4e60d4c2953ff773d"
    end
    on_arm do
      # Anchor: linux-arm64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.0.4/smll-1.0.4-aarch64-linux-gnu.tar.gz"
      # Anchor: linux-arm64-sha256 (bump-formula.py rewrites the next line)
      sha256 "23f8a5314f019325c8f36cf44118603524025ef8abb90f99898fbf27137d70b8"
    end
  end

  def install
    # Source tarballs contain build.zig; binary tarballs contain only the smll executable.
    if File.exist?("build.zig")
      system "zig", "build", "release"
      bin.install "zig-out/release/smll"
    else
      bin.install "smll"
    end
  end

  test do
    # smll passes unknown commands through untouched (R3 lossless default).
    # `smll echo hello` invokes `echo hello` and emits its stdout byte-for-byte.
    assert_equal "hello\n", shell_output("#{bin}/smll echo hello")
  end
end
