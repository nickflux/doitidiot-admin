class MailMessagesController < ApplicationController
  
  # GET    /mail_messages(.:format)
  def index
    @mail_messages = MailMessage.all.order_by([:date_to_send, :desc]).paginate(:page => params[:page], :per_page => 50)
  end
  
  # GET    /mail_messages/:id(.:format)
  def show
    @mail_message = MailMessage.find(params[:id])
  end
  
  # GET    /mail_messages/new(.:format)
  def new
    @mail_message = MailMessage.new
  end
  
  # POST   /mail_messages(.:format)
  def create
    @mail_message       = MailMessage.new(params[:mail_message])
    if @mail_message.save
      redirect_to :action => 'index'
    else
      render :template => 'mail_messages/new'
    end

  end

  # GET    /mail_messages/:id/edit(.:format)
  def edit
    @mail_message = MailMessage.find(params[:id])
  end
   
  # PUT    /mail_messages/:id(.:format)
  def update
    @mail_message = MailMessage.find(params[:id])
    if @mail_message.update_attributes(params[:mail_message])
      redirect_to :action => 'index'
    else
      render :template => 'mail_messages/edit'
    end
  end

  # DELETE /mail_messages/:id(.:format)
  def destroy
    mail_message = MailMessage.find(params[:id])
    mail_message.destroy
    redirect_to :action => 'index'
  end

end
