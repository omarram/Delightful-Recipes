class AddAttachmentPicToRecipes < ActiveRecord::Migration
  def self.up
    change_table :recipes do |t|
      t.attachment :pic
    end
  end

  def self.down
    remove_attachment :recipes, :pic
  end
end
