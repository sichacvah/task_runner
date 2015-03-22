class AddColumnEstimateWithDatetime < ActiveRecord::Migration
  def change
    add_column :tasks, :estimate, :datetime
  end
end
