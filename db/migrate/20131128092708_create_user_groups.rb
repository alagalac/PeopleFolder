class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|

      t.string :name, :null => false
      t.string :group_type, :null => false #Admin/User
      t.integer :organisation_id, :null => false
      t.timestamps
    end
  end
end
