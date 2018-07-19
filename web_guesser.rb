require 'sinatra'
require 'sinatra/reloader'

number = rand(101)
game_over = false
class Attempts
  @@remaining = 5
  def self.remaining
    @@remaining
  end

  def self.reset
    @@remaining = 5
  end

  def self.dec
    @@remaining -= 1
  end
end

def compare_guess(_guess, number)
  if _guess.to_s.empty? or !/\A\d+\z/.match(_guess)
    return "Guess a number between 0 and 100"
  end
  guess = _guess.to_i
  Attempts.dec
  if Attempts.remaining < 0
    return "You lost, lets start over"
  end
  if guess > number
    if guess > number + 5
      return "Way too high"
    else return "Too high"
    end
  elsif guess == number
    return "Correct, lets start over"
  elsif guess < number
    if guess < number - 5
      return "Way too low"
    else return "Too low"
    end
  end
end

def get_bg_color(msg)
  case msg
  when "Guess a number between 0 and 100" then color = "ffffff"
    when "Correct, lets start over" then color = "22ff22"
    when "Too low", "Too high" then color = "ff3333"
    when "Way too low", "Way too high" then color = "aa0000"
    when "You lost, lets start over" then color = "000000"
  end
  return color
end

get '/' do
  msg = compare_guess(params["guess"], number)
  if msg == "You lost, lets start over" or msg == "Correct, lets start over"
    number = rand(101)
    Attempts.reset
  end

  erb :index, :locals => {:msg => msg, :color => get_bg_color(msg), :att => Attempts.remaining}
end
