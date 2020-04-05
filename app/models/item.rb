  validates :name, :price, :detail, :condition, :delivery_fee_payer, :delivery_method, :prefecture_id, :delivery_days, :deal, presence: true
  validates :price, numericality:{greater_than_or_equal_to: 300,less_than_or_equal_to: 9999999}
  belongs_to :category
  belongs_to :seller, class_name: "User", foreign_key: 'seller_id'
  belongs_to :buyer, class_name: "User", foreign_key: 'buyer_id', optional: :true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
