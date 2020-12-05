require 'rails_helper'

RSpec.describe "Api::V1::Todos", type: :request do
  describe "GET /api/v1/todos" do
    subject { get(api_v1_todos_path) }
    before { create_list(:todo, 3) }

    it "Todo一覧を取得する" do
      subject
      res = JSON.parse(response.body)
      expect(res.count).to eq 3
      expect(res[0].keys).to eq ["id", "body", "done"]
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/v1/todos" do
    subject { post(api_v1_todos_path, params: params) }
    let(:params) { { todo: attributes_for(:todo) } }

    it "レコードが作成される" do
      expect { subject }.to change { Todo.count }.by(1)
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH /api/v1/todos/:id" do
    subject { patch(api_v1_todo_path(todo.id), params: params) }
    let(:todo) { create(:todo) }
    let(:params) { { todo: { done: true, created_at: Time.current } } }

    it "指定したレコードが更新される" do
      expect { subject }.to change { Todo.find(todo.id).done }.from(todo.done).to(params[:todo][:done])
      expect { subject }.not_to change { Todo.find(todo.id).body }
      expect { subject }.not_to change { Todo.find(todo.id).created_at }
      expect(response).to have_http_status(204)
    end
  end

  describe "DELETE /api/v1/todos/:id" do
    subject { delete(api_v1_todo_path(todo.id)) }
    let!(:todo) { create(:todo) }

    it "指定したレコードが削除される" do
      expect { subject }.to change { Todo.count }.by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
