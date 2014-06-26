class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string 'title'
      t.integer 'creator_id'
      t.string 'location'
      t.string 'address'
      t.datetime 'start_time'
      t.datetime 'end_time'
      t.string 'message'
      t.timestamps
    end
  end
end
