class Event < ActiveRecord::Base
  has_many :appointments
  has_many :users, through: :appointments

  def create_event
    # t.string :location
    # t.integer :date
    # t.integer :time
    # t.string :description
    prompt = TTY::Prompt.new
    input = prompt.select("Do you want to create a new event?", %w(YES NO))
    if input == "YES"
      new_event_name = prompt.ask("Event Name: ")
      new_event_location = prompt.ask("Event Location: ")
      new_event_date = prompt.ask("Event Date: ")
      new_event_time = prompt.ask("Event Time: ")
      new_event_description = prompt.ask("Event Description: ")
      new_event = Event.find_or_create_by(name: new_user_name, location: new_event_location,
      date: new_event_time, time: new_event_time, description: new_event_description)
      puts "Your new event #{new_event_name} is now created!"
      # Appointment.create(user_id: self.id, event_id: new_event.id)
    else
      puts "GO BACK!"

    end
  end
end
