# Live Football World Cup Scoreboard

## Purpose

This project is a simple Elixir library for managing a live scoreboard for World Cup football matches. It supports starting new games, updating scores, finishing games, and providing a summary of ongoing games ordered by their total score and start time.

## Assumptions

- The scoreboard is maintained in-memory using Elixir's Agent.
- Scores are updated with absolute values.
- The start time of each game is captured to order games with the same total score.
- The library does not include a graphical user interface or REST API. It is designed to be used as a backend library.
- It follows Test-Driven Development (TDD), clean code principles, and SOLID design principles in this implementation.

## Usage

### Installation

To use this library, you need to have Elixir installed on your machine. If you haven't installed Elixir yet, you can follow the instructions [here](https://elixir-lang.org/install.html).

### Running the Example

1. Save the code in a file named `scoreboard.exs`.
2. Open a terminal and navigate to the directory where the `scoreboard.exs` file is saved.
3. Run the file with the command: `iex -S mix`.

### Example Code

Below is an example usage of the library:

```elixir
# 1. Start the Scoreboard agent
Scoreboard.start_link([])

# 2. Start new games
Scoreboard.start_game("Mexico", "Canada")
Scoreboard.start_game("Spain", "Brazil")
Scoreboard.start_game("Germany", "France")
Scoreboard.start_game("Uruguay", "Italy")
Scoreboard.start_game("Argentina", "Australia")

# 3. Update scores
Scoreboard.update_score("Mexico", "Canada", 0, 5)
Scoreboard.update_score("Spain", "Brazil", 10, 2)
Scoreboard.update_score("Germany", "France", 2, 2)
Scoreboard.update_score("Uruguay", "Italy", 6, 6)
Scoreboard.update_score("Argentina", "Australia", 3, 1)

# 4. Get summary of ongoing games
IO.inspect(Scoreboard.summary())

# 5. Finish a game
Scoreboard.finish_game("Germany", "France")

# 6. Get updated summary
IO.inspect(Scoreboard.summary())
```

### Summary Example

Given the following sequence of operations:

1. Start games: Mexico vs Canada, Spain vs Brazil, Germany vs France, Uruguay vs Italy, Argentina vs Australia.
2. Update scores: Mexico 0 - Canada 5, Spain 10 - Brazil 2, Germany 2 - France 2, Uruguay 6 - Italy 6, Argentina 3 - Australia 1.

The summary should be:

```
[
  "Uruguay 6 - Italy 6",
  "Spain 10 - Brazil 2",
  "Mexico 0 - Canada 5",
  "Argentina 3 - Australia 1",
  "Germany 2 - France 2"
]
```

After finishing the game between Germany and France, the updated summary should be:

```
[
  "Uruguay 6 - Italy 6",
  "Spain 10 - Brazil 2",
  "Mexico 0 - Canada 5",
  "Argentina 3 - Australia 1"
]
```

## Testing

To run tests, execute the follwing command `mix tests`.

## Contributing

Contributions are welcome! Please fork this repository and submit a pull request for any improvements.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
