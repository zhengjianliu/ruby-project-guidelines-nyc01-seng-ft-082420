class User < ActiveRecord::Base
  has_many :appointments
  has_many :events, through: :appointments
end
