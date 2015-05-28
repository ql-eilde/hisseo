class AddImagesToListings < ActiveRecord::Migration
  def self.up
    change_table :listings do |t|
      t.attachment :image2
      t.attachment :image3
    end
  end

  def self.down
    remove_attachment :listings, :image2
    remove_attachment :listings, :image3
  end
end
