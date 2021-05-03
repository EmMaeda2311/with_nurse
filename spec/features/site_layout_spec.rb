require 'rails_helper'

feature 'site layout test' do
  scenario 'layout links' do
    visit root_path
    expect(current_path).to eq root_path
    expect(page).to have_link('With Nurse logo', href: root_path)
  end
end
