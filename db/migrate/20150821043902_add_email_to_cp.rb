class AddEmailToCp < ActiveRecord::Migration
  def change
    add_column :care_providers, :email, :string
    add_index :care_providers, :email, unique: true
  end
end
