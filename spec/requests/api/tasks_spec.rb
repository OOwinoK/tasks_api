require 'rails_helper'

RSpec.describe 'Tasks API', type: :request do
  let!(:tasks) do
    Task.create!([
      { title: "Sample Task 1", description: "First task", completed: false },
      { title: "Sample Task 2", description: "Second task", completed: true }
    ])
  end

  describe 'GET /api/tasks' do
    it 'returns all tasks' do
      get '/api/tasks'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /api/tasks' do
    context 'with valid parameters' do
      let(:valid_params) { { task: { title: "New Task", description: "Created via test" } } }

      it 'creates a new task' do
        expect {
          post '/api/tasks', params: valid_params
        }.to change(Task, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['title']).to eq('New Task')
      end
    end

    context 'with invalid parameters' do
      it 'returns a validation error' do
        post '/api/tasks', params: { task: { title: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to include("Title can't be blank")
      end
    end
  end

  describe 'DELETE /api/tasks/:id' do
    it 'deletes the task' do
      task = tasks.first
      expect {
        delete "/api/tasks/#{task.id}"
      }.to change(Task, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end

    it 'returns not found for invalid ID' do
      delete "/api/tasks/99999"
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq("Task not found")
    end
  end
end
