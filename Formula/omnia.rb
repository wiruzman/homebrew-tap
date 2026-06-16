class Omnia < Formula
  desc "Keyboard-first terminal file search app for macOS"
  homepage "https://github.com/wiruzman/omnia"
  url "https://github.com/wiruzman/omnia/releases/download/v0.0.3/omnia-v0.0.3.tar.gz"
  sha256 "c1d79bb4a967c26d1f3a78cc9c546c9c417fb2aef137cb5a0df0bd32ff214f42"
  license "MIT"
  head "https://github.com/wiruzman/omnia.git", branch: "master"

  depends_on "go" => :build
  depends_on :macos

  def install
    ldflags = "-s -w -X github.com/wiruzman/omnia/internal/version.Version=#{version}"
    system "go", "build", *std_go_args(output: bin/"omnia", ldflags: ldflags), "./cmd/omnia"
    system "go", "build", *std_go_args(output: bin/"omnia-daemon", ldflags: ldflags), "./cmd/omnia-daemon"
  end

  service do
    run [opt_bin/"omnia-daemon"]
    keep_alive true
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/omnia --version")
    assert_match version.to_s, shell_output("#{bin}/omnia-daemon --version")
  end
end
