defmodule Publisher.Series do
  @moduledoc """
  A series is a collection of posts which belong together. For example posts about Nix may belong
  to a Nix series, or posts about backend development etc etc.

  The ultimate goal is to give series the ability to deploy html to various locations on my system so that
  they may belong to different output sites, but have their documentation live under the same input 
  journal directory. Doing this will allow me to easily link everything from my personal site outward, 
    as well as keep easy referencing for all writings no matter what repo's I have cloned
  """
  defstruct name: "",
    root: "",
    theme: "",
    posts: [],
    site: ""

  @typedoc """
  Describes a series of posts that thematically fit together

  Fields
  - Name: The name of the series
  - Root: The root directory of the series. e.g. /my-nix-writings
  - theme: The styling to be applied to the markup - this will be available later
  - posts: A list of articles to publish under this series
  - site: The site this series gets deployed to
  """
  @type t :: %__MODULE__{
    name: String.t(),
    root: String.t(),
    theme: String.t(), # change to enum later
    posts: [Publisher.Article.t()],
    site: String.t()
  }
  
end
