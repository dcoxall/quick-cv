# encoding: utf-8
require_relative "../../models/college_presenter.rb"

describe CollegePresenter do
  let!(:data_hash) do
    {
      'degree' => "BSc",
      'fieldOfStudy' => "Computer Science",
      'schoolName' => "Fictional College",
      'startDate' => { 'month' => 1, 'year' => 2013 },
      'endDate' => { 'month' => 2, 'year' => 2014 },
      'notes' => "Brief summary",
    }
  end
  let(:object) { CollegePresenter.new(data_hash) }
  subject { object }

  describe "formats degree and field of study" do
    its(:qualification) { should eql("BSc Computer Science") }
  end

  describe "provides accessor for school/establishment" do
    its(:establishment) { should eql("Fictional College") }
  end

  describe "date range" do
    subject { object.date_range && object.date_range.to_a }

    context "yet to start" do
      before { data_hash['startDate'] = nil }
      it { should eql(nil) }
    end

    context "currently active" do
      before { data_hash['endDate'] = nil }
      it { should include("Current") }
    end

    context "with months" do
      describe "displays full month name" do
        it { should include("January 2013", "February 2014") }
      end
    end

    context "without months" do
      describe "only displays years" do
        before { data_hash['startDate']['month'], data_hash['endDate']['month'] = nil }
        it { should include(2013, 2014) }
      end
    end
  end

  describe "provides accessor for notes/summary" do
    its(:summary) { should eql("Brief summary") }
  end
end
