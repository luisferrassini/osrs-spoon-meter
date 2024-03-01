require 'test_helper'

class CollectionLogItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @collection_log_item = collection_log_items(:one)
  end

  test 'should get index' do
    get collection_log_items_url
    assert_response :success
  end

  test 'should get new' do
    get new_collection_log_item_url
    assert_response :success
  end

  test 'should create collection_log_item' do
    assert_difference('CollectionLogItem.count') do
      post collection_log_items_url, params: { collection_log_item: {} }
    end

    assert_redirected_to collection_log_item_url(CollectionLogItem.last)
  end

  test 'should show collection_log_item' do
    get collection_log_item_url(@collection_log_item)
    assert_response :success
  end

  test 'should get edit' do
    get edit_collection_log_item_url(@collection_log_item)
    assert_response :success
  end

  test 'should update collection_log_item' do
    patch collection_log_item_url(@collection_log_item), params: { collection_log_item: {} }
    assert_redirected_to collection_log_item_url(@collection_log_item)
  end

  test 'should destroy collection_log_item' do
    assert_difference('CollectionLogItem.count', -1) do
      delete collection_log_item_url(@collection_log_item)
    end

    assert_redirected_to collection_log_items_url
  end
end
