class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :messages
  has_many :orders
  has_many :items, through: :orders

  scope :search, ->(query) { where("name LIKE? or email LIKE?", "%#{query}%", "%#{query}%") if query.present? }

  enum user_group: {
    ur_lica: 0,
    fiz_lica: 1,
    tipografia: 2,
    posrednik: 3
  }

  def normalize_friendly_id text
    text.to_slug.normalize(transliterations: :ukrainian).to_s
  end

  has_attached_file :image, styles: { index: '120x120#', thumb: '82x82#' }, default_style: :original,
                            convert_options: { index: '-quality 85', original: '-quality 85' }

  validates_attachment :image, content_type: { content_type: /^image\/(jpeg|jpg|png|gif)$/ },
                               size: { in: 0..5.megabytes }
end
