require 'method_longest'

class LongestController < ApplicationController

  def game
    grid
    @temps1 = Time.now
  end

  def score
    @answer = params[:answer]
    @grid = params[:grid].split("")
    @time = Time.now - params[:temps1].to_datetime
    results(@grid, @answer)
    session[:score] += @score
    session[:attempts] ? session[:attempts] += 1 : session[:attempts] = 1
    @average = session[:score] / session[:attempts]
  end
end
