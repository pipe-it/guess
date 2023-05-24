defmodule Guess.Schemas.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias Guess.Schemas.User

  schema "games" do
    field(:rn, :integer)
    field(:trailcount, :integer)
    belongs_to(:user, User)
    timestamps()
  end

  def changeset(%__module__{} = game, params) do
    game
    |> cast(params, [:user_id, :rn, :trailcount])
    |> validate_required([:rn, :trailcount])

    # |> foreign_key_constraint(:user_id)
  end

  def list_games do
    Guess.Repo.all(Guess.Schemas.Game)
  end
end
