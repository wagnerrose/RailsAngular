class ChangeColumnTask < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :done, false
  end
end
