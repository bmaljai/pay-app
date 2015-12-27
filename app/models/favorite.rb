class Favorite < ActiveRecord::Base
  belongs_to :favoriter, foreign_key: "favoriter_id", class_name: "User"
  belongs_to :favoritee, foreign_key: "favoritee_id", class_name: "User"
end
