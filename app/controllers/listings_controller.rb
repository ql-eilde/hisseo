class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :check_user, only: [:edit, :update, :destroy]

  def manager
    @listings = Listing.where(user: current_user)
  end

  # GET /listings
  # GET /listings.json
  def index
    if params[:departure] && params[:arrival] && params[:date]
      @test = "#{params[:departure].capitalize}-#{params[:arrival].capitalize}"
      @listings = Listing.filter(@test, params[:date]).order("created_at DESC").paginate(:page => params[:page], :per_page => 9)
    else
      @listings = Listing.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 9)
    end
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    @listing.name = "#{listing_params[:departure].capitalize}-#{listing_params[:arrival].capitalize}"
    @listing.departure = "#{listing_params[:departure].capitalize}"
    @listing.arrival = "#{listing_params[:arrival].capitalize}"
    length = 10
    @listing.slug = "#{listing_params[:departure].downcase.parameterize}-#{listing_params[:arrival].downcase.parameterize}-#{rand(36**length).to_s(36)}"

    respond_to do |format|
      if @listing.save
        UserMailer.new_listing(@listing).deliver_now
        format.html { redirect_to @listing, notice: "Félicitations ! Votre annonce vient d'être publiée. Vous allez recevoir un email avec les détails de celle-ci." }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: "Votre annonce vient d'être mise à jour." }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: "Votre annonce vient d'être détruite." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:departure, :arrival, :description, :price, :image, :date, :time, :nombre_passager, :type_bateau, :bagages)
    end

    def check_user
      if current_user != @listing.user
        redirect_to root_url, alert: "Sorry, this listing belongs to someone else"
      end
    end
end
