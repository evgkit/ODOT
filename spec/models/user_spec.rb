require 'spec_helper'

RSpec.describe User, :type => :model do
  let(:valid_attributes) {
    {
        first_name: "Tim",
        last_name: "Kuk",
        email: "stevejobs@apple.com",
        password: "blame_the_frog1234",
        password_confirmation: "blame_the_frog1234"
    }
  }

  context "validations" do
    let(:user) { User.new(valid_attributes) }

    before do
      User.create(valid_attributes)
    end

    it "requires an email" do
      expect(user).to validate_presence_of(:email)
    end

    it "requires a unique email" do
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires a unique email (case insensitive)" do
      user.email = "STEVEJOBS@apple.com"
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires the email address to look like an email address" do
      user.email = "faker"
      expect(user).to_not be_valid
    end

    describe "#downcase email" do
      it "makes the email attribute lower case" do
        user = User.new(valid_attributes.merge(email: "TimmyCook@apple.COM"))
        # user.downcase_email
        # expect(user.email).to eq("timmycook@apple.com")
        expect{ user.downcase_email }.to change{ user.email }.
                                             from("TimmyCook@apple.COM").
                                             to("timmycook@apple.com")
      end

      it "downcases an email before saving" do
        user = User.new(valid_attributes)
        user.email = "STEVEJOBS@APPLE.com"
        expect(user.save).to equal(true)
        expect(user.email).to eq("stevejobs@apple.com")
      end
    end

  end
end
