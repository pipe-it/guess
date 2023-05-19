import Config
config :guess, ecto_repos: [Guess.Repo]

config :guess, Guess.Repo,
  database: "guess_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
