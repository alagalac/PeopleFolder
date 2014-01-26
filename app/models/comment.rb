class Comment < ActiveRecord::Base

  belongs_to :entity, :polymorphic => true
  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id
  belongs_to :organisation

  validates :content, presence: true
  validates :entity_type, presence: true
  validates :entity_id, presence: true
end
