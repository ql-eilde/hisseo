class UserMailer < ApplicationMailer
	default from: "hello@viaboat.fr"

	def new_sell(order)
		@order = order
		mail( :to => @order.seller.email, :subject => 'Vous avez une nouvelle vente! - Viaboat.fr')
	end

	def new_purchase(order)
		@order = order
		mail( :to => @order.buyer.email, :subject => 'Votre commande! - Viaboat.fr')
	end

	def new_listing(listing)
		@listing = listing
		mail( :to => @listing.user.email, :subject => 'Votre nouvelle annonce - Viaboat.fr')
	end

	def new_user(user)
		@user = user
		mail( :to => @user.email, :subject => 'Démarrer avec Viaboat')
	end
end
