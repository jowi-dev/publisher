defmodule Publisher do
  @moduledoc """
  Documentation for `Publisher`.
  """

  def main(_args) do
    Publisher.Blog.generate_site()
  end
end
