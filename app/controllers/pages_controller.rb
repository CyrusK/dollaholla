class PagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
        if params.has_key?(:pin_id)
            @pin = Pin.find(params[:pin_id])
        end
  end

  def auction
  end

  def terms
  end

    class ContactsController < ApplicationController
        def new
          @contact = Contact.new
        end

        def create
          @contact = Contact.new(params[:contact])
          @contact.request = request
          if @contact.deliver
            flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
          else
                flash.now[:error] = 'Cannot send message.'
                render :new
          end 
        end
    end
end
