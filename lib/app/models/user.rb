class User < ActiveRecord::Base
  has_many :appointments
  has_many :events, through: :appointments

  def self.login
    prompt = TTY::Prompt.new
    puts "Please enter your username and password"
    user_name = prompt.ask("Username: ")
    user_password =  prompt.mask("Password: ")
    current_user = User.find_by(name: user_name, password: user_password)

     if current_user
       current_user
     else
       puts "\n------------------------------------------"
       puts "\nPlease check your password and username!\n\n"
       User.login
     end
  end

  def self.signup
    prompt = TTY::Prompt.new
    new_user_name = prompt.ask("Please input your name: ")
    new_user_phone = prompt.ask("Please input your phone number: ")

    if User.find_by(name:new_user_name, phone: new_user_phone)
      puts "\n------------------------------------------"
      puts "\nYour name and phone number is already registered in the system\nPlease login: "
      User.login
    else
      new_user_age = prompt.ask("Please input your age: ")
      new_user_occupation = prompt.ask("Please input your occupation: ")
      new_user_password = prompt.mask("Please input your password: ")
      User.create(name: new_user_name, age: new_user_age,
        phone: new_user_phone, occupation: new_user_occupation, password: new_user_password)
      User.login
      # binding.pry
    end
  end

  def welcome
    puts "Hey #{self.name}! Welcome to the BOOKING SYSTEM!!"
  end

  # binding.pry

end


# User.find_or_create_by(name: new_user_name, age: new_user_age,
#   phone: new_user_phone, occupation: new_user_occupation, password: new_user_password)
# User.login
