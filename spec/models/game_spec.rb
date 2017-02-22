require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) { Game.new(word: "fish", guesses: "", game_status: 1, wrong_guesses: 0, user: user) }
  let(:user) {User.new(name: "Bob", email: "bob@bob.com", password_digest: "puppies")}


  describe "#word_display" do
    context "when a new word is chosen for a game" do
      it "displays each letter of the word as an underscore" do
        expect(game.word_display).to eq " _  _  _  _ "
      end
    end

    context "when a user guesses a correct letter" do
      it "removes the underscore and displays the correct letter in that location" do
        game.guesses = "f"
        expect(game.word_display).to eq "f _  _  _ "
      end
    end
  end

  describe "#guess" do
    context "when a user guesses a correct letter" do
      it "adds the correct letter into the guesses string" do
        expect { game.guess("f") }.to change { game.guesses }.from("").to("f")
      end

      it 'downcases capital letters and adds it into the guesses string ' do
        expect { game.guess("F") }.to change { game.guesses }.from("").to("f")
      end

      it 'only adds a correct letter once' do
        game.guess("f")
        expect { game.guess("f") }.not_to change { game.guesses }
      end
    end

    context "when a user has correctly guessed the word" do
      it "sets the game status to won" do
        game.guesses = "fis"
        expect { game.guess("h") }.to change { game.game_status }.from(Game::STATUS_PLAYING).to(Game::STATUS_WON)
      end
    end

    context "when a user has guessed an incorrect letter" do
      it "increases wrong guesses by one" do
        expect { game.guess("x") }.to change { game.wrong_guesses }.from(0).to(1)
      end

      it "adds the incorrect letter to the guesses string" do
        expect { game.guess("x") }.to change { game.guesses }.from("").to("x")
      end

      it "changes the game_status from playing to lost after 6 incorrect guesses" do
        game.wrong_guesses = 5
        expect { game.guess("z") }.to change { game.game_status }.from(Game::STATUS_PLAYING).to(Game::STATUS_LOST)
      end
    end
  end

  describe "#guesses_left" do
    context "when a user makes an incorrect guess" do
      it "reduces how many guesses they have left by one" do
        expect { game.guess("z") }.to change { game.guesses_left }.from(6).to(5)
      end
    end
  end
end
