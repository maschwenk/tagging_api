class Product < ActiveRecord::Base
  has_many :tags, as: :taggable, dependent: :destroy
end