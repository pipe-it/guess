defmodule Guess.Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Guess.Repo

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

  def get_user(id) do
    Repo.get(Guess.Schemas.User, id)
  end

  def get_user() do
    Repo.all(Guess.Schemas.User)
  end

  def user_gamecount(id) do
    query =
      from(g in "games",
        where: g.user_id == ^id,
        select: %{gamecount: count(g.id)}
      )

    Repo.all(query)
  end

  # def get_useremail(email) do
  #   query =
  #     from(u in "users",
  #       where: u.user_email == ^email
  #     )

  #   Repo.all(query)
  # end
end
