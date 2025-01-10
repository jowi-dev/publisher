defmodule AbstractEmporium.Article do
  @enforce_keys [:id, :author, :title, :body ]
  defstruct [:id, :author, :title, :body ]

  @author "Joe Wiliams"

  def build(filename, attrs, body) do
    file = Path.basename(filename)
    [file, ""] = String.split(file, ".md")
    struct!(__MODULE__, [id: file, author: @author, body: body] ++ Map.to_list(attrs))
    |> IO.inspect(limit: :infinity, pretty: true, label: "")
  end
end
