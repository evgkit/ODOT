require "spec_helper"

describe "Viewing todo items" do
  let(:user) { todo_list.user }
  let!(:todo_list) { create(:todo_list) }
  before { sign_in user, password: "rocket" }

=begin
  before do
    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "List Items"
    end
  end
=end

  it "displays the title of the todo list" do
    visit_todo_list(todo_list)
    within "h1" do
      expect(page).to have_content(todo_list.title)
    end
  end

  it "displays no item when a todo list is empty" do
    visit_todo_list(todo_list)
    expect(page.all("table.todo_items td").size).to eq(0)
  end

  it "displays item content when a todo list has items " do
    todo_list.todo_items.create(content: "Milk")
    todo_list.todo_items.create(content: "Eggs")

    visit_todo_list(todo_list)

    expect(page.all("table.todo_items td").size).to eq(6)

    within "table.todo_items" do
      expect(page).to have_content("Milk")
      expect(page).to have_content("Eggs")
    end
  end
end