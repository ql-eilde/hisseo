class UserMailer < ApplicationMailer
	default from: "hello@hisseo.co"

	def new_sell(order)
		@order = order
		mail( :to => @order.seller.email, :subject => 'hisseo.co - Vous avez une nouvelle vente !')
	end

	def new_purchase(order)
		@order = order
		mail( :to => @order.buyer.email, :subject => 'hisseo.co - Votre commande !')
	end

	def new_listing(listing)
		@listing = listing
		mail( :to => @listing.user.email, :subject => 'hisseo.co - Votre annonce')
	end
end
