defmodule AbstractEmporium do
  @moduledoc """
  Documentation for `AbstractEmporium`.
  """

  def main(_args) do
    AbstractEmporium.Blog.generate_site("site")
    #System.cmd("mv", ["_build/dev/lib/abstract_emporium/_site/*", "site/"])
  end
end
