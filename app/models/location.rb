class Location < ApplicationRecord
    belongs_to :user
    validates :city, uniqueness: { scope: :user_id, message: "has already been added" }
end