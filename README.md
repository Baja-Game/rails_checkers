== API USAGE

url: https://baja-checkers.herokuapp.com

# Create User

### /users POST

* user: {username: username, email: email, password: password}
* returns: user: {email, username, authentication_token}

# Login User

### /users/sign_in POST

* user: {email: email, password: password}
* returns: user: {email, username, authentication_token}

# Show Game

### /games/"id" GET

* auth_token: authentication_token
* returns: game: {board, turn_counter}, player1: username, player2: username

# List Games

### /games GET

* auth_token: authentication_token
* returns: All games authenticated player is in
* game: {board, turn_counter, finished}, player1: username, player2: username

# Join Game
Finds an empty game and has the player join it as player2. If there is no empty game, starts a new game with player as player1.

### /games PUT

* auth_token: authentication_token
* returns: game: {board, turn_counter}, player1: username, player2: username

# Make Move

### /games/:id PUT

* auth_token: authentication_token
* returns: Partially functional. Returns whether piece is valid or not.

# TODO

## Easy Mode

  * User Registration
  * Users have games
  * Basic Checkers Logic
  * Users get points (winning, losing, forefeit)
  * Leaderboard
  * Server handles moves
  * Match Making (open/new games)
  * Choose Color of Pieces
  * Basic Movement (jumpy)
  
## Hard Mode 

  * Experience & Leveling
  * Tiered Leaderboard
  * Match Making (based on level)
  * Support Kinging
  * Add Images (Gifs) to Pieces
  * Advanced Movement (animation)

## Nightmare Mode 

  * Computer moves for you after an amount of time (set during game creation)
  * Super Advanced Movement (Canvas/SVG) - Think SUPER Cheesy!
  * Bigger Board
  * Once all pieces are "kinged" - Wolfenstein 3D will start running 
  * AI - Play against the computer