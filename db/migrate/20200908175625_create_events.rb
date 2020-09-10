class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :category
      t.string :name
      t.string :location
      t.string :date
      t.string :time
      t.string :description
    end
  end
end
