require "rails_helper"

RSpec.describe TasksController do

  #index
  describe "GET index" do
    it "assigns @tasks" do
      task1 = create(:task)
      task2 = create(:task)

      get :index

      expect(assigns[:tasks]).to eq([task1, task2])
    end
 
    it "render template" do
      task1 = create(:task)
      task2 = create(:task)

      get :index
      expect(response).to render_template("index")
    end
  end

  #show
  describe "GET show" do

    it "assigns @task" do
      task = create(:task)
      get :show, params: {id: task.id}

      expect(assigns[:task]).to eq(task)
    end

    it "render template" do
      task = create(:task)
      get :show, params: {id: task.id}

      expect(response).to render_template("show")
    end
  end

  # new
  describe "GET new" do
    context "when user login" do
      let(:user){create(:user)}
      let(:task){build(:task)}

      before do
        sign_in user
        get :new
      end

      it "assigns @task" do
        expect(assigns(:task)).to be_a_new(Task)
      end

      it "render template" do
        expect(response).to render_template("new")
      end
    end

    # 確認使用者沒登入,會到轉到登入頁面
    context "when user not login" do
      it "redirect_to new_user_session_path" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  # create
  describe "POST create" do
    let(:user){create(:user)}
    before{sign_in user}

    it "create a new task record" do
      task = build(:task)

      expect do
        post :create, params: {task: attributes_for(:task)}
      end.to change{ Task.count }.by(1)
    end

    it "redirects to tasks_path" do
      task = build(:task)

      post :create, params: {task: attributes_for(:task)}
      expect(response).to redirect_to tasks_path
    end

    context "when task doesn't have a name" do
      it "doesn't create a record" do
        expect do
          post :create, params: {task: {content: "bar", end_time: "2022-08-09"}}
        end.to change {Task.count}.by(0)
      end

      it "render new template" do
        post :create, params: {task: {content: "bar", end_time: "2022-08-09"}}

        expect(response).to render_template("new")
      end
    end

    context "when task has a name" do
      it "create a new task record" do
        task = build(:task)
        
        expect do
          post :create, params: {task: attributes_for(:task)}
        end.to change {Task.count}.by(1)
      end

      it "redirects to tasks_path" do
        task = build(:task)
        post :create, params: {task: attributes_for(:task)}

        expect(response).to redirect_to tasks_path
      end

      it "create a task for user" do
        task = build(:task)
        post :create, params: {task: attributes_for(:task)}
        expect(Task.last.user).to eq(user)
      end
    end
  end

  # edit
  describe "GET edit" do
    # 必須是建立 task 的使用者才能做編輯
    let(:author) {create(:user)}
    let(:not_author) {create(:user)}

    context "signed in as author" do
      before {sign_in author}

      it "assigns task" do
        task = create(:task, user: author)
        get :edit, params: {id: task.id}
        expect(assigns[:task]).to eq(task)
      end

      it "render template" do
        task = create(:task, user: author)
        get :edit, params: {id: task.id}
        expect(response).to render_template("edit")
      end
    end

    context "signed in not as author" do
      before {sign_in not_author}

      it "raises an error" do
        task = create(:task, user: author)
        expect do
          get :edit, params: {id: task.id}
        end.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  #update
  describe "PUT update" do
    let(:author){create(:user)}
    let(:not_author){create(:user)}

    context "sign in as author" do
      before {sign_in author}

      context "when course has name" do
        it "assigns @task" do
          task = create(:task, user: author)

          put :update, params: {id: task.id, task: {name: "task1", content: "bar", end_time: "2022-08-09"}}
          expect(assigns[:task]).to eq(task)
        end

        it "changes value" do
          task  = create(:task, user: author)

          put :update, params: {id: task.id, task: {name: "task1", content: "bar2", end_time: "2022-08-09"}}
          expect(assigns[:task]).to eq(task)
          expect(assigns[:task].content).to eq("bar2")
        end

        it "redirects to tasks_path" do
          task = create(:task, user: author)

          put :update, params: {id: task.id, task: {name: "task1", content: "bar2", end_time: "2022-08-09"}}
          expect(response).to redirect_to tasks_path
        end
      end

      context "when task doesn't have name" do
        it "doesn't update a record" do
          task = create(:task, user: author)

          put :update, params: {id: task.id, task: {name: "", content: "hi", end_time: "2022-08-09"}}
          expect(task.content).not_to eq("hi")
        end

        it "render edit template" do
          task = create(:task, user: author)

          put :update, params: {id: task.id, task: {name: "",content: "hi", end_time: "2022-08-09"}}
          expect(response).to render_template("edit")
        end
      end
    end

    context "sign in not as author" do
      before {sign_in not_author}

      it "raise an error" do
        task = create(:task, user: author)

        expect do
          put :update, params: {id: task.id, task: {name: "",content: "hi", end_time: "2022-08-09"}}
        end.to raise_error ActiveRecord::RecordNotFound
      end

    end
  end

  # delete
  describe "DELETE destroy" do
    let(:author) {create(:user)}
    let(:not_author) {create(:user)}

    context "when sign in as author" do
      before{sign_in author}

      it "assigns as task" do
        task = create(:task, user: author)
        delete :destroy, params: {id: task.id}
        expect(assigns[:task]).to eq(task)
      end

      it "delete a record" do
        task = create(:task, user: author)

        expect do
          delete :destroy, params: {id: task.id}
        end.to change {Task.count}.by(-1)
      end

      it "redirects to tasks_path" do
        task = create(:task, user: author)
        delete :destroy, params: {id: task.id}
        expect(response).to redirect_to tasks_path
      end
    end

    context "when sign in as not author" do
      before{sign_in not_author}

      it "raises an error" do
        task = create(:task, user: author)

        expect do
          delete :destroy, params: {id: task.id}
        end.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  
end