defmodule AbstractEmporium.Parser do
  def parse(path, contents) do
    [attrs, body] = :binary.split(contents, ["\n---\n"])
    |> IO.inspect(limit: :infinity, pretty: true, label: "")
    {Jason.decode!(attrs), body}
  end
end
