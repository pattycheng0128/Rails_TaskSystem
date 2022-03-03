require "rails_helper"

RSpec.describe Task do
  context 'Verify name is presence' do
    it {should validate_presence_of(:name)}
    # 改語系後會有問題
    # it "確認任務名稱不能重複" do
    #   task = create(:task)
    #   expect(task).to validate_uniqueness_of(:name)
    # end

  end
end