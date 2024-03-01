require 'application_system_test_case'

class CollectionLogItemsTest < ApplicationSystemTestCase
  setup do
    @collection_log_item = collection_log_items(:one)
  end

  test 'visiting the index' do
    visit collection_log_items_url
    assert_selector 'h1', text: 'Collection log items'
  end

  test 'should create collection log item' do
    visit collection_log_items_url
    click_on 'New collection log item'

    click_on 'Create Collection log item'

    assert_text 'Collection log item was successfully created'
    click_on 'Back'
  end

  test 'should update Collection log item' do
    visit collection_log_item_url(@collection_log_item)
    click_on 'Edit this collection log item', match: :first

    click_on 'Update Collection log item'

    assert_text 'Collection log item was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Collection log item' do
    visit collection_log_item_url(@collection_log_item)
    click_on 'Destroy this collection log item', match: :first

    assert_text 'Collection log item was successfully destroyed'
  end
end
