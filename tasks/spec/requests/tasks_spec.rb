RSpec.describe "/tasks", type: :request do
  describe "POST /assign" do
    it "assigns all the open tasks to random users" do
      tasks = create_list(:task, 3, assignee_id: nil, state: :open)
      post assign_tasks_url
      tasks.each do |task|
        expect(task.reload.assignee_id).to be_present
      end
    end

    it "doesn't update done tasks" do
      task = create(:task, state: :done)
      expect { post assign_tasks_url }.not_to change { task.reload.updated_at }
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Task" do
        expect {
          post tasks_url, params: { task: attributes_for(:task) }
          expect(response).to redirect_to(task_url(Task.last))
        }.to change(Task, :count).by(1)
      end

      it 'notifies user' do
        expect(NotifyAssignee).to receive(:call) do |task:|
          expect(task.assignee_id).to eq 'fake_id'
        end
        post tasks_url, params: { task: { assignee_id: 'fake_id', description: 'asd' } }
      end
    end

    context "with invalid parameters" do
      it "does not create a new Task" do
        expect {
          post tasks_url, params: { task: { description: '' } }
        }.to change(Task, :count).by(0)

        expect(response.code).to eq '422'
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { description: 'new text', assignee_id: 'another' }
      }

      it "updates the requested task" do
        task = create(:task)
        patch task_url(task), params: { task: new_attributes }
        task.reload
        expect(task).to have_attributes(description: 'new text', assignee_id: 'another')
        expect(response).to redirect_to(task_url(task))
      end

      it 'notifies user' do
        created_task = create(:task)
        expect(NotifyAssignee).to receive(:call) do |task:|
          expect(task.assignee_id).to eq 'another'
        end
        patch task_url(created_task), params: { task: new_attributes }
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        task = create(:task)
        patch task_url(task), params: { task: { description: '' } }
        expect(response.code).to eq '422'
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested task" do
      task = create(:task)
      expect {
        delete task_url(task)
      }.to change(Task, :count).by(-1)

      expect(response).to redirect_to(tasks_url)
    end
  end

  describe "GET /index" do
    it "renders a successful response" do
      create(:task)
      get tasks_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      task = create(:task)
      get task_url(task)
      expect(response).to be_successful
    end
  end
end
