class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def sales
    @orders = Order.all.where(seller: current_user).order("created_at DESC")
  end

  def purchases
    @orders = Order.all.where(buyer: current_user).order("created_at DESC")
  end

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @listing = Listing.friendly.find(params[:listing_id])
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @listing = Listing.friendly.find(params[:listing_id])
    test = @listing.compte_passager
    ret = test + params[:compte_passager].to_i
    @listing.update_attribute(:compte_passager, ret)
    @seller = @listing.user

    @order.listing_id = @listing.id
    @order.buyer_id = current_user.id
    @order.seller_id = @seller.id
    @order.nb_places = params[:compte_passager].to_i

    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
    token = params[:stripeToken]
    amount = ((@listing.price * params[:compte_passager].to_i) + ((params[:compte_passager].to_i * 1) + (params[:compte_passager].to_i * (@listing.price * 0.09)))) * 100
    puts amount

    begin
      charge = Stripe::Charge.create(
        :amount => amount.floor,
        :currency => "EUR",
        :card => token
        )
      flash[:notice] = "À l'abordage ! Vous venez de recevoir un email avec les détails de votre réservation."
    rescue
      flash[:info] = e.message
    end

    respond_to do |format|
      if @order.save
        UserMailer.new_sell(@order).deliver_now #envoi email au vendeur "nouvelle vente"
        UserMailer.new_purchase(@order).deliver_now #envoi email acheteur "votre commande"
        format.html { redirect_to root_url }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params[:order]
    end
end
