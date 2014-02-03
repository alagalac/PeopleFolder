class Idea < ActiveRecord::Base

  belongs_to :organisation
  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id
  has_many :votes, :as => :entity, :dependent => :destroy, :autosave => true
  has_many :comments, :as => :entity, :dependent => :destroy, :autosave => true

  paginates_per 15

  validates :title, presence: true
  validates :content, presence: true

end
