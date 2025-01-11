defmodule AbstractEmporium.Blog do
  require Logger

  use NimblePublisher,
    build: AbstractEmporium.Article,
    from: "/Users/jowi/Projects/abstract_emporium/priv/posts/ts_to_ex/*.md",
    as: :posts,
    highlighters: [:makeup_elixir]

  # The @posts attribute is populated by NimblePublisher
  def all_posts, do: @posts

  #def all_tags, do: @tags

  #def published_posts, do: Enum.filter(all_posts(), &(&1.date <= Date.utc_today()))

  #def posts_by_tag(tag), do: Enum.filter(all_posts(), &(tag in &1.tags))

  # Create HTML for a single post
  def render_post(post) do
    #<p>Published on: #{Calendar.strftime(post.date, "%B %d, %Y")}</p>
    #
    #        <div class="tags">
    #          Tags: #{Enum.join(post.tags, ", ")}
    #        </div>
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
        <div class="content">
          #{post.body}
        </div>
      </article>
    </body>
    </html>
    """
  end

  # Create an index page with all posts
  def render_index do
    posts = all_posts()
    #|> Enum.sort_by(& &1.date, {:desc, Date})
    #<p>#{post.description}</p>
    #<p>Published on: #{Calendar.strftime(post.date, "%B %d, %Y")}</p>

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

  # Generate all HTML files
  def generate_site(output_dir) do
    root = "/Users/jowi/Projects/abstract_emporium/"<> output_dir 
    # Generate individual post pages
    Logger.info("#{inspect(all_posts())}")
    for post <- all_posts() do
      path = root <> "/posts/" <> "#{post.id}.html"
      content = render_post(post)
      Logger.info("rendering post to #{path}")
      File.write!(path, content)
    end

    # Generate index page
    File.write!(root <> "/index.html", render_index())
  end
end
