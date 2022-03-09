class UpdatePriorityTypeInTask < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :priority, :integer
    add_column :tasks, :priority, :string
  end
end
