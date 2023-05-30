defmodule Guess.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:name, :string)
      add(:email, :string)
      add(:gamecount, :integer)

      timestamps()
    end
  end
end
