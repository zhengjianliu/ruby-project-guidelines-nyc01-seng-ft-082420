require 'pry'
require_relative 'user.rb'
require_relative 'event.rb'
require_relative 'appointment.rb'

def start
  puts "WELCOME!!!"
  prompt = TTY::Prompt.new
  input = prompt.select("Would you to login or sign up?", %w(Login Signup))

  if input == "Login"
    ## This is here after user login into their account!!
    current_user = User.login
    current_user.welcome
    current_user.create_event
    # Appointment.show_event(current_user)

  elsif input == "Signup"
    new_user = User.signup
    new_user.welcome

  end

end

 # binding.pry

start
