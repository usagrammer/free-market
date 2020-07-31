class ItemComment < ApplicationRecord
  belongs_to :item
  belongs_to :user
  validates :content, presence: true
end
