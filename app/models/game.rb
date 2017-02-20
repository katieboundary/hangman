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
        display_word << " _ "
      end
    end
    return display_word
  end

  #takes in user guess, downcases the letter, adds letter to guesses string, increase wrong_guesses if incorrect.
  def guess(letter)
    letter = letter.downcase
    if guesses.include?(letter)
      return
    else
      self.guesses << letter

    end

    if word.include?(letter)
      if !word_display.include?("_") && wrong_guesses < 6
        self.game_status = STATUS_WON
      end
    else
      self.wrong_guesses += 1
      if self.wrong_guesses >= 6
        self.game_status = STATUS_LOST
      end
    end
    self.save!
  end

  def guesses_left
    6 - wrong_guesses
  end

  def won?
    self.game_status == STATUS_WON
  end

  def lost?
    self.game_status == STATUS_LOST
  end

  def playing?
    self.game_status == STATUS_PLAYING
  end



  # def display_incorrect_guesses
  # end

#default cursor position
#method to only allow one letter entered at a time.
#make method to only accept a-z characters --then display message.
#make method to only display incorrected guesses
#method to restart game
#partialize form to enter letters, and button to start new game.


end

