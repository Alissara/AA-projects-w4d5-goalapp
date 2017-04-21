class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false, index: true
      t.string :title, null: false
      t.text :details
      t.string :visibility, default: 'private', null: false
      t.string :status, default: 'ongoing', null: false
      t.timestamps
    end
  end
end
