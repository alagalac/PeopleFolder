class Feedback < ActiveRecord::Base

  belongs_to :organisation
  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id

  validates :content, presence: true
end
