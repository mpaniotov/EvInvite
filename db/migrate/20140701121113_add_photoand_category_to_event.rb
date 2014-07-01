class AddPhotoandCategoryToEvent < ActiveRecord::Migration
  def change
    add_column :events, :photo, :string
    add_reference :events, :category, index: true
  end
end
