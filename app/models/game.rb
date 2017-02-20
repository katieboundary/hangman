require 'net/http'

class Game < ApplicationRecord
  belongs_to :user

  STATUS_PLAYING = 1
  STATUS_WON = 2
  STATUS_LOST = 3


  #display the new word with underscores for each letter. Replace underscores with correct guesses.
  def word_display
    display_word = ""
    word.each_char do |l|
      if guesses.include? l
        display_word << l
      else
        display_word << "-"
      end
    end
    return display_word
  end


  def guess(letter)
    if guesses.include?(letter)
      return
    else
      self.guesses << letter
    end

    if !word.include?(letter)
      self.wrong_guesses += 1
      if self.wrong_guesses == 6
        self.game_status = STATUS_LOST
      end
    end
    self.save!
  end

  def guesses_left
    6 - wrong_guesses
  end

#make method to downcase
#make method to only display incorrected guesses
#method to restart game
#partialize form to enter letters, and button to start new game.


end

