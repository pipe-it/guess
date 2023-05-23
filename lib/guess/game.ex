defmodule Guess.Game do
  alias Guess.UserDetails, as: UD
  alias Guess.Schemas.User
  alias Guess.Repo
  alias Guess.Schemas.Game

  def start_game do
    IO.puts("***Welcome to the Guessing game***")
    IO.puts("----------------------------------")

    IO.puts("""
    You have to guess a number between 1 and 100
    and i will tell you if it is smaller or bigger
    than the correct number untill your guess
    matchs with the number:
    """)

    play? =
      IO.gets("Do you want to play a guessing game? enter y/n and press enter ") |> String.trim()

    if play? == "y" do
      name = UD.get_name()
      email = UD.get_email()

      user = %{name: name, email: email}
      changeset = User.changeset(%User{}, user)

      case Repo.insert(changeset) do
        {:ok, user} ->
          play(user)

        {:error, error} ->
          IO.inspect(error)
          IO.puts("user not found, Unable to start game")
      end
    else
      IO.puts("Bye Bye .. never meet again ")
    end
  end

  def play(user) do
    {index, rn} = Guess.check_number()

    gamer = %{
      name: user.name,
      email: user.email,
      index: index,
      guss_num: rn
    }

    print_result(gamer)
    game = %{rn: rn, trailcount: index, user_id: user.id}
    gamechangeset = Game.changeset(%Game{}, game)

    if gamechangeset.valid? do
      Repo.insert(gamechangeset)
      playagain? = IO.gets("Do you want to play again? press y/n") |> String.trim()

      if playagain? == "y" do
        play(user)
      else
        IO.puts("Bye Bye .. never meet again ")
      end
    else
      IO.puts("Unable to record game")
    end
  end

  def print_result(gamer) do
    output = """
    *********************************
              Guess Game
    *********************************
    Name : #{gamer.name}
    Email: #{gamer.email}
    ---------------------------------

    ------------------------------------------------------------------
    |                                                                |
    |You took #{gamer.index} trails to guess #{gamer.guss_num} number|
    |                                                                |
    ------------------------------------------------------------------


    Finito..
    """

    IO.puts(output)
  end
end
