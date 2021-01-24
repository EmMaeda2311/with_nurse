require 'rails_helper'

feature 'site layout test' do
  scenario 'layout links' do
    visit root_path
    expect(current_path).to eq root_path
    expect(page).to have_link('With Nurse logo', href: root_path)
    expect(page).to have_link('ヘルプ', href: help_path)
    expect(page).to have_link('With Nurseについて', href: about_path)
  end
end