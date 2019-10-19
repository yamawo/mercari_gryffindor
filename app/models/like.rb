class Like < ApplicationRecord
  belongs_to :user, dependent: :delete
  belongs_to :product, dependent: :delete
end
