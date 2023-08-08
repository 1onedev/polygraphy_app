class ItemFile < ApplicationRecord
  belongs_to :item, inverse_of: :item_file, optional: true

  has_attached_file :file
  validates_attachment :file, content_type: { content_type: /^application\/(pdf|tiff)$/ },
                               size: { in: 0..200.megabytes }

end
