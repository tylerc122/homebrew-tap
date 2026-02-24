# This file lives in your homebrew-tap repo:
#   https://github.com/tylerc122/homebrew-tap/Formula/gitagent.rb
#
# Usage:
#   brew tap tylerc122/tap
#   brew install gitagent
#
# To update to a new release:
#   1. Tag a release on GitHub (e.g. v1.1.0)
#   2. Run: curl -sL https://github.com/tylerc122/git_agent/archive/refs/tags/v1.1.0.tar.gz | shasum -a 256
#   3. Update `url` and `sha256` below

class Gitagent < Formula
  include Language::Python::Virtualenv
  desc "Autonomous CI/CD remediation — watches CI fail, figures out why, fixes it, opens a PR"
  homepage "https://github.com/tylerc122/git_agent"
  url "https://github.com/tylerc122/git_agent/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "734ed89b1d93ecc35dd93adf3b05c0b547ac539c3466999c0b37530eb05513e4"
  license "MIT"

  head "https://github.com/tylerc122/git_agent.git", branch: "main"

  depends_on "python@3.11"

  def install
    venv = virtualenv_create(libexec, "python3.11")
    venv.pip_install_and_link(buildpath)
  end

  def caveats
    <<~EOS
      Set your Anthropic API key before running:
        export ANTHROPIC_API_KEY=sk-ant-...

      GitAgent requires Docker to be running for its sandbox.

      For --create-pr, set GH_TOKEN or run: gh auth login
    EOS
  end

  test do
    assert_match "GitAgent", shell_output("#{bin}/gitagent --help 2>&1", 2)
  end
end
