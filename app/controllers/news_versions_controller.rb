class NewsVersionsController < ApplicationController
  before_action :set_news_version, only: [:show, :edit, :update, :destroy]

  # GET /news_versions
  # GET /news_versions.json
  def index
    @news_versions = NewsVersion.all
  end

  # GET /news_versions/1
  # GET /news_versions/1.json
  def show
  end

  # GET /news_versions/new
  def new
    @news_version = NewsVersion.new
  end

  # GET /news_versions/1/edit
  def edit
  end

  # POST /news_versions
  # POST /news_versions.json
  def create
    @news_version = NewsVersion.new(news_version_params)

    respond_to do |format|
      if @news_version.save
        format.html { redirect_to @news_version, notice: 'News version was successfully created.' }
        format.json { render :show, status: :created, location: @news_version }
      else
        format.html { render :new }
        format.json { render json: @news_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news_versions/1
  # PATCH/PUT /news_versions/1.json
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

  # DELETE /news_versions/1
  # DELETE /news_versions/1.json
  def destroy
    @news_version.destroy
    respond_to do |format|
      format.html { redirect_to news_versions_url, notice: 'News version was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news_version
      @news_version = NewsVersion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_version_params
      params.require(:news_version).permit(:news_id, :title, :content, :published_at, :post_type_id, :created_at, :updated_at)
    end
end
