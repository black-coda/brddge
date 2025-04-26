/// Enum representing various interests with their names and icons.
enum Interest {
  /// Business interest with icon 💼.
  business('Business', '💼'),

  /// Science & Tech interest with icon 🔬.
  scienceTech('Science & Tech', '🔬'),

  /// Music interest with icon 🎵.
  music('Music', '🎵'),

  /// Film & Media interest with icon 🎬.
  filmMedia('Film & Media', '🎬'),

  /// Arts interest with icon 🎨.
  arts('Arts', '🎨'),

  /// Health interest with icon 🩺.
  health('Health', '🩺'),

  /// Travel & Outdoor interest with icon 🏕️.
  travelOutdoor('Travel & Outdoor', '🏕️'),

  /// Sports & Fitness interest with icon 🏀.
  sportsFitness('Sports & Fitness', '🏀'),

  /// Fashion interest with icon 🛍️.
  fashion('Fashion', '🛍️'),

  /// Food & Drink interest with icon 🍔.
  foodDrink('Food & Drink', '🍔'),

  /// Charities & Causes interest with icon 🎗️.
  charitiesCauses('Charities & Causes', '🎗️'),

  /// Government interest with icon 🏛️.
  government('Government', '🏛️'),

  /// Community interest with icon 🏘️.
  community('Community', '🏘️'),

  /// Spirituality interest with icon 🙏.
  spirituality('Spirituality', '🙏'),

  /// Family & Education interest with icon 👨‍👩‍👧‍👦.
  familyEducation('Family & Education', '👨‍👩‍👧‍👦'),

  /// Seasonal interest with icon 🎄.
  seasonal('Seasonal', '🎄'),

  /// Home & Lifestyle interest with icon 🏡.
  homeLifestyle('Home & Lifestyle', '🏡'),

  /// Auto, Boat & Air interest with icon 🚗.
  autoBoatAir('Auto, Boat & Air', '🚗'),

  /// School Activity interest with icon 🏫.
  schoolActivity('School Activity', '🏫');

  /// Constructor for the [Interest] enum.
  const Interest(this.name, this.icon);

  /// The name of the interest.
  final String name;

  /// The icon representing the interest.
  final String icon;
}
