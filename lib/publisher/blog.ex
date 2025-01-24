defmodule Publisher.Blog do
  alias Publisher.Html

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
      Publisher.Article.build(
        Path.basename(file), 
        attrs, 
        html
      )
    end)
  end
  
  def all_posts do
    read_posts(get_log_path())
  end


  # Generate all HTML files
  def generate_site() do
    posts = all_posts()
    root = get_site_path()
    # Generate individual post pages
    Logger.info("#{inspect(all_posts())}")
    for post <- posts do
      path = root <> "/posts/" <> "#{post.id}.html"
      content = Html.render_post(post)
      Logger.info("rendering post to #{post.path}")
      File.write!(path, content)
    end

    # Generate index page
    File.write!(root <> "/index.html", Html.render_index(posts))
  end

  # This is a value that is generated and stored in our home manager config
  defp get_log_path, do: Application.get_env(Publisher, :log_path) || System.get_env("LOG_DIR_PERSONAL")
  # This is a value that is generated and stored in our home manager config
  defp get_site_path, do: Application.get_env(Publisher, :output_path) || System.get_env("SITE_PERSONAL")
end
