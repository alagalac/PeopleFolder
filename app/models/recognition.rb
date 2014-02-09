class Recognition < ActiveRecord::Base

	belongs_to :organisation
  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id
  belongs_to :recognised, :class_name => "User", :foreign_key => :creator_id

  validates :recognised_id, presence: true
  validates :content, presence: true
  validates :points, presence: true

  TYPE = [["Bronze medal", 1], ["Silver medal", 5], ["Gold medal", 10]]
end
