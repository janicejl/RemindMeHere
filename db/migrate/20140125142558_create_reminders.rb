class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :name
      t.string :item
      t.string :category

      t.timestamps
    end
  end
end
