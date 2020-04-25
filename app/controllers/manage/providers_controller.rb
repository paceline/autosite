class Manage::ProvidersController < ApplicationController

  # Force authentication
  before_action :authenticate_user!

  # GET /manage/providers
  def index
    @providers = current_user.providers
    redirect_to new_manage_provider_url if @providers.blank?
    @provider = @providers.first
  end

  # GET /manage/providers/new
  def new
    @provider = current_user.providers.build
  end

  # POST /manage/providers
  def create
    @provider = current_user.providers.create(provider_params(:provider))
    redirect_to manage_providers_url, notice: t('views.providers.create.notice')
  end

  # GET /manage/providers/1/edit
  def edit
    @provider = Provider.find(params[:id])
    render json: { provider: render_to_string('_form', layout: false) }
  end

  # PATCH /manage/providers/1
  def update
    @provider = Provider.find(params[:id])
    @provider.update(provider_params(@provider.key))
    redirect_to manage_providers_url, notice: t('views.providers.update.notice')
  end

  # DELETE /manage/providers/1
  def destroy
    Provider.destroy(params[:id])
    redirect_to manage_providers_url, notice: t('views.providers.delete.notice')
  end

  # GET /auth/github/callback
  def authorize
    credentials = auth_hash.credentials
    @provider = Provider.where(type: auth_hash.provider.capitalize).first
    @provider.token = credentials.token
    @provider.secret = credentials.secret if credentials.key?(:secret)
    @provider.username = auth_hash.info.nickname if auth_hash.key?(:info) && auth_hash.info.key?(:nickname)
    @provider.save
    redirect_to manage_providers_url, notice: t('views.providers.update.authorized')
  end

  # GET /auth/github/setup
  def setup
    account = Provider.where(type: params[:provider].capitalize)
    if account
      case params[:provider]
        when "github"
          request.env['omniauth.strategy'].options[:client_id] = account.first.api_key
          request.env['omniauth.strategy'].options[:client_secret] = account.first.api_secret
        when "twitter"
          request.env['omniauth.strategy'].options[:consumer_key] = account.first.api_key
          request.env['omniauth.strategy'].options[:consumer_secret] = account.first.api_secret
      end
    end
    render plain: "Omniauth setup phase.", status: 404
  end

  protected

   def provider_params(key)
     params.require(key).permit(:type, :api_key, :api_secret, :repost)
   end

   def auth_hash
     request.env['omniauth.auth']
   end

end
