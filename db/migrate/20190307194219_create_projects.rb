class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :status
      t.string :pattern_info
      t.string :notes
      t.integer :user_id
    end
  end
end
