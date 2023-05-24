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

  @spec user_gamecount(any) :: any
  def user_gamecount(id) do
    query =
      from(g in "games",
        where: g.user_id == ^id,
        select: %{gamecount: count(g.id)}
      )

    Repo.all(query)
  end

  # DELETE FROM users WHERE id = 1;

  def delete_user(record) do
    Repo.delete(record)
  end

  # DELETE FROM users WHERE category = 'id' RETURNING *;

  def delete_table(table) do
    records = Repo.all(table)

    Enum.each(records, &delete_user/1)
  end

  # def get_useremail(email) do
  #   query =
  #     from(u in "users",
  #       where: u.user_email == ^email
  #     )

  #   Repo.all(query)
  # end
end
