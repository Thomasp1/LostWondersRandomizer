# LostWondersRandomizer
Randomizer for the fan expansion of 7 Wonders: [Lost Wonders](https://boardgamegeek.com/boardgameexpansion/134849/lost-wonders-fan-expansion-7-wonders). Using SwiftUI and Combine.
This app will help you create a game that will be compatible with Wonders that copy other Wonders' abilities, such as Manneken Pis, as described in the Lost Wonders rule book:
```
Game Balance
Certain combinations of Wonders can create an unbalanced game if the following suggestions are not taken into consideration. When determining Wonder boards for each player, it is recommended that you follow these suggestions to ensure a fun and balanced game for all players.
Generic Considerations
Avoid playing with 3 or more Wonders that possess the same starting resource.
Do not play with 3 or more Wonders that have powers based on the same color cards.
Example: A game with Rhodes, Capua, Helvetia, and Sparta may result in 4 players competing to collect red cards.
Manneken Pis [A] Considerations
Lost Wonders was not designed for use with the original Manneken Pis (use your own discretion with the reprint). There are numerous considerations to follow if you do decide to include Manneken Pis in your games. Manneken Pis side A allows a player to copy the effects of Wonders in neighboring cities. If playing with Manneken Pis, ensure that it does not have the following Wonders as neighbors. Do not play with these Wonders
to the left or right: Atlantis [B], Brigadoon, Chichén Itzá, Citadels, DoppelWönder, Tártaros [B], Temporal Paradox, Uruk to the left: Dominion [B], Venezia [B]
to the right: Antiócheia [B], Helvetia, Petra
Other Wonder Considerations
Due to the new abilities present on many Wonders, the event that you run out of necessary game components has become possible. Please be aware of and consider the following when determining which Wonders you will use:
Atlantis [B] allows the player to draw unused Guild cards. Play with at least 1 official 7 Wonders expansion in order to have enough unused Guild cards remaining for the player to draw, otherwise only play Atlantis [B] with 5 or less players.
Beiping [B] allows the player to purchase Victory tokens. Remove the leader ALEXANDER from the game if playing with Leaders. The number of Victory tokens is intended to be a limiter on this Wonder. Do not allow the player to trade Victory tokens with the bank, e.g. do not trade 3 1-point tokens for a 3-point token. Brigadoon may not be used in the team play variant, or if playing with less than 4 players.
DoppelWönder is designed specifically for use only when playing with the team play variant.
El Dorado [B] can grant coins to all players. The number of available coins is not meant to be a limiter on this Wonder. You may need to provide a substitute for coins in the event that the supply of coins is depleted.
Helvetia [B] should not be used with the team play variant.
Ithákê may only be played with the unofficial 7 Wonders: Myths expansion.
Nomádes should not be used if playing with Manneken Pis or Venezia [B], or if playing with less than 4 players.
Rapa Nui is designed for use only when playing with the team play variant.
Venezia [B] should not have the following neighbors: Citadels, Chichén Itzá [B], DoppelWönder, Manneken Pis, Temporal Paradox, Tártaros [B]
Persepolis [B] allows the player to draw unused City cards. Only play Persepolis [B] with 7 or less players in order to have enough unused City cards remaining for the player to draw.
```
Obviously, this is a lot to remember for starting the game, so this app does the math for you.
currently, this app is "side-agnostic", so you can choose which side of a Wonder to play after being chosen.

## What's done:
* adding Wonders from different expansions
* generating list of Wonders compatible with Wonder-copying Wonders
* filtering Wonders based on teamplay, expansions, player count, and starting resources
* filtering based on card color "theme"
* special feature for Temporal Paradox :)

## TODO:
* remake UI with table cells


