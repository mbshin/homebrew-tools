# Homebrew formula template. release.sh fills in 1.6.2 and 7f2e92fa94a14d9cf0c8091bde88c3334dc43994bbb213564efef4662a32e6b6 and writes it to the tap
# github.com/mbshin/homebrew-tools (Formula/aisw.rb).
class Aisw < Formula
  desc "Keep coding when an AI agent hits its usage limit: next Claude account, then Codex"
  homepage "https://github.com/mbshin/aisw"
  url "https://github.com/mbshin/aisw/archive/refs/tags/v1.6.2.tar.gz"
  sha256 "7f2e92fa94a14d9cf0c8091bde88c3334dc43994bbb213564efef4662a32e6b6"
  license "MIT"

  depends_on "fzf" # aisw resume
  depends_on "jq"
  depends_on "uv" # runs ui.py; Textual is fetched into uv's cache on the first `aisw ui`

  def install
    libexec.install "aisw", "common.sh", "on-limit.sh", "statusline.sh", "signin-browser.sh", "ui.py", "admin.sh", "fallback.sh"
    # An exec script, not a symlink, so `dirname "$0"` in aisw still finds common.sh.
    bin.write_exec_script libexec/"aisw"
  end

  def caveats
    <<~EOS
      Set up the account folders, status line and limit hook, then log in:
        aisw setup
        aisw login
      Optional, to keep typing `claude`:
        echo "alias claude='aisw claude'" >> ~/.zshrc
    EOS
  end

  test do
    assert_match "A: free", shell_output("#{bin}/aisw status")
  end
end
