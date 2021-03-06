defmodule Tina.MixProject do
  use Mix.Project

  def project do
    [
      app: :tina,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:hackney, "~> 1.16.0"},
      {:jason, ">= 1.0.0"},
      {:tesla, "~> 1.3.0"},
      {:websockex, "~> 0.4.2"}
    ]
  end

  # defp package do
  #   [
  #     maintainers: ["Brady Fontenot"],
  #     files: ["lib/**/*.ex", "mix*", "*.md"],
  #     licenses: ["MIT"],
  #     links: %{"GitHub" => "https://github.com/bradyfontenot/tina"}
  #   ]
  # end
end
