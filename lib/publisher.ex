defmodule Publisher do
  @moduledoc """
  Publisher is a library for generating static HTML sites from Markdown.

  It consists of two functions: 
  - `main/1` for use as an escript application
  - `generate_site/0` for using Publisher as a library to your application

  In either case, the Library will ingest markdown from `Application.get_env(Publisher, :log_path)` and 
    generate HTML which is output to `Application.get_env(Publisher, :output_path)`. 

  Rendering by default happens from the `Publisher.Html.render_$X/1` functions, but may be overridden via
    `Application.get_env(Publisher, :render_post)` or `Application.get_env(Publisher, :render_index)` for 
    overriding posts or the home page respectively. If you choose to override these functions, ensure
    the calling functions ingest a `Publisher.Article.t()` object and return stringified HTML.

  """

  @doc """
  This function exists so publisher can be used in an escript format
    iex> Publisher.main(nil)
    ""
  """
  def main(_args) do
    Publisher.Blog.generate_site()
  end

  @doc """
  Generate site exposed for use as a library call
    iex> Publisher.generate_site()
    ""
  """
  defdelegate generate_site(), to: Publisher.Blog
end
