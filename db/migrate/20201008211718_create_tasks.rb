class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.boolean :status
      t.datetime :time_start
      t.datetime :time_end
      t.integer :prioritize
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
