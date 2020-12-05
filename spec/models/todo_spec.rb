require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe "validates presence" do
    context "bodyを指定している時" do
      let(:todo) { create(:todo) }
      it "レコードが作成される" do
        expect(todo).to be_valid
      end
    end

    context "bodyを指定していないとき" do
      let(:todo) { build(:todo, body: nil) }
      it "エラーになる" do
        todo.valid?
        expect(todo.errors.messages[:body]).to include "can't be blank"
      end    
    end
  end
end
