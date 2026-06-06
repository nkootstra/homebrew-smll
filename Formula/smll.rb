class Smll < Formula
  desc "Tiny wrapper that compresses noisy command output for coding agents"
  homepage "https://github.com/nkootstra/smll"

  # Source fallback for platforms without a prebuilt bottle (e.g. macOS Intel).
  # Version is inferred from the tag in the source URL; brew audit --strict
  # rejects a redundant top-level `version` declaration for GitHub-tag URLs.
  # Anchor: source-url (bump-formula.py rewrites the next line)
  url "https://github.com/nkootstra/smll/archive/refs/tags/v1.5.1.tar.gz"
  # Anchor: source-sha256 (bump-formula.py rewrites the next line)
  sha256 "a71a5b24a43549f8cd81de62ad0ce0a8a629cb33c590948b653083cf920dcb2f"
  license "MIT"

  on_macos do
    on_arm do
      # Anchor: macos-arm64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.5.1/smll-1.5.1-aarch64-apple-darwin.tar.gz"
      # Anchor: macos-arm64-sha256 (bump-formula.py rewrites the next line)
      sha256 "2e8bd96b437a8a33a81a8672ab654a6d1f20b64c69deed1fe0fa6312bc99778e"
    end

    on_intel do
      depends_on "zig" => :build
    end
  end

  on_linux do
    on_intel do
      # Anchor: linux-x86_64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.5.1/smll-1.5.1-x86_64-linux-gnu.tar.gz"
      # Anchor: linux-x86_64-sha256 (bump-formula.py rewrites the next line)
      sha256 "5aefd178eb9ddc5f8ece3efe439c6c0c9c877630c34fceb34a7e4c32868c2da5"
    end
    on_arm do
      # Anchor: linux-arm64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.5.1/smll-1.5.1-aarch64-linux-gnu.tar.gz"
      # Anchor: linux-arm64-sha256 (bump-formula.py rewrites the next line)
      sha256 "7820b8fd3d96a98e856fd686596866e694949412abeaf4a4eaa843f2b5c4e418"
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
