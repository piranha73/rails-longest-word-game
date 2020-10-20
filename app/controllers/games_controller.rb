require "open-uri"

class GamesController < ApplicationController
  VOWELS = %w(A E I U Y)
  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { ([*'A'..'Z'] - VOWELS).sample }
  end

  def score
  @letters = params[:letters].split
  @word = params[:word || ""].upcase
  @included = included?(@word, @letters)
  @english_word = english_word?(word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
