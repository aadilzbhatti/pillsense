class CareProvidersController < ApplicationController
  before_action :set_care_provider, only: [:show, :edit, :update, :destroy]

  # GET /care_providers
  # GET /care_providers.json
  def index
    @care_providers = CareProvider.all
  end

  # GET /care_providers/1
  # GET /care_providers/1.json
  def show
  end

  # GET /care_providers/new
  def new
    @care_provider = CareProvider.new
  end

  # GET /care_providers/1/edit
  def edit
  end

  # POST /care_providers
  # POST /care_providers.json
  def create
    @care_provider = CareProvider.new(care_provider_params)

    respond_to do |format|
      if @care_provider.save
        format.html { redirect_to @care_provider, notice: 'Care provider was successfully created.' }
        format.json { render :show, status: :created, location: @care_provider }
      else
        format.html { render :new }
        format.json { render json: @care_provider.errors, status: :unprocessable_entity }
      end
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
    # Use callbacks to share common setup or constraints between actions.
    def set_care_provider
      @care_provider = CareProvider.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def care_provider_params
      params.require(:care_provider).permit(:name)
    end
end
