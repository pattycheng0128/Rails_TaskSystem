require "rails_helper"

RSpec.describe Task do
  context 'validations' do
    it {should validate_presence_of(:name)}

  end
end