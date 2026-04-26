class Smll < Formula
  desc "Tiny wrapper that compresses noisy command output for coding agents"
  homepage "https://github.com/nkootstra/smll"
  license "MIT"

  # Source fallback for platforms without a prebuilt bottle (e.g. macOS Intel).
  # Version is inferred from the tag in the source URL; brew audit --strict
  # rejects a redundant top-level `version` declaration for GitHub-tag URLs.
  # Anchor: source-url (bump-formula.py rewrites the next line)
  url "https://github.com/nkootstra/smll/archive/refs/tags/v1.0.0.tar.gz"
  # Anchor: source-sha256 (bump-formula.py rewrites the next line)
  sha256 "35b7764ca7a5be1b50bcc6c5fe11a4e61e056433cd83590c2ae7de7449784e7d"
  depends_on "zig" => :build

  on_macos do
    on_arm do
      # Anchor: macos-arm64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.0.0/smll-1.0.0-aarch64-apple-darwin.tar.gz"
      # Anchor: macos-arm64-sha256 (bump-formula.py rewrites the next line)
      sha256 "31984afd3b8701ead5f7ae920f6733268ba55336811f8ea67980ab56bd407092"
    end
  end

  on_linux do
    on_intel do
      # Anchor: linux-x86_64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.0.0/smll-1.0.0-x86_64-linux-gnu.tar.gz"
      # Anchor: linux-x86_64-sha256 (bump-formula.py rewrites the next line)
      sha256 "cf51d41d2cd3c007b0d2348153d16ce805c3607ec758da82ebd086c722aade5e"
    end
    on_arm do
      # Anchor: linux-arm64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.0.0/smll-1.0.0-aarch64-linux-gnu.tar.gz"
      # Anchor: linux-arm64-sha256 (bump-formula.py rewrites the next line)
      sha256 "71fa454b3e3ab2080508843bd85f4be19c99ca96cc929af8f405aabbf97b87be"
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
