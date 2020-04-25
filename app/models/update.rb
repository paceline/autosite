class Update < ApplicationRecord

  # Associations
  belongs_to :provider

  # Validations
  validates :originalid, uniqueness: { scope: :provider_id, message: "should appear only once per provider to avoid duplicates" }

end
