require "rails_helper"

RSpec.describe Task do
  it {validate_presence_of(:name)}
  it {is_expected.to belong_to(:user)}
  it {validate_presence_of(:valid_due_date?)}
end