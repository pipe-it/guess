defmodule Guess.Repo.Migrations.CreateGameTable do
  use Ecto.Migration

  def change do
    create table(:games) do
      add(:user_id, references(:users), null: false)
      add(:rn, :integer)
      add(:trailcount, :integer)

      timestamps()
    end
  end
end
