class Favorite < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :post, dependent: :destroy
end
