class NewsService

  def self.get_news_versions(current_user)
    if current_user.present?
      return NewsVersion.all if current_user.is_admin
      NewsVersion.where('active = true AND mark_for_deletion <> true') unless current_user.is_admin
    else
      NewsVersion.where('active = true AND is_draft = false AND mark_for_deletion <> true')
    end
  end

  def self.create_new_version(version_params)
    version = version_params[:news_versions_attributes]['0']
    datetime = DateTime.new(version['published_at(1i)'].to_i,
                            version['published_at(2i)'].to_i,
                            version['published_at(3i)'].to_i,
                            version['published_at(4i)'].to_i,
                            version['published_at(5i)'].to_i)
    news_version = NewsVersion.new(news_id: version_params['id'], title: version[:title], content: version[:content],
                                   published_at: datetime, active: false, is_draft: true)
    news_version.save!
  end

  def self.set_draft_and_active(version_params)
    version_params[:news_versions_attributes]['0'][:is_draft] = false
    version_params[:news_versions_attributes]['0'][:active] = true
    version_params
  end

  def self.update_version_id_in_news(news)
    news_active_version = NewsVersion.where("news_id = #{news.id} AND active = true").last
    news.update(news_version_id: news_active_version.id)
  end

end