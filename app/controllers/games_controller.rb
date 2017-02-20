class GamesController < ApplicationController

  def index
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
  end

  def create
    p "#"*100
    p current_user
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


