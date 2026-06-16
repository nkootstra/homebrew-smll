class Smll < Formula
  desc "Tiny wrapper that compresses noisy command output for coding agents"
  homepage "https://github.com/nkootstra/smll"

  # Source fallback for platforms without a prebuilt bottle (e.g. macOS Intel).
  # Version is inferred from the tag in the source URL; brew audit --strict
  # rejects a redundant top-level `version` declaration for GitHub-tag URLs.
  # Anchor: source-url (bump-formula.py rewrites the next line)
  url "https://github.com/nkootstra/smll/archive/refs/tags/v1.8.0.tar.gz"
  # Anchor: source-sha256 (bump-formula.py rewrites the next line)
  sha256 "fa789f5c09973020636e9bde76ad9591e012464596d5d2fee29c8ed7a08a81be"
  license "MIT"

  on_macos do
    on_arm do
      # Anchor: macos-arm64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.8.0/smll-1.8.0-aarch64-apple-darwin.tar.gz"
      # Anchor: macos-arm64-sha256 (bump-formula.py rewrites the next line)
      sha256 "9838e2aae401ae3d70a3fe4341c11e0d1cc5f1b99b412e040ac8bf102aab8cae"
    end

    on_intel do
      depends_on "zig" => :build
    end
  end

  on_linux do
    on_intel do
      # Anchor: linux-x86_64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.8.0/smll-1.8.0-x86_64-linux-gnu.tar.gz"
      # Anchor: linux-x86_64-sha256 (bump-formula.py rewrites the next line)
      sha256 "3e54bca4fad22e6898a66e0c02c40f9e7a2a41fc364f430a7cedc23e5035522f"
    end
    on_arm do
      # Anchor: linux-arm64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.8.0/smll-1.8.0-aarch64-linux-gnu.tar.gz"
      # Anchor: linux-arm64-sha256 (bump-formula.py rewrites the next line)
      sha256 "9af24c4b39ecff375f0e3ac113b465f56832305ce7632cf4fd0d3a57a2df78fa"
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
    assert_equal "smll #{version}\n", shell_output("#{bin}/smll --version")
  end
end
