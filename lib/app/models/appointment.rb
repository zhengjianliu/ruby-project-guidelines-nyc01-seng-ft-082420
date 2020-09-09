class Appointment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  # def self.show_event(user)
  #   user_appointments = Appointment.all.filter do |appt|
  #     appointment.user == user
  #   end
  #   user_events = user_appointments.map do |appointment|
  #     appointment.event
  #   end
  # end
end
