class ChangeScrapToTextOnYarns < ActiveRecord::Migration[5.2]
  def change
    change_column :yarns, :scrap, :string
  end
end
