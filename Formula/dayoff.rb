class Dayoff < Formula
  desc "Fill out LAUSD absence forms from the terminal"
  homepage "https://github.com/aforkedthread/homebrew-tap"
  url "https://dayoff-releases.peppr.dev/source/dayoff-cli-0.1.0.tar.gz"
  sha256 "f75d1d564f6c2a731403df735c89d8268cdbf9dbf51a14846bf10e5b9a70afb5"

  livecheck do
    url "https://dayoff-releases.peppr.dev/source/latest.txt"
    regex(/v?(\d+(?:\.\d+)+)/i)
  end

  bottle do
    root_url "https://dayoff-releases.peppr.dev/bottles"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "39036fa8b907ea2a542eec9dcdc96949d98066f1cf2a15d3cf1cf30d53ac0647"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f90df052c0406bf140e096ea5918229eeb3ba4a637a2fb9739b6af3b58972523"
  end

  depends_on :macos
  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
    # build the trackpad window now so nobody waits on it later
    system "swiftc", "-O", "-o", libexec/"lib/node_modules/dayoff-cli/lib/trackpad-sign", "lib/trackpad-sign.swift"
  end

  test do
    assert_match "fill out an absence form", shell_output("#{bin}/dayoff --help")
    # render a stroke through the helper without opening a window
    (testpath/"strokes.json").write '{"aspect":1.6,"strokes":[[[0.1,0.5],[0.5,0.7],[0.9,0.5]]]}'
    system libexec/"lib/node_modules/dayoff-cli/lib/trackpad-sign", testpath/"sig.png", testpath/"strokes.json"
    assert_path_exists testpath/"sig.png"
  end
end
