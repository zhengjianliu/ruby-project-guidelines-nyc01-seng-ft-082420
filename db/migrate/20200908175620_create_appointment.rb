class CreateAppointment < ActiveRecord::Migration[6.0]
  def change
    create_table :appointment do |t|
      t.integer :user_id
      t.integer :event_id
    end
  end
end
