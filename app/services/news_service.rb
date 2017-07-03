class NewsService

  def self.get_news_versions(current_user)
    if current_user.present?
      return NewsVersion.all if current_user.is_admin
      NewsVersion.where('active = true AND mark_for_deletion <> true') unless current_user.is_admin
    else
      NewsVersion.where('active = true AND is_draft = false AND mark_for_deletion <> true')
    end
  end

end