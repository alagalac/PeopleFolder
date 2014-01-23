class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|

      t.string   :entity_type, :null => false
      t.integer  :entity_id, :null => false
      t.integer  :creator_id, :null => false
      t.timestamps
    end
  end
end
