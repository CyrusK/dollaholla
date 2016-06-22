class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy, :bid]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @pins = Pin.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 9)
  end

  def bid
    Bid.where(user_id: current_user.id, pin_id: @pin.id).each do |bid|
      bid.cancel!
    end

    bid = Bid.new
    bid.user = current_user
    bid.pin = @pin
    bid.price = params[:price].to_f
    bid.quantity = params[:quantity] ? params[:quantity].to_i : 1
    bid.save
    render json: {
        success: true
    }
  end

  def show
    @existing_bid = @pin.bid_for(current_user)
  end

  def new
    @pin = current_user.pins.new
  end

  def edit
  end

  def create
    @pin = current_user.pins.new(pin_params)
    if @pin.save
      redirect_to @pin, notice: 'Listing was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: 'Pin was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @pin.destroy
    redirect_to pins_url, notice: 'Pin was successfully destroyed.'
  end

  private
    def set_pin
      @pin = Pin.find(params[:id])
      # @pin = Pin.find(params[:pin_id])
    end

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Not authorized to edit this listing." if @pin.nil?
    end

    def pin_params
      params.require(:pin).permit(:description, :price, :image, :image2, :image3, :image4, :image5, :manufacturer, :model)
    end
end
