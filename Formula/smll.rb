class Smll < Formula
  desc "Tiny wrapper that compresses noisy command output for coding agents"
  homepage "https://github.com/nkootstra/smll"
  license "MIT"

  # Source fallback for platforms without a prebuilt bottle (e.g. macOS Intel).
  # Version is inferred from the tag in the source URL; brew audit --strict
  # rejects a redundant top-level `version` declaration for GitHub-tag URLs.
  # Anchor: source-url (bump-formula.py rewrites the next line)
  url "https://github.com/nkootstra/smll/archive/refs/tags/v1.0.2.tar.gz"
  # Anchor: source-sha256 (bump-formula.py rewrites the next line)
  sha256 "1298e0ae20e20eac4909e57b700fe6744e875e202d66aca5f1780fb5483a21e8"
  depends_on "zig" => :build

  on_macos do
    on_arm do
      # Anchor: macos-arm64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.0.2/smll-1.0.2-aarch64-apple-darwin.tar.gz"
      # Anchor: macos-arm64-sha256 (bump-formula.py rewrites the next line)
      sha256 "012316401b7ed100c71811e01c9d45099c358ed1338e3e7dc5b3c7c5f194a979"
    end
  end

  on_linux do
    on_intel do
      # Anchor: linux-x86_64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.0.2/smll-1.0.2-x86_64-linux-gnu.tar.gz"
      # Anchor: linux-x86_64-sha256 (bump-formula.py rewrites the next line)
      sha256 "5a9c34209fd174f2c3eace88fcd0060a093ab1ed5fd52b6490c5516028b87c23"
    end
    on_arm do
      # Anchor: linux-arm64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.0.2/smll-1.0.2-aarch64-linux-gnu.tar.gz"
      # Anchor: linux-arm64-sha256 (bump-formula.py rewrites the next line)
      sha256 "65d71302807fe30452d2fcca7fc12769ce2dccf6e9d335c6938d1b7fa11979f8"
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
