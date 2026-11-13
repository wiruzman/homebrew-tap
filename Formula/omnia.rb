class Omnia < Formula
  desc "Keyboard-first terminal file search app for macOS"
  homepage "https://github.com/wiruzman/omnia"
  url "https://github.com/wiruzman/omnia/releases/download/v0.1.6/omnia-v0.1.6.tar.gz"
  sha256 "2904a7614c2364facd74ea94ac051e9326f2ac1d813caae73c0d5a75b385cb1a"
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
