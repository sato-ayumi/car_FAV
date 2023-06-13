class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false
      t.references :target, polymorphic: true, null: false
      t.string :action, null: false
      t.boolean :read, dafault: false

      t.timestamps
    end
  end
end
