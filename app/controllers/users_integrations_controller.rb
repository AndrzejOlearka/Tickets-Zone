class UsersIntegrationsController < ApplicationController
  before_action :set_users_integration, only: %i[ show edit update destroy ]

  # GET /users_integrations or /users_integrations.json
  def index
    @users_integrations = UsersIntegration.all
  end

  # GET /users_integrations/1 or /users_integrations/1.json
  def show
  end

  # GET /users_integrations/new
  def new
    @users_integration = UsersIntegration.new
  end

  # GET /users_integrations/1/edit
  def edit
  end

  # POST /users_integrations or /users_integrations.json
  def create
    @users_integration = UsersIntegration.new(users_integration_params)

    respond_to do |format|
      if @users_integration.save
        format.html { redirect_to @users_integration, notice: "Users integration was successfully created." }
        format.json { render :show, status: :created, location: @users_integration }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @users_integration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users_integrations/1 or /users_integrations/1.json
  def update
    respond_to do |format|
      if @users_integration.update(users_integration_params)
        format.html { redirect_to @users_integration, notice: "Users integration was successfully updated." }
        format.json { render :show, status: :ok, location: @users_integration }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @users_integration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users_integrations/1 or /users_integrations/1.json
  def destroy
    @users_integration.destroy
    respond_to do |format|
      format.html { redirect_to users_integrations_url, notice: "Users integration was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_users_integration
      @users_integration = UsersIntegration.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def users_integration_params
      params.require(:users_integration).permit(:id, :integration_id, :user_id, :name, :uri, :username, :password, :options)
    end
end
