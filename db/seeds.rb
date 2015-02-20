# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.delete_all
Game.delete_all

alex = User.create(username: 'alex', password: 'password', email: "alex@alex.com",
				   wins: 50, losses: 50, forfeits: 0, draws: 10)
andy = User.create(username: 'andy', password: 'password', email: "andy@andy.com",
				   wins: 50, losses: 50, forfeits: 0, draws: 10)
jim = User.create(username: 'jim', password: 'password', email: "jim@jim.com",
				   wins: 50, losses: 50, forfeits: 0, draws: 10)
jane = User.create(username: 'jane', password: 'password', email: "jane@jane.com",
				   wins: 50, losses: 50, forfeits: 0, draws: 10)
tom = User.create(username: 'tom', password: 'password', email: "tom@tom.com",
			       wins: 50, losses: 50, forfeits: 0, draws: 10)
tim = User.create(username: 'tim', password: 'password', email: "tim@tim.com",
			       wins: 50, losses: 50, forfeits: 0, draws: 10)
mary = User.create(username: 'mary', password: 'password', email: "mary@mary.com",
			       wins: 50, losses: 50, forfeits: 0, draws: 10)
max = User.create(username: 'max', password: 'password', email: "max@max.com",
		           wins: 50, losses: 50, forfeits: 0, draws: 10)

g = 1
10.times do |g|
  Game.create(id: g+1)
end

game1 = Game.find(1)
game2 = Game.find(2)
game3 = Game.find(3)
game4 = Game.find(4)
game5 = Game.find(5)
game6 = Game.find(6)
game7 = Game.find(7)
game8 = Game.find(8)
game9 = Game.find(9)
game10 = Game.find(10)

game1.users << [alex, andy]
game2.users << [jim, jane]
game2.users << [tom, tim]
game3.users << [mary, max]
game4.users << [mary]
game5.users << [mary]
game6.users << [mary]
game7.users << [jane]
game8.users << [jane]
game9.users << [tim]