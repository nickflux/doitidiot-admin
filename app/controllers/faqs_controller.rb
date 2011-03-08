class FaqsController < ApplicationController
  
  # GET    /faqs(.:format)
  def index
    @faqs = Faq.all.paginate(:page => params[:page], :per_page => 50)
  end
  
  # GET    /faqs/:id(.:format)
  def show
    @faq = Faq.find(params[:id])
  end
  
  # GET    /faqs/new(.:format)
  def new
    @faq = Faq.new
  end
  
  # POST   /faqs(.:format)
  def create
    @faq       = Faq.new(params[:faq])
    if @faq.save
      redirect_to :action => 'index'
    else
      render :template => 'faqs/new'
    end

  end

  # GET    /faqs/:id/edit(.:format)
  def edit
    @faq = Faq.find(params[:id])
  end
   
  # PUT    /faqs/:id(.:format)
  def update
    @faq = Faq.find(params[:id])
    if @faq.update_attributes(params[:faq])
      redirect_to :action => 'index'
    else
      render :template => 'faqs/edit'
    end
  end

  # DELETE /faqs/:id(.:format)
  def destroy
    faq = Faq.find(params[:id])
    faq.destroy
    redirect_to :action => 'index'
  end

end
