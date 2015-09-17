class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :care_providers, :admin, :boolean, default: false
  end
end
