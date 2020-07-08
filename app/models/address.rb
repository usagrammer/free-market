class Address < ApplicationRecord
  belongs_to :user, optional: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  validates :city, :house_number, :postal_code, presence: true
  validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
  validates :phone_number, format: {with: /\A\d{10,11}\z/}, allow_blank: true

end
