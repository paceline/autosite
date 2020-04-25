class Page < ApplicationRecord

  # Associations
  belongs_to :user

  def style?
    self.kind == "Stylesheet"
  end

end
