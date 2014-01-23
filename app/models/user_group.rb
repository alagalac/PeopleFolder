class UserGroup < ActiveRecord::Base

  belongs_to :organisation
  has_many :users
  #has_many :user_group_permissions

  TYPE = %w[admin user]

  def is_admin
    return self.group_type == 'admin'
  end
end
