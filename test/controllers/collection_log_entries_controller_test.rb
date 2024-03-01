require 'test_helper'

class CollectionLogEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @collection_log_entry = collection_log_entries(:one)
  end

  test 'should get index' do
    get collection_log_entries_url
    assert_response :success
  end

  test 'should get new' do
    get new_collection_log_entry_url
    assert_response :success
  end

  test 'should create collection_log_entry' do
    assert_difference('CollectionLogEntry.count') do
      post collection_log_entries_url, params: { collection_log_entry: {} }
    end

    assert_redirected_to collection_log_entry_url(CollectionLogEntry.last)
  end

  test 'should show collection_log_entry' do
    get collection_log_entry_url(@collection_log_entry)
    assert_response :success
  end

  test 'should get edit' do
    get edit_collection_log_entry_url(@collection_log_entry)
    assert_response :success
  end

  test 'should update collection_log_entry' do
    patch collection_log_entry_url(@collection_log_entry), params: { collection_log_entry: {} }
    assert_redirected_to collection_log_entry_url(@collection_log_entry)
  end

  test 'should destroy collection_log_entry' do
    assert_difference('CollectionLogEntry.count', -1) do
      delete collection_log_entry_url(@collection_log_entry)
    end

    assert_redirected_to collection_log_entries_url
  end
end
