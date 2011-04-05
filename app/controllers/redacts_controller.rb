class RedactsController < ApplicationController
  
  # GET    /redacts(.:format)
  def index
    @redacts = Redact.all.paginate(:page => params[:page], :per_page => 50)
  end
  
  # GET    /redacts/:id(.:format)
  def show
    @redact = Redact.find(params[:id])
  end
  
  # GET    /redacts/new(.:format)
  def new
    @redact = Redact.new
  end
  
  # POST   /redacts(.:format)
  def create
    @redact       = Redact.new(params[:redact])
    if @redact.save
      redirect_to :action => 'index'
    else
      render :template => 'redacts/new'
    end

  end

  # GET    /redacts/:id/edit(.:format)
  def edit
    @redact = Redact.find(params[:id])
  end
   
  # PUT    /redacts/:id(.:format)
  def update
    @redact = Redact.find(params[:id])
    if @redact.update_attributes(params[:redact])
      redirect_to :action => 'index'
    else
      render :template => 'redacts/edit'
    end
  end

  # DELETE /redacts/:id(.:format)
  def destroy
    redact = Redact.find(params[:id])
    redact.destroy
    redirect_to :action => 'index'
  end

end
