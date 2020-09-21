require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    charset = Array('A'..'Z')
    @letters = Array.new(10) { charset.sample }
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    @html_file = JSON.parse(open(url).read)
    if params['word']
      if @html_file['found'] == true
        @answer = "Congratulations! #{params[:word]} is a valid english word!"
        split_word = params[:word].upcase.split('')
        split_letters = params[:letters].split

        split_word.all? do |letter|
          split_letters.include?(letter)
        end
      else
        @answer = "Sorry! #{params[:word]} is not a valid english word."
      end
    end
  end
end
