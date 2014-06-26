class CreateEventParticipants < ActiveRecord::Migration
  def change
    create_table :event_participants do |t|
      t.integer 'user_id'
      t.integer 'event_id'
      t.string 'participate_decision'
      t.timestamps
    end
  end
end
