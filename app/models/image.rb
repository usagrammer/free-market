class Image < ApplicationRecord
  mount_uploader :src, ImageUploader
end
