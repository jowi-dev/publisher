defmodule Publisher.Html do

  @doc """
  Renders a post in HTML
  """
  @spec render_post(Publisher.Article.t()) :: String.t()
  def render_post(post) do
    """
    <!DOCTYPE html>
    <html>
    <head>
      <title>#{post.title}</title>
      <meta charset="utf-8">
    </head>
    <body>
      <article>
        <h1>#{post.title}</h1>
        <span>#{post.author}</span>
        <div class="content">
          #{post.body}
        </div>
      </article>
    </body>
    </html>
    """
    |> NimblePublisher.highlight()
  end

  
  @doc """
  Renders the index/home page for a blog site
  """
  @spec render_index([Publisher.Article.t()]) :: String.t()
  def render_index(posts) do
    post_links = Enum.map(posts, fn post ->
      """
      <li>
        <h2><a href="/posts/#{post.id}.html">#{post.title}</a></h2>
      </li>
      """
    end)
    |> Enum.join("\n")

    """
    <!DOCTYPE html>
    <html>
    <head>
      <title>Blog Posts</title>
      <meta charset="utf-8">
    </head>
    <body>
      <h1>Blog Posts</h1>
      <ul>
        #{post_links}
      </ul>
    </body>
    </html>
    """
  end
  
end
