class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :email, unique: true
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
