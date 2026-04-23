class Smll < Formula
  desc "Tiny wrapper that compresses noisy command output for coding agents"
  homepage "https://github.com/nkootstra/smll"
  license "MIT"

  # Source fallback for platforms without a prebuilt bottle (e.g. macOS Intel).
  # Version is inferred from the tag in the source URL; brew audit --strict
  # rejects a redundant top-level `version` declaration for GitHub-tag URLs.
  # Anchor: source-url (bump-formula.py rewrites the next line)
  url "https://github.com/nkootstra/smll/archive/refs/tags/v0.7.0.tar.gz"
  # Anchor: source-sha256 (bump-formula.py rewrites the next line)
  sha256 "28fc508a954a9ecc77dabaab3fe6981d4c38d224242a37a5d7359b61b66a830b"
  depends_on "zig" => :build

  on_macos do
    on_arm do
      # Anchor: macos-arm64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v0.7.0/smll-0.7.0-aarch64-apple-darwin.tar.gz"
      # Anchor: macos-arm64-sha256 (bump-formula.py rewrites the next line)
      sha256 "88bdc9842bb30ac87bb41af3ccfecc0e1bf9a54b6249bf1c0e1d204bba9ab9ba"
    end
  end

  on_linux do
    on_intel do
      # Anchor: linux-x86_64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v0.7.0/smll-0.7.0-x86_64-linux-gnu.tar.gz"
      # Anchor: linux-x86_64-sha256 (bump-formula.py rewrites the next line)
      sha256 "9fd4bef6f40d5824558327612455116dc63070ef8633c0bfcc141eff4cbe756f"
    end
    on_arm do
      # Anchor: linux-arm64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v0.7.0/smll-0.7.0-aarch64-linux-gnu.tar.gz"
      # Anchor: linux-arm64-sha256 (bump-formula.py rewrites the next line)
      sha256 "bcb509a135ee036dc9f90377809950d1e0d571cede20af2a9dc9763935e174a5"
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
