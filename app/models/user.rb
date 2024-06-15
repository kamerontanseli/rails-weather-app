class User < ApplicationRecord
  include Clearance::User
  has_many :locations, dependent: :destroy
  has_one :setting, dependent: :destroy
end
