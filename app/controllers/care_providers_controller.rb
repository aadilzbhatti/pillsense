class CareProvidersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]

  # GET /care_providers
  # GET /care_providers.json
  def index
    @care_providers = CareProvider.all
  end

  # GET /care_providers/1
  # GET /care_providers/1.json
  def show
    @care_provider = CareProvider.find(params[:id])
  end

  # GET /care_providers/new
  def new
    @care_provider = CareProvider.new
  end

  # GET /care_providers/1/edit
  def edit
    @care_provider = CareProvider.find(params[:id])
  end

  # POST /care_providers
  # POST /care_providers.json
  def create
    @care_provider = CareProvider.new(care_provider_params)
    if @care_provider.save
      render 'show'
    else
      render 'new'
    end
  end

  # PATCH/PUT /care_providers/1
  # PATCH/PUT /care_providers/1.json
  def update
    respond_to do |format|
      if @care_provider.update(care_provider_params)
        format.html { redirect_to @care_provider, notice: 'Care provider was successfully updated.' }
        format.json { render :show, status: :ok, location: @care_provider }
      else
        format.html { render :edit }
        format.json { render json: @care_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /care_providers/1
  # DELETE /care_providers/1.json
  def destroy
    @care_provider.destroy
    respond_to do |format|
      format.html { redirect_to care_providers_url, notice: 'Care provider was successfully destroyed.' }
      format.json { head :no_content }
    end
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
        flash[:danger] = 'Please log in.'
        redirect_to login_url
      end
    end

    # Checks if user is correct user
    def correct_user
      @care_provider = CareProvider.find(params[:id])
      redirect_to root_url unless current_user?(@care_provider)
    end

    # Confirms an admin user
    # def admin_user
    #   redirect_to root_url unless current_user.admin?
    # end
end
