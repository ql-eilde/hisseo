class Listing < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	
  	if Rails.env.development?
      has_attached_file   :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default.jpg"
      has_attached_file   :image2, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default.jpg"
      has_attached_file   :image3, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default.jpg"

    else
      has_attached_file   :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default.jpg",
                          :storage => :dropbox,
                          :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                          :path => ":style/:id_:filename"
      has_attached_file   :image2, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default.jpg",
                          :storage => :dropbox,
                          :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                          :path => ":style/:id_:filename"
      has_attached_file   :image3, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default.jpg",
                          :storage => :dropbox,
                          :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                          :path => ":style/:id_:filename"
    end

	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :departure, :arrival, :description, :price, :date, :time, :nombre_passager, :type_bateau, :bagages, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates_attachment_presence :image

  belongs_to :user
  has_many :orders

  def self.filter(filter1, filter2)
    if filter1
      where(name: filter1, date: filter2)
    end
  end
end
