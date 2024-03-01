require 'application_system_test_case'

class TabsTest < ApplicationSystemTestCase
  setup do
    @tab = tabs(:one)
  end

  test 'visiting the index' do
    visit tabs_url
    assert_selector 'h1', text: 'Tabs'
  end

  test 'should create tab' do
    visit tabs_url
    click_on 'New tab'

    click_on 'Create Tab'

    assert_text 'Tab was successfully created'
    click_on 'Back'
  end

  test 'should update Tab' do
    visit tab_url(@tab)
    click_on 'Edit this tab', match: :first

    click_on 'Update Tab'

    assert_text 'Tab was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Tab' do
    visit tab_url(@tab)
    click_on 'Destroy this tab', match: :first

    assert_text 'Tab was successfully destroyed'
  end
end
