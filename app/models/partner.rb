class Partner < ApplicationRecord
  has_attached_file :image, styles: { index: '166x111#' },
                            convert_options: { index: '-quality 70' }

  validates_attachment :image, content_type: { content_type: /^image\/(jpeg|jpg|png|gif)$/ },
                               size: { in: 0..5.megabytes }
end