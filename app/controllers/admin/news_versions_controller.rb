class Admin::NewsVersionsController < ApplicationController

  before_action :set_news_version, only: [:show, :edit, :update, :destroy]

  def index
    @news_versions = NewsVersion.all
  end

  def show
  end

  def new
    @news = News.new
    @news.created_at = DateTime.now

    @news.news_versions.build
  end

  def edit
    @news.news_versions.build
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
    respond_to do |format|
      if @news_version.update(news_version_params)
        format.html { redirect_to @news_version, notice: 'News version was successfully updated.' }
        format.json { render :show, status: :ok, location: @news_version }
      else
        format.html { render :edit }
        format.json { render json: @news_version.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @news_version.destroy
    respond_to do |format|
      format.html { redirect_to admin_news_versions_url, notice: 'News version was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_news_version
      @news = News.find(params[:id])
      @news_version = @news.news_versions.last
    end

    def news_version_params
      params.require(:news).permit(:id, :number,
                                   news_versions_attributes: [:title, :content, :published_at, :news_type_id, :image, :created_at, :updated_at])
    end
end
