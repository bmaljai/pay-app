class User < ActiveRecord::Base
  has_many :favoriter_favorites, foreign_key: :favoritee_id, class_name: "Favorite"
  has_many :favoriters, through: :favoriter_favorites

  has_many :favoritee_favorites, foreign_key: :favoriter_id, class_name: "Favorite"
  has_many :favoritees, through: :favoritee_favorites
end
