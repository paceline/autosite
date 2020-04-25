class User < ApplicationRecord

  # Associations
  has_many :pages, -> { order('position') }
  has_many :providers, -> { order('type') }
  belongs_to :stylesheet, foreign_key: 'page_id', class_name: 'Page', optional: true

  # Include devise modules
  devise :database_authenticatable, :registerable, :confirmable, :validatable, :confirmable, :lockable, :rememberable

end
