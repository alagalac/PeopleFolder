class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string :first_name
      t.string :last_name
      t.integer :organisation_id, :null => false
      t.integer :user_group_id, :null => false

      t.timestamps
    end
  end
end
