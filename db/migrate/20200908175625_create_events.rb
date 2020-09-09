class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :category
      t.string :name
      t.string :location
      t.integer :date
      t.integer :time
      t.string :description
    end
  end
end
