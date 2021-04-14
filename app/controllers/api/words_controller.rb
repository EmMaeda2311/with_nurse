class Api::WordsController < ApplicationController
  def index
    @words = Word.order("rand()").limit(30).select(:name, :read, :spell)
    render json: @words
  end
end
