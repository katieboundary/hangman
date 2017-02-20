class GamesController < ApplicationController

  def index
    @users = User.all
    @leaderboard = Game.leaderboard
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
  end

  def create
    if current_user.nil?
      redirect_to '/signup'
    end
    uri = URI("http://linkedin-reach.hagbpyjegb.us-west-2.elasticbeanstalk.com/words")
    @game = Game.new do |g|
      g.word = Net::HTTP.get(uri).split("\n").sample
      g.user = current_user
    end
    @game.save!
    redirect_to @game
  end

  def update
    letter = params[:guess]
    @game = Game.find(params[:id])
    @game.guess(letter)
    redirect_to @game
  end

end


