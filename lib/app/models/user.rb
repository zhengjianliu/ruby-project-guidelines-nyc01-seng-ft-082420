require 'pry'
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
    choice = ["Edit & View Personal info", "View & edit Appointment", "Create New Event", "Cancel Your Event",
      "View & Join Event", "Login to another account","Log out"]
    input = prompt.select(current_user.welcome, choice, symbols: { marker: "👉" })
    if input == "View & edit Appointment"
      current_user.display_all_appointments
    elsif input == "Edit & View Personal info"
      current_user.view_edit_personal_info
    elsif input ==  "Create New Event"
      current_user.create_event
    elsif input == "View & Join Event"
      current_user.view_join_event ##alex is working on this.
    elsif input == "Login to another account"
      start
    elsif input == "Log out"
      puts "Goodbye! 👋"
    end
  end












  def self.signup
    prompt = TTY::Prompt.new
    new_user_name = prompt.ask("Please input your name: ",required: true)
    new_user_phone = prompt.ask("Please input your phone number: ",required: true)

    if User.find_by(name:new_user_name, phone: new_user_phone)
      puts "\n------------------------------------------"
      puts "\nYour name and phone number is already registered in the system\nPlease login: "
      User.login
    else
      new_user_age = prompt.ask("Please input your age: ")
      new_user_occupation = prompt.ask("Please input your occupation: ")
      new_user_password = prompt.mask("Please input your password: ",required: true)
      User.create(name: new_user_name, age: new_user_age,
        phone: new_user_phone, occupation: new_user_occupation, password: new_user_password)
      User.login
      # binding.pry
    end
  end

  def welcome
    puts "\n"
    puts "Hey #{self.name}! Welcome to the BOOKING SYSTEM!!"
  end
















  def view_edit_personal_info
    prompt = TTY::Prompt.new
    current_user = self
    puts "
    UserName: #{current_user.name}
    Phone Number:#{current_user.phone}
    Your Age: #{current_user.age}
    Occupation: #{current_user.occupation}
    "

    input = prompt.select("Do you want to edit your info?", %w(NO YES))
    if input == "YES"
      choice =["User Name", "Phone Number","Age", "Occupation","Reset Password"]
      edit_info = prompt.multi_select("Which info you want edit?", choice,symbols: { marker: "👉" })

      edit_info.each{ |info|
        if info == "User Name"
          current_user.name = prompt.ask("Please enter new user name: ")
           while current_user.name == nil do
             puts "Please try again!!!"
             current_user.name = prompt.ask("Please enter new user name: ")
           end
           puts "User Name Updated!"
           current_user.save

        elsif info == "Phone Number"
          new_phone = prompt.ask("Please enter new phone number: ")
          while new_phone == nil do
            puts "Please try again!!!"
            new_phone = prompt.ask("Please enter new phone number: ")
            current_user.phone = new_phone.to_i
          end
          current_user.phone = new_phone.to_i
          puts "Phone Number Updated!"
          current_user.save

        elsif info == "Age"
          new_age = prompt.ask("Please enter age: ")
          while new_age == nil do
            puts "Please try again!!!"
            new_age = prompt.ask("Please enter age: ")
            current_user.age = new_age.to_i
          end
          current_user.age = new_age.to_i
          puts "Age Updated!"
          current_user.save

        elsif info == "Occupation"
          current_user.occupation = prompt.ask("Please enter new occupation: ")
          while current_user.occupation == nil do
            puts "Please try again!!!"
            current_user.occupation = prompt.ask("Please enter new occupation: ")
          end
          puts "Occupation Updated!"
          current_user.save

        elsif info == "Reset Password"
          entry_original_password = prompt.mask("Please enter original password: ")
          i = 0
          while entry_original_password != current_user.password
            i+=1
            puts "Sorry, invalid entry! try again"
            entry_original_password = prompt.mask("##{i} / 5 attempt. Please enter original password: ")
            if i == 6
              puts "Sorry, try again next time."
              User.loggedin(current_user)
            end
          end

          current_user.password = prompt.mask("Please enter new password: ")
          while current_user.password == nil do
            puts "Please try again!!!"
            current_user.password = prompt.mask("Please enter new password: ")
          end
          puts "Password Updated!"
          current_user.save
        end
      }
      User.loggedin(current_user)
    else
      User.loggedin(current_user)
    end
  end














  def create_event
    current_user = self
    prompt = TTY::Prompt.new
    input = prompt.select("Do you want to create a new event?", %w(YES NO),symbols: { marker: "👉" })
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
      User.loggedin(current_user)

    else
      puts "GO BACK!"
      User.loggedin(current_user)
    end
  end












  def display_all_appointments
    current_user = self
    prompt = TTY::Prompt.new
    appts = Appointment.all.select{|appt| appt if appt.user_id == self.id}.map{ |appt| appt.event_id}  ##[5,6] all appt id
    all_appts_name = []
    appts.each{ |a_id| Event.all.select{ |event| all_appts_name << event.name if event.id == a_id}}
    binding.pry
    selected_appt = prompt.select("Select and and view detail of you appointment:", all_appts_name, symbols: { marker: "👉" })
    appts.find{ |a| Event.all.select{|event|
      if event.name == selected_appt
        puts "
        The Appointment Info:
        ---------------------
        Event: #{event.name.upcase}
        Category: #{event.category.upcase}
        Location: #{event.location.upcase}
        Date: #{event.date} | Time: #{event.time}
        Description:
        #{event.description.upcase}
        "
      elsif all_appts_name.count == 0 ## fix this problem.. please alex.
        puts "You have no appointment scheduled!"
        User.loggedin(current_user)
      end} }

    choice = ["GO BACK","Cancel this appointment"]
    input = prompt.select("---------------------", choice, symbols: { marker: "👉" })

    if input == "Cancel this appointment"
      Event.all.find{|event|
        if event.name == selected_appt
          event.id
          Appointment.all.find{|appt|
            if appt.event_id == event.id
              appt.destroy
              #event.destroy
            end
          }
        end
      }
      User.loggedin(current_user)

    elsif input == "GO BACK"
      puts "GO BACK!"
      User.loggedin(current_user)
    end

  end











  def view_join_event
    current_user = self
    prompt = TTY::Prompt.new
    all_event = []
    Event.all.each{ |event|
      all_event << event.name
    }

    selected_event = prompt.select("Choose your destiny?", all_event, symbols: { marker: "👉" })

    Event.all.find{ |event|
      if selected_event == event.name
        puts "
        The Event Info:
        ---------------------
        Event: #{event.name.upcase}
        Category: #{event.category.upcase}
        Location: #{event.location.upcase}
        Date: #{event.date} | Time: #{event.time}
        Description:
        #{event.description.upcase}
        "
      end
    }
    choice = ["GO BACK","Join this appointment"]
    input = prompt.select("---------------------", choice, symbols: { marker: "👉" })
    if input == "Join this appointment"
      Event.all.find{|event|
        if event.name == selected_event
          event.id
          Appointment.find_or_create_by(user_id: self.id, event_id: event.id)
          User.loggedin(current_user)
        end
      }
    elsif input == "GO BACK"
      puts "GO BACK!"
      User.loggedin(current_user)
    end
  end


end  ## this end is for the entire class.
