require "application_system_test_case"

class CollectionLogEntriesTest < ApplicationSystemTestCase
  setup do
    @collection_log_entry = collection_log_entries(:one)
  end

  test "visiting the index" do
    visit collection_log_entries_url
    assert_selector "h1", text: "Collection log entries"
  end

  test "should create collection log entry" do
    visit collection_log_entries_url
    click_on "New collection log entry"

    click_on "Create Collection log entry"

    assert_text "Collection log entry was successfully created"
    click_on "Back"
  end

  test "should update Collection log entry" do
    visit collection_log_entry_url(@collection_log_entry)
    click_on "Edit this collection log entry", match: :first

    click_on "Update Collection log entry"

    assert_text "Collection log entry was successfully updated"
    click_on "Back"
  end

  test "should destroy Collection log entry" do
    visit collection_log_entry_url(@collection_log_entry)
    click_on "Destroy this collection log entry", match: :first

    assert_text "Collection log entry was successfully destroyed"
  end
end
