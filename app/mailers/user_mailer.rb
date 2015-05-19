class UserMailer < ApplicationMailer
	default from: "quentin.leilde@gmail.com"

	def new_sell(order)
		@order = order
		mail( :to => @order.seller.email, :subject => 'Vous avez une nouvelle vente !')
	end

	def new_purchase(order)
		@order = order
		mail( :to => @order.buyer.email, :subject => 'Votre commande sur ******.com')
	end

	def new_listing(listing)
		@listing = listing
		mail( :to => @listing.user.email, :subject => 'Votre annonce sur ******.com')
	end
end
