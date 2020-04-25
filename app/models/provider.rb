class Provider < ApplicationRecord

  # Associations
  belongs_to :user
  has_many :updates

  def authorized?
    !self.token.blank?
  end

  def key
    self.class.to_s.downcase
  end

end
