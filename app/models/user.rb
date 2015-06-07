class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:facebook]

  if Rails.env.development?
      has_attached_file   :profile_img, :styles => { :medium => "200x", :thumb => "100x100>" }

  else
      has_attached_file   :profile_img, :styles => { :medium => "200x", :thumb => "100x100>" },
                          :storage => :dropbox,
                          :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                          :path => ":style/:id_:filename"
  end

  do_not_validate_attachment_file_type :profile_img

  validates :first_name, :last_name, :email, presence: true

  has_many :listings, dependent: :destroy
  has_many :sales, class_name: "Order", foreign_key: "seller_id"
  has_many :purchases, class_name: "Order", foreign_key: "buyer_id"

  def confirm!
    welcome_email
    super
  end

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.facebook_img = auth.info.image
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.password = Devise.friendly_token[0,20]
      end
  end

  private

    def welcome_email
      UserMailer.new_user(self).deliver_now
    end
end
