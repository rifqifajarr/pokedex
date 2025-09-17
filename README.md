# pokedex

A Flutter-based app that displays pokemon data with an online/offline feature to stored data locally using SQLite. Using BLoC as State Management and architecture pattern. The flow of the data begin with JSON parsed object dan Enum mapped model for easier UI handling.

This project was developed to meet the following requirements:

1. Users can view a list of Pokémon.
2. Users can press like and dislike buttons.
3. Pokémon liked by users will immediately go to the liked page.
4. Users can view their liked Pokémon.
5. Users can remove their liked Pokémon.
6. Users can search for Pokémon by name and type.
7. Pokémon liked through the detail page should immediately go to the favorite page.
8. Each like and unlike action will generate a notification that the Pokémon has been liked or disliked.

Users can alreadly view a list of pokemon retrieved from remote source and the setup for SQLite database and BLoC for favorites are written, but haven't been integrated yet. Although the full feature set is not yet complete, the codebase already contains some of the necessary part. With more time, the next steps would be to fully implement the database storage and finish all the rest of the feature.
