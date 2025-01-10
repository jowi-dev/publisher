defmodule AbstractEmporium do
  @moduledoc """
  Documentation for `AbstractEmporium`.
  """

  use NimblePublisher,
    build: Article,
    from: Application.app_dir(:abstract_emporium, "posts/**/*.md"),
    as: :articles,
    highlighters: [:makeup_elixir, :makeup_erlang]

  @doc """
  Hello world.

  ## Examples

      iex> AbstractEmporium.hello()
      :world

  """
  def build(file) do
    Article.build(
    
  end
end
