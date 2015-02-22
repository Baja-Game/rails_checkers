== API USAGE

url: https://baja-checkers.herokuapp.com

# Create User

### /users POST

* user: {username: username, email: email, password: password}
```
{
    "user": {
        "email": "test1@nowhere.com",
        "username": "test1",
        "wins": 0,
        "losses": 0,
        "forfeits": 0,
        "draws": 0,
        "experience": 0
    },
    "auth_token": "FtH4ENxd9-H_TuNo89YP"
}
```

# Edit User

### /users PUT

* user: {username: username, email: email, password: password}
```
{
    "user": {
        "email": "updated@email.com",
        "username": "new-username",
        "wins": 0,
        "losses": 0,
        "forfeits": 0,
        "draws": 0,
        "experience": 0
    },
    "auth_token": "FtH4ENxd9-H_TuNo89YP"
}
```

# Sign In User

### /users/sign_in POST

* user: {email: email, password: password}
```
{
    "user": {
        "email": "test1@nowhere.com",
        "username": "test1",
        "wins": 0,
        "losses": 0,
        "forfeits": 0,
        "draws": 0,
        "experience": 0
    },
    "auth_token": "FtH4ENxd9-H_TuNo89YP"
}
```

# User Profile

### /users/:id GET

```
{
    "email": "elsewhere@nowhere.com",
    "username": "mercer",
    "wins": 0,
    "losses": 0,
    "forfeits": 0,
    "draws": 0,
    "experience": 0
}
```

# Show Game

### /games/"id" GET

* auth_token: authentication_token
```
{
    "game": {
        "id": 21,
        "board": [
            [
                0,
                1,
                0,
                1,
                0,
                1,
                0,
                1
            ],
            [
                1,
                0,
                1,
                0,
                1,
                0,
                1,
                0
            ],
            [
                0,
                1,
                0,
                0,
                0,
                1,
                0,
                1
            ],
            [
                0,
                0,
                0,
                0,
                2,
                0,
                0,
                0
            ],
            [
                0,
                2,
                0,
                0,
                0,
                0,
                0,
                0
            ],
            [
                0,
                0,
                0,
                0,
                2,
                0,
                2,
                0
            ],
            [
                0,
                2,
                0,
                2,
                0,
                2,
                0,
                2
            ],
            [
                2,
                0,
                2,
                0,
                2,
                0,
                2,
                0
            ]
        ],
        "turn_counter": 5,
        "updated_at": "2015-02-21T21:28:21.541Z",
        "finished": null,
        "log": [
            [
                [
                    3,
                    4
                ]
            ],
            [
                [
                    4,
                    1
                ]
            ],
            [
                [
                    4,
                    3
                ]
            ],
            [
                [
                    3,
                    4
                ]
            ]
        ]
    },
    "player1": {
        "id": 1,
        "username": "alex"
    },
    "player2": {
        "id": 2,
        "username": "andy"
    }
}
```

# List Games

### /games GET

* auth_token: authentication_token
* returns: same as show games above, but lots!

# Join Game
Finds an empty game and has the player join it as player2. If there is no empty game, starts a new game with player as player1.

### /games PUT

* auth_token: authentication_token, jumps: false (optional, defaults to true)
* returns: same as show games

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