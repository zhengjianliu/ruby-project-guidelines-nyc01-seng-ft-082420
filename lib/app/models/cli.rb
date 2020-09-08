require 'pry'
require_relative 'user.rb'

def run
  puts "WELCOME!!!"
  puts "Would you to login or sign up?"
  prompt = TTY::Prompt.new
  input = prompt.select("Would you to login or sign up?", %w(Login Signup))
  if input == "Login"
    ## This is here after user login into their account!!
    puts "Login!!!"
    ## This is here after user wanna to signup!!
  elsif input == "Signup"
    # t.string :name
    # t.integer :phone
    # t.integer :age
    # t.string :occupation
    User.signup

  end

end

# run
