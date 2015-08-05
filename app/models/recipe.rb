class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :ingredients
  has_many :directions

  accepts_nested_attributes_for :ingredients, reject_if: proc { |attributes| attributes['name'].blank? }, allow_destroy: true
  accepts_nested_attributes_for :directions, reject_if: proc { |attributes| attributes['step'].blank? }, allow_destroy: true

  validates :title, :description, :pic, :presence => true
  has_attached_file :pic, :styles => { :medium => "300x300#" }
  validates_attachment_content_type :pic, :content_type => /\Aimage\/.*\Z/

  scope :newest_first, -> { order("recipes.created_at DESC") }
end
