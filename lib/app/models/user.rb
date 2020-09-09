require_relative 'event.rb'
class User < ActiveRecord::Base
  has_many :appointments
  has_many :events, through: :appointments

  def self.login
    prompt = TTY::Prompt.new
    puts "Please enter your username and password"
    user_name = prompt.ask("Username: ")
    user_password =  prompt.mask("Password: ")
    current_user = User.find_by(name: user_name, password: user_password)
    # binding.pry
     if current_user && current_user.name != nil
       current_user
     else
       puts "\n------------------------------------------"
       puts "\nPlease check your password and username!\n\n"
       User.login
     end
  end

  def self.loggedin(current_user)
    prompt = TTY::Prompt.new
    choice = ["View & edit Appointment", "Create Appointment", "Log out"]
    input = prompt.select(current_user.welcome, choice)
    if input == "View & edit Appointment"
      current_user.display_all_appointments
    elsif input ==  "Create Appointment"
      current_user.create_event
    elsif input == "Log out"
      puts "Goodbye!"
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

  def create_event
    prompt = TTY::Prompt.new
    input = prompt.select("Do you want to create a new event?", %w(YES NO))
    if input == "YES"
      new_event_name = prompt.ask("Event Name: ")
      new_event_category = prompt.ask("Event Category: ")
      new_event_location = prompt.ask("Event Location: ")
      new_event_date = prompt.ask("Event Date: ")
      new_event_time = prompt.ask("Event Time: ")
      new_event_description = prompt.ask("Event Description: ")
      new_event = Event.find_or_create_by(name: new_event_name, category: new_event_category,location: new_event_location,
      date: new_event_time, time: new_event_time, description: new_event_description)
      puts "Your new event #{new_event_name} is now created!"
      Appointment.create(user_id: self.id, event_id: new_event.id)
    else

    end
  end

  def display_all_appointments
    prompt = TTY::Prompt.new
    appts = Appointment.all.select{|appt| appt if appt.user_id == self.id}.map{ |appt| appt.event_id}
    all_appts_name = []
    appts.each{ |a_id| Event.all.select{ |event| all_appts_name << event.name if event.id == a_id}}
    prompt.select("Select and and view detail of you appointment:", all_appts_name)
  end


end
# User.find_or_create_by(name: new_user_name, age: new_user_age,
#   phone: new_user_phone, occupation: new_user_occupation, password: new_user_password)
# User.login
