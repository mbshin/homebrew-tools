# Homebrew formula template. release.sh fills in 2.0.1 and 25a691cb894943457e1ed495a5d70a7935c3fff1189388e6f628fa9f56a5823d and writes it to the tap
# github.com/mbshin/homebrew-tools (Formula/aisw.rb).
class Aisw < Formula
  desc "One list of AI accounts (Claude Code, Codex, Antigravity): pick one, start it"
  homepage "https://github.com/mbshin/aisw"
  url "https://github.com/mbshin/aisw/archive/refs/tags/v2.0.1.tar.gz"
  sha256 "25a691cb894943457e1ed495a5d70a7935c3fff1189388e6f628fa9f56a5823d"
  license "MIT"

  depends_on "jq"
  depends_on "uv" # runs ui.py; Textual is fetched into uv's cache on the first `aisw list`

  def install
    libexec.install "aisw", "common.sh", "tools.sh", "on-limit.sh", "statusline.sh", "signin-browser.sh", "ui.py"
    # An exec script, not a symlink, so `dirname "$0"` in aisw still finds common.sh.
    bin.write_exec_script libexec/"aisw"
    zsh_completion.install "completions/_aisw"
  end

  def caveats
    <<~EOS
      Add an account (the first one also sets up the status line, limit hook and a ~/.zshrc line):
        aisw add claude
      Then: aisw activate a, and start it with: aisw
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aisw --version")
  end
end
