require 'sinatra'
require 'sinatra/reloader'

secret_number = rand(101)

get '/' do
  "The secret number is #{secret_number}."
end
