require 'test_helper'

class CollectionLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @collection_log = collection_logs(:one)
  end

  test 'should get index' do
    get collection_logs_url
    assert_response :success
  end

  test 'should get new' do
    get new_collection_log_url
    assert_response :success
  end

  test 'should create collection_log' do
    assert_difference('CollectionLog.count') do
      post collection_logs_url, params: { collection_log: {} }
    end

    assert_redirected_to collection_log_url(CollectionLog.last)
  end

  test 'should show collection_log' do
    get collection_log_url(@collection_log)
    assert_response :success
  end

  test 'should get edit' do
    get edit_collection_log_url(@collection_log)
    assert_response :success
  end

  test 'should update collection_log' do
    patch collection_log_url(@collection_log), params: { collection_log: {} }
    assert_redirected_to collection_log_url(@collection_log)
  end

  test 'should destroy collection_log' do
    assert_difference('CollectionLog.count', -1) do
      delete collection_log_url(@collection_log)
    end

    assert_redirected_to collection_logs_url
  end
end
