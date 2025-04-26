/// Enum representing various hobbies with their names and emojis.
enum Hobby {
  /// Photography hobby with emoji 📸.
  photography('Photography', '📸'),

  /// Cooking hobby with emoji 🍳.
  cooking('Cooking', '🍳'),

  /// Hiking hobby with emoji 🥾.
  hiking('Hiking', '🥾'),

  /// Painting hobby with emoji 🎨.
  painting('Painting', '🎨'),

  /// Yoga hobby with emoji 🧘‍♂️.
  yoga('Yoga', '🧘‍♂️'),

  /// Gaming hobby with emoji 🎮.
  gaming('Gaming', '🎮'),

  /// Gardening hobby with emoji 🌻.
  gardening('Gardening', '🌻'),

  /// Writing hobby with emoji ✍️.
  writing('Writing', '✍️'),

  /// Playing musical instruments hobby with emoji 🎼.
  playMusicalInstrument('Play Musical Instrument', '🎼'),

  /// Knitting hobby with emoji 🧶.
  knitting('Knitting', '🧶'),

  /// Traveling hobby with emoji ⛵.
  traveling('Traveling', '⛵'),

  /// Fitness hobby with emoji 🏋️‍♂️.
  fitness('Fitness', '🏋️‍♂️'),

  /// Reading hobby with emoji 📚.
  reading('Reading', '📚'),

  /// Crafting hobby with emoji 🛠️.
  crafting('Crafting', '🛠️'),

  /// Medication-related hobby with emoji 💊.
  medication('Medication', '💊'),

  /// Dancing hobby with emoji 💃.
  dancing('Dancing', '💃'),

  /// Woodworking hobby with emoji 🪵.
  woodworking('Woodworking', '🪵'),

  /// Video making hobby with emoji 📹.
  videoMaking('Video Making', '📹'),

  /// Playing board games hobby with emoji 🎲.
  boardGames('Board Games', '🎲'),

  /// Freerunning hobby with emoji 🏃‍♂️.
  freerunning('Freerunning', '🏃‍♂️');

  /// Constructor for the [Hobby] enum.
  const Hobby(
    this.name,
    this.emoji,
  );

  /// The name of the hobby.
  final String name;

  /// The emoji representing the hobby.
  final String emoji;
}

/// Enum representing various hobbies with their names and emojis.
