require "spec_helper"

describe "Editing todo lists" do
  let(:user) { create(:user) }
  let!(:todo_list) { TodoList.create(title: "Groceries", description: "Grocery list.") }

  def updates_todo_list(options = {})
    options[:title] ||= "My todo list"
    options[:description] ||= "This is my todo list."
    todo_list = options[:todo_list] #||= TodoList.create(title: "Groceries", description: "Grocery list.")

    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link("Edit")
    end

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Update Todo list"

    todo_list.reload
  end

  before do
    sign_in user, password: "rocket"
  end

  it "updates a todo list successfully with correct information" do
    updates_todo_list todo_list: todo_list,
                      title: "New title",
                      description: "New description"

    expect(page).to have_content("Todo list was successfully updated.")
    expect(todo_list.title).to eq("New title")
    expect(todo_list.description).to eq("New description")
  end

  it "displays an error with no title" do
    updates_todo_list todo_list: todo_list, title: ""
    expect(todo_list.title).to eq(todo_list.title)
    expect(page).to have_content("error")
  end

  it "displays an error with too short a title " do
    updates_todo_list todo_list: todo_list, title: "Hi"
    expect(todo_list.title).to eq(todo_list.title)
    expect(page).to have_content("error")
  end

  it "displays an error with no description" do
    updates_todo_list todo_list: todo_list, description: ""
    expect(todo_list.description).to eq(todo_list.description)
    expect(page).to have_content("error")
  end

  it "displays an error with too short a description " do
    updates_todo_list todo_list: todo_list, description: "Four"
    expect(todo_list.description).to eq(todo_list.description)
    expect(page).to have_content("error")
  end
end