# #  mix.exs -*- mode: elixir-ts -*-
# https://hexdocs.pm/mix/1.18.4/Mix.html


defmodule {{cookiecutter.proj_name|title}}.MixProject do
  use Mix.Project

  def project do
    [
      apps: [:ex_{{cookiecutter.proj_name}}, :exlib_{{cookiecutter.proj_name}}],
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_options: [warnings_as_errors: true],

      apps_path:   "src",
      deps_path: "./.temp/elixir/deps",
      build_path:  "./.temp/elixir/build",
      config_path: "./config.exs",
      lockfile: "./mix.lock",

      elixirc_options: [warnings_as_errors: true],
      # elixirc_paths: ["src/ex_{{cookiecutter.proj_name}}"],
      # test_paths: ["src/ex_{{cookiecutter.proj_name}}/test"],

      # Docs
      name: "polyglot test",
      source_url: "https://github.com/jgrey4296/{{cookiecutter.proj_name}}",
      homepage_url: "https:/github.com/jgrey4296/{{cookiecutter.proj_name}}",
      docs: &docs/0
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.38.4", only: :dev}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp docs do
    [
      output: ".temp/docs/elixir",
    ]
  end
end
