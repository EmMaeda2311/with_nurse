class Api::WordsController < ApplicationController
  def index
    @words = Word.offset(rand(Word.count)).limit(30).select(:name, :read, :spell)
    render json: @words
  end
end
