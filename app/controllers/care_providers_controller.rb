class CareProvidersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy, :index]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def new
    @care_provider = CareProvider.new
  end

  def create
    @care_provider = CareProvider.new(care_provider_params)
    if @care_provider.save
      log_in @care_provider
      remember @care_provider
      flash[:success] = 'Welcome to the PillSense Web Application!'
      render 'show'
    else
      render 'new'
    end
  end

  def show
    @care_provider = CareProvider.find(params[:id])
  end

  def edit
    @care_provider = CareProvider.find(params[:id])
  end

  def update
    @care_provider = CareProvider.find(params[:id])
    if @care_provider.update_attributes(care_provider_params)
      flash[:success] = 'Profile Updated'
      redirect_to @care_provider
    else
      render 'edit'
    end
  end

  def index
    @care_providers = CareProvider.all
  end

  def destroy
    CareProvider.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to care_providers_url
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def care_provider_params
      params.require(:care_provider).permit(:name, :email, :password, :password_confirmation)
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
      @care_provider = CareProvider.find(params[:id])
      redirect_to root_url unless current_user?(@care_provider)
    end

    # Confirms an admin user
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end