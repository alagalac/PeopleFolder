class Page < ActiveRecord::Base
  belongs_to :organisation


  def to_param
    name
  end
end
