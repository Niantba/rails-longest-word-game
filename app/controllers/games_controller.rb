require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    range = ('A'..'Z').to_a
    @letters = []
    10.times do
      @letters << range[rand(0..25)]
    end
  end

  def check_letters
  end

  def score
    word = params[:word].upcase
    include = word.split('').all? do |letter|
      params[:letters].split.include?(letter)
    end

    @result = if include
                url = "https://wagon-dictionary.herokuapp.com/#{word}"
                user_serialized = URI.open(url).read
                @user = JSON.parse(user_serialized)
                if @user[:found]
                  "Sorry but #{word} is not valid"
                else
                  "Congratulations! #{word} is valid"
                end
              else
                "Sorry but #{word} can't be built out of #{params[:letters]}"
              end
  end

end
