require "spec_helper"

describe "Deleting todo lists" do
  let(:user) { todo_list.user }
  let!(:todo_list) { create(:todo_list) }

  it "is successful when clicking the destroy link" do
    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link("Destroy")
    end

    #todo_list.reload

    expect(page).to have_content("Todo list was successfully destroyed.")
    expect(page).not_to have_content(todo_list.title)
    expect(TodoList.count).to eq(0)
  end

  before do
    sign_in user, password: "rocket"
  end

end