class AdditionalService < ApplicationRecord
  belongs_to :item, inverse_of: :additional_services
end
