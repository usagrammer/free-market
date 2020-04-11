class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  validates :nickname, :birthday, :first_name, :last_name, presence: true
  validates :first_name_reading, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :last_name_reading, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,128}+\z/i }

  has_many :selling_items, class_name: "Item", foreign_key: "seller_id"
  has_many :bought_items, class_name: "Item", foreign_key: "buyer_id"
  has_one :sns_credential, dependent: :destroy

  def self.from_omniauth(auth_data)
  end

end
