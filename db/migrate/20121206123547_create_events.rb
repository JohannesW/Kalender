class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :dtstart
      t.datetime :dtend
      t.string :summary
      t.text :description
      t.integer :uid

      t.timestamps
    end
  end
end
