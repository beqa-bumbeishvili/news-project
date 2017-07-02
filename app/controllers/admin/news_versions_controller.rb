class Admin::NewsVersionsController < ApplicationController

  before_action :set_news_version, only: [:show, :edit, :destroy]

  def index
    @current_user = current_user
    if @current_user.present?
      @news_versions = NewsVersion.all if @current_user.is_admin
      @news_versions = NewsVersion.where(active: true) unless @current_user.is_admin
    else
      @news_versions = NewsVersion.where('active = true AND is_draft = false')
    end
  end

  def show
  end

  def new
    @current_user = current_user
    @news = News.new
    @news.created_at = DateTime.now

    if current_user.is_admin
      @news.news_versions.build.is_draft = true
    else
      @news.news_versions.build
    end

  end

  def edit
    @current_user = current_user
  end

  def create
    @news = News.new(news_version_params)
    respond_to do |format|
      if @news.save
        format.html { redirect_to admin_news_version_path(@news), notice: 'News version was successfully created.' }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :new }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if current_user.is_admin
      @news = News.find(params[:news]['id'])
      news_version_params[:is_draft] = false
      news_version_params[:active] = true
      respond_to do |format|
        if @news.update(news_version_params)
          format.html { redirect_to admin_news_version_path(@news), notice: 'News version was successfully updated.' }
          format.json { render :show, status: :ok, location: @news }
        else
          format.html { render :edit }
          format.json { render json: @news.errors, status: :unprocessable_entity }
        end
      end
    else
      version = news_version_params[:news_versions_attributes]['0']
      news_version = NewsVersion.new(news_id: params[:news]['id'], title: version[:title], content: version[:content],
                                     published_at: version[:published_at], active: false, is_draft: true)
      news_version.save!
      redirect_to admin_news_versions_path
    end
  end

  def destroy
    @news_version = NewsVersion.find(params[:id])
    respond_to do |format|
      if @news_version.update(mark_for_deletion: true)
        format.html { redirect_to admin_news_version_path(@news_version), notice: 'News version was successfully marked for deletion' }
        format.json { render :show, status: :ok, location: @news_version }
      else
        format.html { render :edit }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  def activate_version
    NewsVersion.find(params[:id]).update(active: true)
    @current_user = current_user
    if @current_user.present?
      @news_versions = NewsVersion.all if @current_user.is_admin
      @news_versions = NewsVersion.where(active: true) unless @current_user.is_admin
    else
      @news_versions = NewsVersion.where('active = true AND is_draft = false')
    end
    render :index
  end

  def remove_draft
    NewsVersion.find(params[:id]).update(is_draft: false)
    @current_user = current_user
    if @current_user.present?
      @news_versions = NewsVersion.all if @current_user.is_admin
      @news_versions = NewsVersion.where(active: true) unless @current_user.is_admin
    else
      @news_versions = NewsVersion.where('active = true AND is_draft = false')
    end
    render :index
  end

  private

    def set_news_version
      @news = News.find(params[:id])
      @news_version = @news.news_versions.last
    end

    def news_version_params
      params.require(:news).permit(:id, :number,
                                   news_versions_attributes: [:id, :news_id, :title, :content, :published_at, :is_draft, :image, :created_at, :updated_at, :_destroy])
    end
end