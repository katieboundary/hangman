# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [User.create(name: "Larry", email: "larry@larry.com", password_digest: "dogs"),
User.create(name: "Will", email: "will@will.com", password_digest: "dogs"),
User.create(name: "Jose", email: "jose@jose.com", password_digest: "dogs"),
User.create(name: "Nirav", email: "nirav@nirav.com", password_digest: "dogs"),
User.create(name: "April", email: "april@april.com", password_digest: "dogs"),
User.create(name: "Len", email: "larry@larry.com", password_digest: "dogs"),
User.create(name: "Shoham", email: "shoham@shoham.com", password_digest: "dogs"),
User.create(name: "Gilles", email: "gilles@gilles.com", password_digest: "dogs"),
User.create(name: "James", email: "james@james.com", password_digest: "dogs"),
User.create(name: "Ann", email: "ann@ann.com", password_digest: "dogs")]

users.each do |user|
  Random.rand(12).times do
    Game.create(word: "pugs", guesses: "pugs", game_status: Game::STATUS_WON, user: user)
  end
end
