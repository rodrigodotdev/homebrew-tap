# typed: false
# frozen_string_literal: true

# Rendered by packaging/homebrew/render.sh from the assets of one release. Do not edit
# this file in the tap: the next tag overwrites it.
class Warden < Formula
  desc "Safe, read-only MCP gateway to explore MySQL and PostgreSQL"
  homepage "https://github.com/rodrigodotdev/warden"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rodrigodotdev/warden/releases/download/v0.2.0/warden-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "ab1b6859212f59d5e50ea993a28837a489245a5ef00a2eeb0d14d43c01db4fdf"
    end
    on_intel do
      url "https://github.com/rodrigodotdev/warden/releases/download/v0.2.0/warden-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "c58cfbe101ea817cdf7a74e45677b7327731d671ccda90876fa4f250b9eb27f7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rodrigodotdev/warden/releases/download/v0.2.0/warden-v0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "91e08408c078e0685a8d7a54b8a930855d295d4d4ab8f5a6d24b62d643b49200"
    end
    on_intel do
      url "https://github.com/rodrigodotdev/warden/releases/download/v0.2.0/warden-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "31b657ee185158f6b44b389289c5045cfc6d4e3bc8e7cda3b2213ffb235dd8ff"
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
