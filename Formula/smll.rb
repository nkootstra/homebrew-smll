class Smll < Formula
  desc "Tiny wrapper that compresses noisy command output for coding agents"
  homepage "https://github.com/nkootstra/smll"

  # Source fallback for platforms without a prebuilt bottle (e.g. macOS Intel).
  # Version is inferred from the tag in the source URL; brew audit --strict
  # rejects a redundant top-level `version` declaration for GitHub-tag URLs.
  # Anchor: source-url (bump-formula.py rewrites the next line)
  url "https://github.com/nkootstra/smll/archive/refs/tags/v1.8.1.tar.gz"
  # Anchor: source-sha256 (bump-formula.py rewrites the next line)
  sha256 "93d205c21b725eef97b21429dd94553d23d1667cfe4867152f135ac42b763805"
  license "MIT"

  on_macos do
    on_arm do
      # Anchor: macos-arm64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.8.1/smll-1.8.1-aarch64-apple-darwin.tar.gz"
      # Anchor: macos-arm64-sha256 (bump-formula.py rewrites the next line)
      sha256 "af35c38d7bfb282af7ef5487f4d8eadc1dc412fa0b7b0c834023abb6a7f6b5d4"
    end

    on_intel do
      depends_on "zig" => :build
    end
  end

  on_linux do
    on_intel do
      # Anchor: linux-x86_64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.8.1/smll-1.8.1-x86_64-linux-gnu.tar.gz"
      # Anchor: linux-x86_64-sha256 (bump-formula.py rewrites the next line)
      sha256 "0d31acf102001512a916053f71914450d98c7dc2b0a14af236f2bd272eb3f68a"
    end
    on_arm do
      # Anchor: linux-arm64-url (bump-formula.py rewrites the next line)
      url "https://github.com/nkootstra/smll/releases/download/v1.8.1/smll-1.8.1-aarch64-linux-gnu.tar.gz"
      # Anchor: linux-arm64-sha256 (bump-formula.py rewrites the next line)
      sha256 "622d2a86e3b66fa97223978ff67bb1cf2aa75b13b1fd53e777753e453aafa8b4"
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
