require 'pry'
require_relative 'user.rb'
require_relative 'event.rb'
require_relative 'appointment.rb'

def start
  puts "WELCOME!!!"
  prompt = TTY::Prompt.new
  input = prompt.select("Would you to login or sign up?",
    %w(Login Signup Exit),symbols: { marker: "👉" })

  if input == "Login"
    ## This is here after user login into their account!!
    current_user = User.login
    User.loggedin(current_user)
    # binding.pry
  elsif input == "Signup"
    current_user = User.signup
    User.loggedin(current_user)
  else
    puts "Goodbye! 👋"
  end

end

start
# binding.pry
