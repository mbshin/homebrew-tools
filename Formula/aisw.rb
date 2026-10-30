# Homebrew formula template. release.sh fills in 1.4.1 and a2352fcab051b3678b2edcffd1c212d4a92a4c63abf82ae80dd67129e9e8419b and writes it to the tap
# github.com/mbshin/homebrew-tools (Formula/aisw.rb).
class Aisw < Formula
  desc "Keep coding when an AI agent hits its usage limit: next Claude account, then Codex"
  homepage "https://github.com/mbshin/aisw"
  url "https://github.com/mbshin/aisw/archive/refs/tags/v1.4.1.tar.gz"
  sha256 "a2352fcab051b3678b2edcffd1c212d4a92a4c63abf82ae80dd67129e9e8419b"
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
