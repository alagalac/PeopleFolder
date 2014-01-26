class UserGroup < ActiveRecord::Base

  belongs_to :organisation
  has_many :users
  #has_many :user_group_permissions

  validates :name, presence: true
  validates :group_type, presence: true

  TYPE = %w[admin user]

  def is_admin
    return self.group_type == 'admin'
  end
end
