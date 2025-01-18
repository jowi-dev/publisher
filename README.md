# Publisher

A Static site builder that makes generating html for GitHub Pages as easy as writing markdown.

## Why?

I think there is an underserved niche of people who just want to write markdown and have an easy way to make a website.
GitHub pages is great for publishing simple content, but needs simple front end rendered content to avoid a constant headache.
Publisher aims to give a way to write html once, and render markdown into that HTML template. Follow the simple format

```markdown
%{
 title: "Awesome Blog",
 author: "Mrs. Writer",
 date: "01/18/25",
 published?: true
}
---
# My awesome blog post

This is super important, and also markdown
```

Then, your HTML can be rendered in a familiar HTML-like feel
```
<!DOCTYPE html>
<html>
<head>
  <title>#{post.title}</title>
  <meta charset="utf-8">
</head>
<body>
  <article>
    <h1>#{post.title}</h1>
    <span>#{post.author} #{post.date}</span>
    <div class="content">
      #{post.body}
    </div>
  </article>
</body>
</html>
```


If you would like to override the default rendering function, simply add a config function that accepts a %Publisher.Article{} and returns the HTML as a string.
```elixir
config Publisher,
    render_post: MyApp.render_post/1,
    render_index: MyApp.render_index/1,
    article_path: "~/path/to/my/articles",
    output_path: "~/path/to/my/gh-pages/repo"
```

The `published?` flag is a way to leave your work unpublished without needing to move it out of the directory at compile time. Simply flip the boolean from false to true when ready.

All articles are regenerated when `Publisher.Blog.generate_site/1` is called


### Summary

In short I wrote this project to be a runtime based NimblePublisher, so I could write it as an escript and generate articles as I write them.


### Roadmap
- [ ] HexDocs done
- [ ] Themes initialized with examples
- [ ] Behaviour added for overriding `render_index` and `render_post` with examples
- [ ] implement optional publishing via `published?`

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `publisher` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:publisher, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/publisher>.

