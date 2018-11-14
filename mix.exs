defmodule AliyunSms.MixProject do
  use Mix.Project

  def project do
    [
      app: :aliyun_sms,
      version: "0.2.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.1"},
      {:aliyun_util, "~> 0.3.0"},
      {:httpoison, "~> 1.4"},
      {:ex_doc, "~> 0.18", only: :dev},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp description do
    """
    Aliyun SMS API(阿里云短信API)
    """
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/ug0/aliyun_sms"},
      source_urL: "https://github.com/ug0/aliyun_sms",
      homapage_url: "https://github.com/ug0/aliyun_sms"
    ]
  end
end
