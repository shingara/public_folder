require 'integrations/spec_helper'

feature "Browse and update directory" do

  scenario "browse directory and add one" do
    visit '/'
    click_on(I18n.t('nodes.index.add_directory'))
    within "#new_directory" do
      fill_in I18n.t('simple_form.labels.directory.name'), :with => 'foo'
      expect {
        click_on I18n.t('directories.new.create_directory')
      }.to change {
        Directory.count
      }.by(1)
    end
    page.should have_css 'ul.breadcrumb li', :text => 'foo'
  end

end