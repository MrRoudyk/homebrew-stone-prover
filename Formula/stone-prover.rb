class StoneProver < Formula
  desc "Stone Prover"
  homepage "https://github.com/baking-bad/stone-prover"
  license "MIT"

  # Эти поля будут заменены workflow через sed
  url "https://github.com/MrRoudyk/stone-packaging/releases/download/v1.0.5/stone-prover-1.0.5-macos-arm64.tar.gz"
  sha256 "a2827877c53ca88b6a95177ee0e3bcfca3f95c766f85c5f5f6ee7cd329ba21d1"

  depends_on "gmp"
  depends_on "python@3.9"

  def install
    # Распаковать архив в libexec
    libexec.install Dir["*"]

    # Установить бинарные файлы в bin без суффиксов архитектуры
    bin.install_symlink libexec/"cpu_air_prover-#{arch_suffix}" => "cpu_air_prover"
    bin.install_symlink libexec/"cpu_air_verifier-#{arch_suffix}" => "cpu_air_verifier"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cpu_air_prover --version")
    assert_match version.to_s, shell_output("#{bin}/cpu_air_verifier --version")
  end

  # Метод для определения суффикса архитектуры, если необходимо
  def arch_suffix
    if Hardware::CPU.arm?
      "arm64"
    else
      "x86_64"
    end
  end
end
