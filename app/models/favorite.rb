class Favorite < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :posts, dependent: :destroy
end
