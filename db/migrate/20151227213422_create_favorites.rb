class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :favoritee_id
      t.string :favoriter_id

      t.timestamps null: false
    end
  end
end
