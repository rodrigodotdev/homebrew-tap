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
      sha256 "37bc3d9a2d698065436baf723989ff1de17eab41c46eaa6960ee9940a7a797ef"
    end
    on_intel do
      url "https://github.com/rodrigodotdev/warden/releases/download/v0.2.0/warden-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "6cd51f61ecc42e83b8caf90a51eed03041e344bd5e5f290781ed77f853a61602"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rodrigodotdev/warden/releases/download/v0.2.0/warden-v0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7e5f5996bd1d2fe41d79aa744a3dad3800ef27f155b5a46568b5c9c68cd1ed42"
    end
    on_intel do
      url "https://github.com/rodrigodotdev/warden/releases/download/v0.2.0/warden-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d27a889607c32603b64540471e910e14d58ef2ab2b98c836f78c13a176ecf24d"
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
