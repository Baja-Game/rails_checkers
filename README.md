== API USAGE

url: https://baja-checkers.herokuapp.com

* Create User

/users POST
user: {username: username, email: email, password: password}

returns: user: {email, username, authentication_token}

* Login User

/users/log_in POST
user: {email: email, password: password}
returns: user: {email, username, authentication_token}

* Show Game

/games/"id"
auth_token: authentication_tokn
returns: game.board