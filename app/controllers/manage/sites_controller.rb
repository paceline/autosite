class Manage::SitesController < ApplicationController

  # Force authentication
  before_action :authenticate_user!

  # GET /manage/site
  def show
    @user = current_user
  end

  # PUT /manage/site
  def update
    @user = current_user
    @user.site_title = params[:user][:site_title]
    @user.page_id = params[:user][:page_id]
    @user.site_footer = params[:user][:site_footer]
    @user.site_tracker_code = params[:user][:site_tracker_code]
    @user.save
    render plain: t('views.site.update_message')
  end

end
