class ChargesController < ApplicationController
  
    def create
      # Amount in cents
      @pin = Pin.find(params[:id])
      @amount = (@pin.price * 100).floor

      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :card  => params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
      )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charges_path
    end
  
end