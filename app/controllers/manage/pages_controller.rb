class Manage::PagesController < ApplicationController

  # Force authentication
  before_action :authenticate_user!

  # GET /manage/pages
  def index
    @pages = current_user.pages
    redirect_to new_manage_page_url if @pages.blank?
    @page = @pages.first
  end

  # GET /manage/pages/new
  def new
    @page = current_user.pages.build
  end

  # POST /manage/pages
  def create
    @page = current_user.pages.create(page_params)
    redirect_to manage_pages_url, notice: t('views.pages.create.notice')
  end

  # GET /manage/pages/1/edit
  def edit
    @page = Page.find(params[:id])
    render json: { page: render_to_string('_form', layout: false) }
  end

  # PATCH /manage/pages/1
  def update
    @page = Page.find(params[:id])
    @page.update(page_params)
    redirect_to manage_pages_url, notice: t('views.pages.update.notice')
  end

  # DELETE /manage/pages/1
  def destroy
    Page.destroy(params[:id])
    redirect_to manage_pages_url, notice: t('views.pages.delete.notice')
  end

  # POST /manage/pages/reorder
  def reorder
    params[:page_ids].each_with_index do |id,i|
      page = Page.find(id)
      page.position = i+1
      page.save
    end
    render plain: "OK"
  end

  private

   def page_params
     params.require(:page).permit(:kind, :name, :title, :body)
   end

end
