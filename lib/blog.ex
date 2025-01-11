defmodule AbstractEmporium.Blog do
  require Logger

  def read_posts(dir) do
    Path.wildcard(Path.join(dir, "**/*.md"))
    |> Enum.map(fn file ->
      content = File.read!(file)
      [frontmatter, markdown] = String.split(content, "---", parts: 2)
      
      # Parse frontmatter
      {attrs, _} = Code.eval_string(frontmatter)
      
      # Convert markdown to HTML
      html = Earmark.as_html!(markdown)
      
      # Build post struct similar to NimblePublisher
      AbstractEmporium.Article.build(
        Path.basename(file), 
        attrs, 
        html
      )
    end)
  end
  
  def all_posts do
    read_posts("/Users/jowi/Projects/abstract_emporium/posts")
  end

  # Create HTML for a single post
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
        <div class="content">
          #{post.body}
        </div>
      </article>
    </body>
    </html>
    """
    |> NimblePublisher.highlight()
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
