class AddExpiresOnToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :expires_on, :date, null: false, default: -> { 'NOW()' }
  end
end
