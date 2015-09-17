class ProvidersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy, :index]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new(provider_params)
    if @provider.save
      log_in @provider
      remember @provider
      flash[:success] = 'Welcome to the PillSense Web Application!'
      render 'show'
    else
      render 'new'
    end
  end

  def show
    @provider = Provider.find(params[:id])
  end

  def edit
    @provider = Provider.find(params[:id])
  end

  def update
    @provider = Provider.find(params[:id])
    if @provider.update_attributes(provider_params)
      flash[:success] = 'Profile Updated'
      redirect_to @provider
    else
      render 'edit'
    end
  end

  def index
    @providers = Provider.all
  end

  def destroy
    Provider.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to providers_url
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def provider_params
      params.require(:provider).permit(:name, :email, :password, :password_confirmation)
    end

    # Before filters

    # Confirms a logged in user
    def logged_in_user
      unless logged_in?
        store_location
        flash.now[:danger] = 'Please log in.'
        redirect_to login_url
      end
    end

    # Checks if user is correct user
    def correct_user
      @provider = Provider.find(params[:id])
      redirect_to root_url unless current_user?(@provider)
    end

    # Confirms an admin user
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end