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
    prompt = TTY::Prompt.new
    choice = ["View & edit Appointment", "Create Appointment"]
    input = prompt.select(current_user.welcome, choice)
    if input == "View & edit Appointment"
      current_user.display_all_appointments
    elsif input ==  "Create Appointment"
      current_user.create_event
    end
    # binding.pry
  elsif input == "Signup"
    new_user = User.signup
    new_user.welcome


  end

end



start
