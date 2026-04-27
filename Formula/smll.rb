class Smll < Formula
  desc "Tiny wrapper that compresses noisy command output for coding agents"
  homepage "https://github.com/nkootstra/smll"
  license "MIT"

  # Source fallback for platforms without a prebuilt bottle (e.g. macOS Intel).
  # Version is inferred from the tag in the source URL; brew audit --strict
  # rejects a redundant top-level `version` declaration for GitHub-tag URLs.
  # Anchor: source-url (bump-formula.py rewrites the next line)
  url "https://github.com/nkootstra/smll/archive/refs/tags/v1.2.0.tar.gz"
  # Anchor: source-sha256 (bump-formula.py rewrites the next line)
  sha256 "b3b8730cc48096cad5d52412bb3bcb2ffc7efe59f3b8c55e13fea47c987aedd0"
  depends_on "zig" => :build

  on_macos do
    on_arm do
      # Anchor: macos-arm64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.2.0/smll-1.2.0-aarch64-apple-darwin.tar.gz"
      # Anchor: macos-arm64-sha256 (bump-formula.py rewrites the next line)
      sha256 "3659a345b5a7ae6b886094146117d1953506ae4baf9f7e62b9a0ff26e99abbe0"
    end
  end

  on_linux do
    on_intel do
      # Anchor: linux-x86_64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.2.0/smll-1.2.0-x86_64-linux-gnu.tar.gz"
      # Anchor: linux-x86_64-sha256 (bump-formula.py rewrites the next line)
      sha256 "7fe8b3443b2255276bae4e37ade7e0074f8804fce4554ffb318dbe282117fa03"
    end
    on_arm do
      # Anchor: linux-arm64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.2.0/smll-1.2.0-aarch64-linux-gnu.tar.gz"
      # Anchor: linux-arm64-sha256 (bump-formula.py rewrites the next line)
      sha256 "3529d0de2bd87a3636644f77c559945e72768d6f1c9c89a7df615686abe1a4d8"
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
