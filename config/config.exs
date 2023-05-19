import Config

config :guess, Guess.Repo,
  database: "guess_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
