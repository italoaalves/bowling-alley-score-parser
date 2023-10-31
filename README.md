# Bowling Alley Score Calculator

A multiplayer bowling game with plug and play input

### Initial setup
```bash
bundle
```

## How to run
```bash
./bin/bowling -f example.txt
```
or, you can run rspec and see the tests results
```bash
rspec
```

### Project structure
When designing this solution I had in mind all best practices and software development principles. I tried to be as clean as possible using well known design patterns and respecting OOP SOLID design.

The core of this project is the `BowlingGame` class. It manages the players and game input which is also tied to the players. The game input is coded as a strategy, so it’s open to inject any sort implementation of a `GameInputParser` like an implementation to read from `stdin`, consume an API, or USB serial protocol.

The player class manages the state of the game for them, it keeps all throws as a linked list of frames and also keeps the logic to generate its score.

Inside the player we have many `Frames` with the respective throw data like the number of pins down and a symbol to help outputting it later. The frames have all the logic involved in calculating the bonuses from spares and strikes and we can easily do so because of the linked structure.

As the last frame in bowling has a different state and behavior, I opted out to use a factory to build them inside the user based on the frames count. Extracting that responsibility from the `Player` makes it possible to effortlessly add new types of frames if needed in the future without having to worry with the `Player` class.

The application runs on a `optparse` skeleton to give a great user experience in the CLI. Adding other input options in the future would be an easy job.

I also created a helper to output the game score table on the stdout.

All domain objects are self validated, raising custom exceptions that are treated and presented in a helping manner.
