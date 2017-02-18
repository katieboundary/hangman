require 'net/http'

class Game < ApplicationRecord
  def initialize
    uri = URI("http://linkedin-reach.hagbpyjegb.us-west-2.elasticbeanstalk.com/words")
    @word = Net::HTTP.get(uri).split("\n").sample
    @guessed_letters = []
    word_display
  end


  def word_display
    display_word = ""
    @word.each_char do |l|
      if @guessed_letters.include? l
        display_word << l
      else
        display_word << "-"
      end

    end

    return display_word
  end


end

