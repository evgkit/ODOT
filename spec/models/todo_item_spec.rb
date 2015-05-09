require 'spec_helper'

describe TodoItem do
  it { should belong_to(:todo_list) }

  describe "#completed?" do
    let(:todo_item) { TodoItem.create(content: "Hello") }

    it "is false then completed_at is blank" do
      todo_item.completed_at = nil
      expect(todo_item.completed?).to eq(false)
    end

    it "returns true then completed_at is not empty" do
      todo_item.completed_at = Time.now
      expect(todo_item.completed?).to eq(true)
    end
  end
end
