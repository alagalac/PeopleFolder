class CreateRecognitions < ActiveRecord::Migration
  def change
    create_table :recognitions do |t|

    	t.integer :creator_id, :null => false
      t.integer :organisation_id, :null => false
      t.integer :recognised_id, :null => false
      t.string :content, :null => false
      t.integer :points, :null => false
      t.timestamps
    end
  end
end
