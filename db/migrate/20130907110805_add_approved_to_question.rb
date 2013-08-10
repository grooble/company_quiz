class AddApprovedToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :approved, :boolean, :default => 0
  end
end
