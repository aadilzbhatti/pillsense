class AddRememberDigestToUsers < ActiveRecord::Migration
  def change
    add_column :care_providers, :remember_digest, :string
  end
end
