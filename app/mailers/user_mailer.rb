class UserMailer < ApplicationMailer
	default from: "hello@hisseo.co"

	def new_sell(order)
		@order = order
		mail( :to => @order.seller.email, :subject => 'Vous avez une nouvelle vente! - Hisseo.co')
	end

	def new_purchase(order)
		@order = order
		mail( :to => @order.buyer.email, :subject => 'Votre commande! - Hisseo.co')
	end

	def new_listing(listing)
		@listing = listing
		mail( :to => @listing.user.email, :subject => 'Votre nouvelle annonce - Hisseo.co')
	end

	def new_user(user)
		@user = user
		mail( :to => @user.email, :subject => 'Démarrer avec Hisseo')
	end
end
