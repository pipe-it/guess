defmodule Guess.Repo.Migrations.CreateUpdateUserid do
  use Ecto.Migration

  def change do
    alter table(:games) do
      execute("alter table games drop constraint games_user_id_fkey")

      modify(:user_id, references(:users, on_delete: :delete_all),
        from: references(:users, on_delete: :nothing)
      )
    end
  end
end
