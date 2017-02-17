require 'net/http'

class Game < ApplicationRecord
  def word
    uri = URI("http://linkedin-reach.hagbpyjegb.us-west-2.elasticbeanstalk.com/words")
    Net::HTTP.get(uri).split("\n").sample
  end
end
