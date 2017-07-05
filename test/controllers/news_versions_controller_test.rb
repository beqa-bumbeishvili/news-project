require 'test_helper'

class NewsVersionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @news_version = news_versions(:one)
  end

  test 'should get index' do
    get admin_news_versions_url
    assert_response :success
  end

  test 'should get new' do
    get new_admin_news_version_url
    assert_response :success
  end

  test 'should create news_version' do
    assert_difference('NewsVersion.count') do
      post admin_news_versions_url, params: { news_version: { content: @news_version.content, created_at: @news_version.created_at, news_id: @news_version.news_id, post_type_id: @news_version.post_type_id, published_at: @news_version.published_at, title: @news_version.title, updated_at: @news_version.updated_at } }
    end

    assert_redirected_to admin_news_version_url(NewsVersion.last)
  end

  test 'should show news_version' do
    get admin_news_version_url(@news_version)
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_news_version_url(@news_version)
    assert_response :success
  end

  test 'should update news_version' do
    patch admin_news_version_url(@news_version), params: { news_version: { content: @news_version.content, created_at: @news_version.created_at, news_id: @news_version.news_id, post_type_id: @news_version.post_type_id, published_at: @news_version.published_at, title: @news_version.title, updated_at: @news_version.updated_at } }
    assert_redirected_to admin_news_version_url(@news_version)
  end

  test 'should destroy news_version' do
    assert_difference('NewsVersion.count', -1) do
      delete admin_news_version_url(@news_version)
    end

    assert_redirected_to admin_news_versions_url
  end
end
