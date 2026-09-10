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
      sha256 "0c0f90f87509cb1c12af5edf2962167890e03a4fe151e01c7fa556a682942c62"
    end
    on_intel do
      url "https://github.com/rodrigodotdev/warden/releases/download/v0.2.0/warden-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "2bfabd046add252733f8ef5460490f2124843f496528afd9133e202d8c1f35b1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rodrigodotdev/warden/releases/download/v0.2.0/warden-v0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2566e4a75eecd3d6450ffc6f9b9ded17e778b3ecec08a7f2fab91b469b8ba225"
    end
    on_intel do
      url "https://github.com/rodrigodotdev/warden/releases/download/v0.2.0/warden-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "37575889c2ec8801023e63a5e7ca2e6534a08a59b7280c9a6c9aac5a3c737183"
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
