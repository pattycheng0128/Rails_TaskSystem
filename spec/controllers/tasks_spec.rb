require "rails_helper"

RSpec.describe TasksController do
  describe "#index" do
    it "response is success" do
      get :index
      
      expect(response).to render_template(:index)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST#create" do
    context "success" do
      it "確認任務名稱" do
        task = create(:task)
        expect(task.name).to be_present
        p "印出日期:#{task.end_time}"
      end
    end
  end
end