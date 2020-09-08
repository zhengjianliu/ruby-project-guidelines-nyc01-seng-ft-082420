class User < ActiveRecord::Base
  has_many :appointments
  has_many :events, through: :appointments

  def self.login(user_name)
    User.find_by(name: user_name)

  end

  def self.signup
    # t.string :name
    # t.integer :phone
    # t.integer :age
    # t.string :occupation
    prompt = TTY::Prompt.new
    new_user_name = prompt.ask("Please input your name: ")
    new_user_phone = prompt.ask("Please input your phone number: ")
    new_user_age = prompt.ask("Please input your age: ")
    new_user_occupation = prompt.ask("Please input your occupation: ")
    User.find_or_create_by(name: new_user_name, age: new_user_age,
      phone: new_user_phone, occupation: new_user_occupation)
  end
end
