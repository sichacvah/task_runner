class ChangeColumnTypeEstimate < ActiveRecord::Migration
  remove_column :tasks, :estimate
end
