class CreateUser < ActiveRecord::Migration[6.0]
  def change
    create_table :user do |t|
      t.string :name
      t.integer :phone
      t.integer :age
      t.string :occupation
    end
  end
end
