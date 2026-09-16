# typed: false
# frozen_string_literal: true

# Rendered by packaging/homebrew/render.sh from the assets of one release. Do not edit
# this file in the tap: the next tag overwrites it.
class Warden < Formula
  desc "Safe, read-only MCP gateway to explore MySQL and PostgreSQL"
  homepage "https://github.com/rodrigodotdev/warden"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rodrigodotdev/warden/releases/download/v0.3.0/warden-v0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "4e7fcbf8d509778835ba950f7e0c9e1f33cdabe78042bab41d63031a0a597e7c"
    end
    on_intel do
      url "https://github.com/rodrigodotdev/warden/releases/download/v0.3.0/warden-v0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "22cb51a1e597c4c1143737f2173f6ac3d9b5154b011395c88556fc0d499008d2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rodrigodotdev/warden/releases/download/v0.3.0/warden-v0.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "43d2f59a924a7d93f544ff4720f8b7daa7a5ce41061ba138fea538a0f6320fe1"
    end
    on_intel do
      url "https://github.com/rodrigodotdev/warden/releases/download/v0.3.0/warden-v0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "473c90e788514bd6c924c22fda29f65766b03aa967ea4e5279c53357e65b03df"
    end
  end

  def install
    bin.install "warden"
    # MIT requires the notice to accompany the software, and CDLA-Permissive-2.0
    # requires the webpki-roots notice to accompany the root data Warden
    # redistributes. Both travel in the archive; both are kept here.
    prefix.install "LICENSE"
    prefix.install "LICENSES"
    doc.install "README.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/warden version")

    # `check` on a configuration naming no connection is the smallest end-to-end
    # exercise that touches argument parsing, the config loader, and the exit path
    # without needing a database.
    (testpath/"warden.toml").write <<~TOML
      version = 1
    TOML
    shell_output("#{bin}/warden check --config #{testpath}/warden.toml 2>&1", 1)
  end
end
