class ChangeNameToProviders < ActiveRecord::Migration
  def change
    rename_table :care_providers, :providers
  end
end
