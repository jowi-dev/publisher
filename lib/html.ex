defmodule AbstractEmporium.Html do
  def convert(extname, body, _attrs, opts) when extname in [".md", ".markdown"] do
    IO.inspect(body, limit: :infinity, pretty: true, label: "")
    highlighters = Keyword.get(opts, :highlighters, [])
    body |> NimblePublisher.highlight(highlighters)
  end
end
