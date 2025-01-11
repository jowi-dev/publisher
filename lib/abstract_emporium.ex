defmodule AbstractEmporium do
  @moduledoc """
  Documentation for `AbstractEmporium`.
  """

  def main(_args) do
    AbstractEmporium.Blog.generate_site()
  end
end
