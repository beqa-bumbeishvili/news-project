class Admin::NewsVersionsController < ApplicationController
  before_action :set_news_version, only: [:show, :edit, :destroy]

  def index
    @current_user = current_user
    @news_versions = NewsService.get_news_versions(@current_user)
  end

  def show
    @comment = Comment.new
    @comment.news_id = @news.id
    @news_comments = Comment.where(news_id: @news.id)
  end

  def new
    @current_user = current_user
    @news = News.new
    @news.created_at = DateTime.now
    if current_user.is_admin
      @news.news_versions.build.is_draft = false
    else
      @news.news_versions.build   #draft is true by default
    end

  end

  def edit
    @current_user = current_user
  end

  def create
    @news = News.new(news_version_params)
    respond_to do |format|
      if @news.save
        @news.update(news_version_id: NewsVersion.last.id) if NewsVersion.last.active == true
        format.html { redirect_to admin_news_version_path(version_from_news(@news.news_version_id)), notice: 'News version was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    if current_user.is_admin    #if admin edits version
      @news = News.find(params[:news]['id'])
      version_params = NewsService.set_draft_and_active(news_version_params)
      respond_to do |format|
        if @news.update(version_params)
          NewsService.update_version_id_in_news(@news)
          format.html { redirect_to admin_news_version_path(version_from_news(@news.news_version_id)), notice: 'News version was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    else
      NewsService.create_new_version(news_version_params)   #if authorized user edits version, not admin
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
    @version = NewsVersion.find(params[:id])
    if @version.update(active: true)
      @version.news.update(news_version_id: @version.id)
    end
    @current_user = current_user
    @news_versions = NewsService.get_news_versions(@current_user)
    render :index
  end

  def remove_draft
    NewsVersion.find(params[:id]).update(is_draft: false)
    @current_user = current_user
    @news_versions = NewsService.get_news_versions(@current_user)
    render :index
  end

  def create_comment
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to admin_news_version_path(version_from_news(@comment.news.news_version_id)), notice: 'Comment was successfully created.' }
      else
        format.html { render :show }
      end
    end
  end

  private

    def set_news_version
      @news_version = NewsVersion.find(params[:id])
      @news = @news_version.news
    end

    def version_from_news(id)
      NewsVersion.find(id)
    end

    def news_version_params
      params.require(:news).permit(:id, :number,
                                   news_versions_attributes: [:id, :news_id, :title, :content, :published_at, :is_draft, :active, :image, :created_at, :updated_at, :_destroy])
    end

  def comment_params
    params.require(:comment).permit(:id, :news_id, :comment)
  end
end