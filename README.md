# pokedex

A Flutter-based app that displays pokemon data. The data gathered from web service is stored locally using Hive, ensuring calling data from network only once when the app is first opened. Using BLoC as State Management and architecture pattern.

This project was developed to meet the following requirements:

1. Users can view a list of Pokémon.
2. Users can press like and dislike buttons.
3. Pokémon liked by users will immediately go to the liked page.
4. Users can view their liked Pokémon.
5. Users can remove their liked Pokémon.
6. Users can search for Pokémon by name and type.
7. Pokémon liked through the detail page should immediately go to the favorite page.
8. Each like and unlike action will generate a notification that the Pokémon has been liked or disliked.

JSON Data from network source is parsed to be a PokemonResponse class, and then it is mapped to a PokemonModel class as a domain or entity not only to be stored in Hive, but also used across all widget. There is addition however to accomodate favorite/like feature which is a single boolean isFavorite. The separation between PokemonResponse as Data Transfer Object to a simpler PokemonModel is for separating concern of the code.

All the data is managed by a PokemonRepository class, the only layer that interact with network and local cache ensuring single source of truth across the app. It's then used by all Bloc class to get and manage the data, then the data is emitted to UI within state. cached_network_image is used specifically for displaying images from a remote source that is handled in CustomImage widget not only to enhance the app performance but also having a shimmering placeholder while the image is still loading.

For future improvement maybe I need to make the favorite pokemon data fetching more efficient by implementing a listener or make the repository stream the data because now it's still manually triggered everytime user like/dislike a pokemon. It's not really an issue as user won't notice a problem but if the data is synced with network source then it will be a problem (could also use some debounce so user can't spam it).
