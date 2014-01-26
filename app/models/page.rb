class Page < ActiveRecord::Base
  belongs_to :organisation

  validates :title, presence: true
  validates :content, presence: true


  def to_param
    name
  end
end
