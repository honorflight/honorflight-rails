require 'rails_helper'

RSpec.describe SimplePage, type: :model do
  it { should validate_presence_of :key }
  it { should validate_presence_of :title }
  it { should validate_presence_of :markdown }

  it 'produces html' do
    page = FactoryGirl.create(:simple_page)
    expect(page.html).to eql("<p>MyText</p>\n")
  end
end
