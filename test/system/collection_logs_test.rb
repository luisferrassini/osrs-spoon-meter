require "application_system_test_case"

class CollectionLogsTest < ApplicationSystemTestCase
  setup do
    @collection_log = collection_logs(:one)
  end

  test "visiting the index" do
    visit collection_logs_url
    assert_selector "h1", text: "Collection logs"
  end

  test "should create collection log" do
    visit collection_logs_url
    click_on "New collection log"

    click_on "Create Collection log"

    assert_text "Collection log was successfully created"
    click_on "Back"
  end

  test "should update Collection log" do
    visit collection_log_url(@collection_log)
    click_on "Edit this collection log", match: :first

    click_on "Update Collection log"

    assert_text "Collection log was successfully updated"
    click_on "Back"
  end

  test "should destroy Collection log" do
    visit collection_log_url(@collection_log)
    click_on "Destroy this collection log", match: :first

    assert_text "Collection log was successfully destroyed"
  end
end
