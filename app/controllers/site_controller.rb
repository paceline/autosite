class SiteController < ApplicationController
  include Pagy::Backend

  layout 'site'

  before_action :load_site

  # GET /
  def home
    @pagy, @records = pagy(Update.all)
  end

  # GET /projects
  def show
    @page = Page.where(name: params[:slug]).first
    if @page.style?
      render plain: @page.body, layout: false, content_type: "text/css"
    else
      render 'show'
    end
  end

  # GET /site/update
  def update
    Provider.where.not(token: [nil, ""]).each do |p|
      p.sync
    end
    render json: { status: 200, message: "Update successfully executed" }
  end

  private

    def load_site
      @site = User.first
      @pages = @site.pages.where(kind: 'Static Page')
    end

end
