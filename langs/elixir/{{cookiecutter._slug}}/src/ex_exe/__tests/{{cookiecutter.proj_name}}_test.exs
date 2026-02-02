# #  {{cookiecutter.proj_name}}_test.exs -*- mode: elixir -*-


defmodule {{cookiecutter.proj_name|title}}_Test do
  use ExUnit.Case
  # doctest Ex{{cookiecutter.proj_name|title}}

  test "greets the world" do
    assert Ex{{cookiecutter.proj_name|title}}.hello() == :world
  end
end
