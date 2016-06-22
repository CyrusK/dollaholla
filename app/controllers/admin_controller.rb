class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin_user

  def pin
    @pin = Pin.find(params[:pin_id])
    @active_bids = @pin.active_bids.all
    @cancelled_bids = @pin.cancelled_bids.all
  end

  private
    def require_admin_user
      if !current_user.is_admin?
        render_404
        return
      end
    end
end
