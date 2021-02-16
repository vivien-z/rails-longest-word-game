require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def display
  end

  def score
    @letters = params[:letters].split
    @guess = (params[:guess] || '').upcase
    @include = include?(@guess, @letters)
    @english_word = english_word?(@guess)
  end

  private

  def include?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    json = JSON.parse(open(url).read)
    json['found']
  end
end
