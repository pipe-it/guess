defmodule Guess.Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:name, :string)
    field(:email, :string)
    field(:gamecount, :integer)
    timestamps()
  end

  def changeset(%__module__{} = user, params) do
    user
    |> cast(params, [:name, :email, :gamecount])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
  end
end
