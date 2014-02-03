class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :user_group
  belongs_to :organisation
  has_many :votes, :foreign_key => :creator_id, :autosave => true
  has_many :comments, :foreign_key => :creator_id, :autosave => true
  has_many :ideas, :foreign_key => :creator_id, :autosave => true

  paginates_per 15

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :user_group

  def full_name
    first_name + " " + last_name
  end
end
