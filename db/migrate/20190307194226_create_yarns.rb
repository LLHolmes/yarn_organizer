class CreateYarns < ActiveRecord::Migration[5.2]
  def change
    create_table :yarns do |t|
      t.string :color
      t.integer :count
      t.float :scrap
      t.integer :project_id
      t.integer :brand_id
    end
  end
end
