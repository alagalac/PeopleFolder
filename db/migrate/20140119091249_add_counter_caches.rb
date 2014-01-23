class AddCounterCaches < ActiveRecord::Migration
  def change
    add_column :ideas, :votes_count, :integer, :null => false, :default => 0
    add_column :questions, :votes_count, :integer, :null => false, :default => 0
  end
end
