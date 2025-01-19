defmodule Publisher.Article do
  @moduledoc """
  Article is the data model to describe a publishable body of text.

  It contains author, title, body, description and ID. 
  Author may either be set from the map at the top of the markdown document, or it will fallback to 
  the default author set in the config, or to DEFAULT_AUTHOR as an environment variable
  """
  @enforce_keys [:id, :author, :title, :body ]
  defstruct [:id, :author, :title, :body, :description ]

  @type t :: %__MODULE__{
    id: String.t(),
    author: String.t(),
    title: String.t(),
    body: String.t()
  }

  def build(filename, attrs, body) do
    file = Path.basename(filename)
    [file, ""] = String.split(file, ".md")
    struct!(__MODULE__, [id: file, body: body, author: author(attrs)] ++ Map.to_list(attrs))
  end

  defp author(attrs) do
    Map.get(attrs, :author) || Application.get_env(Publisher, :default_author) || System.get_env("DEFAULT_AUTHOR")
  end
end
