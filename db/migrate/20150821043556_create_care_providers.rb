class CreateCareProviders < ActiveRecord::Migration
  def change
    create_table :care_providers do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
