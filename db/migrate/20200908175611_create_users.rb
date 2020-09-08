class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :phone
      t.integer :age
      t.string :occupation
      t.string :password
    end
  end
end
