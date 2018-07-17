require 'sinatra'
require 'sinatra/reloader'

number = rand(101)

def compare_guess(_guess, number)
  if (_guess == "")
    msg = ""
    return msg
  end
  guess = _guess.to_i
  msg = ""
  if guess > number
    if guess > number + 5
      msg = "Way too high"
    else msg = "Too high"
    end
  elsif guess == number
    msg = "Correct"
  elsif guess < number
    if guess < number - 5
      msg = "Way too low"
    else msg = "Too low"
    end
  end
  return msg
end

get '/' do
  msg = compare_guess(params["guess"], number)
  erb :index, :locals => {:number => number, :msg => msg}
end
