class Admin < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :messages

  scope :search, ->(query) { where("name LIKE? or email LIKE?", "%#{query}%", "%#{query}%") if query.present? }

  enum admin_role: {
    vladelec: 0,
    meneger: 1,
    rabotnik: 2,
    bugalter: 3
  }

  has_attached_file :image, styles: { index: '290x305#', thumb: '82x82#' }, default_style: :original,
                            convert_options: { index: '-quality 85', original: '-quality 85' }

  validates_attachment :image, content_type: { content_type: /^image\/(jpeg|jpg|png|gif)$/ },
                               size: { in: 0..5.megabytes }
end
