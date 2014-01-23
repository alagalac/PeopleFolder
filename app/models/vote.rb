class Vote < ActiveRecord::Base

  belongs_to :entity, :polymorphic => true, counter_cache: true
  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id
end
