class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table "users", force: true do |t|
      t.string 'provider'
      t.string 'uid'
      t.text 'oauth_token'
      t.datetime 'oauth_expires_at'
      t.string 'name'

      t.datetime 'created_at'
      t.datetime 'updated_at'
    end
  end
end
