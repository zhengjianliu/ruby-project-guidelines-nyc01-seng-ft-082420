class CreateEvent < ActiveRecord::Migration[6.0]
  def change
    create_table :event do |t|
      t.string :location
      t.integer :date
      t.integer :time
      t.string :description
    end
  end
end
