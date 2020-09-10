require 'pry'
require_relative 'user.rb'
require_relative 'event.rb'
require_relative 'appointment.rb'

def start
  Catpix::print_image "lib/app/imgs/hdr.jpg",
  :limit_x => 1.0,
  :limit_y => 0,
  :center_x => true,
  :center_y => true,
  :bg => "white",
  :bg_fill => false,
  :resolution => "high"   
  prompt = TTY::Prompt.new
  input = prompt.select("Would you to login or sign up?",
    %w(Login Signup Exit),symbols: { marker: "👉" })

  if input == "Login"
    ## This is here after user login into their account!!
    current_user = User.login
    # system `say "loading #{current_user.name}'s account.'"`   ## uncomment this line will play welcome user.
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
#binding.pry
