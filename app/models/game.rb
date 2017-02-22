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
    if /[A-z]/.match(letter)
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
    else
      return
    end
  end

  #calculates how many incorrect guesses the user has left.
  def guesses_left
    6 - wrong_guesses
  end

  #status check for if a user has won the game.
  def won?
    self.game_status == STATUS_WON
  end

  #status check for if the user has won the game.
  def lost?
    self.game_status == STATUS_LOST
  end

  #status check for if the user is currently playing a game(default).
  def playing?
    self.game_status == STATUS_PLAYING
  end

  #Shows only the wrong guesses.
  def display_incorrect_guesses
    (guesses.chars.to_a - word.chars.to_a).join(' ')
  end

  #Group won games by user and order them in descending order. Only include the top ten.
  #Counts the number of wins for those top ten players.
  def self.leaderboard
    where(:game_status => STATUS_WON).group(:user).order("COUNT(1) DESC").limit(10).count
  end

  #Used for AJAX calls while playing the game.
  def to_json
    {
      :guesses_left => guesses_left,
      :word_display => word_display,
      :display_incorrect_guesses => display_incorrect_guesses,
      :won => won?,
      :lost => lost?,
      :playing => playing?
    }
  end
end
