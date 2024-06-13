class User < ApplicationRecord
  include Clearance::User
  has_many :locations, dependent: :destroy
end
