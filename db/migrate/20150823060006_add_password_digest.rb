class AddPasswordDigest < ActiveRecord::Migration
  def change
    add_column :care_providers, :password_digest, :string
  end
end
