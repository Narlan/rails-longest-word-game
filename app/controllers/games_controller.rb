require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    @letters_list = letters.sample(10)
  end

  def score
    def in_the_grid?(attempt, grid)
      letters = attempt.split('')
      letters.each do |letter|
        if grid.include? letter
          grid.delete_at(grid.index(letter))
        else
          return false
        end
      end
      return true
    end

    @word = params[:word].upcase
    @letters = params[:letters_list].split('')
    @score = @word.length

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    @answer = open(url).read
    @valid = JSON.parse(@answer)["found"]
    @in_the_grid = in_the_grid?(@word, @letters)
  end
end
