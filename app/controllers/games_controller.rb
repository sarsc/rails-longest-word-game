require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
    @letters.shuffle!
  end

  def score
    @words = params[:type_word].split('')
    @letter = params[:letters].split(' ')
    valid_word(params[:type_word])
  end

  def english_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    english_word = JSON.parse(open(url).read)
    english_word["found"]
  end

  def valid_word(word)
    if @words.all? { |letter| @words.count(letter) <= @letter.count(letter) }
      @response = ""
      if english_word(word) == true
        @response = "Congratulation!#{word} is correct"
      else
        @response = "Oh no!#{word} is not an english word"
      end
    else
      @response = "Sorry this word can't be build out of letters choice"
    end
  end
end
# link_to "Play again", new_path
