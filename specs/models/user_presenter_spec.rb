# encoding: utf-8
require_relative "../../models/user_presenter.rb"

describe UserPresenter do
  let!(:data_hash) do
    {
      'firstName' => "Joe",
      'lastName' => "Bloggs",
      'phoneNumbers' => {
        'values' => [
          {
            'phoneType' => 'Mobile',
            'phoneNumber' => '01234567890'
          },
          {
            'phoneType' => 'Landline',
            'phoneNumber' => '09876543210'
          }
        ]
      },
      'mainAddress' => "Example\nAddress\nTest",
      'interests' => "Fictional Interests",
      'specialties' => "Fictional Specialties",
    }
  end

  let(:object) { UserPresenter.new(data_hash) }
  subject { object }

  describe "provides accessor for full name" do
    its(:full_name) { should eql("Joe Bloggs") }
  end

  describe "provides accessor for address" do
    its(:address) { should eql("Example Address Test") }
  end

  describe "provides accessor for interests" do
    its(:interests) { should eql("Fictional Interests") }
  end

  describe "provides accessor for specialties" do
    its(:specialties) { should eql("Fictional Specialties") }
  end

  describe "provides accessor for employment" do
    its(:employment) { should be_a(EmploymentPresenter) }
  end

  describe "provides accessor for education" do
    its(:education) { should be_a(EducationPresenter) }
  end

  describe "provides accessor for skills" do
    its(:skills) { should be_a(SkillsPresenter) }
  end

  describe "provides accessor for phone number" do
    context "no argument" do
      its(:phone_number) { should eql("01234567890") }
    end
    context "with type" do
      subject { object.phone_number(:landline) }
      it { should eql("09876543210") }
    end
  end
end
