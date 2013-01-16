class ChangeUid <ActiveRecord::Migration
      def change
      drop_table :users
      
      
      create_table :users do |t|
      t.string :name
      t.string :pw
      t.string :email

      t.timestamps
    end
    create_table :events do |t|
      t.datetime :dtstart
      t.datetime :dtend
      t.string :summary
      t.text :description
      t.integer :user_id
    end
      end
      
end
