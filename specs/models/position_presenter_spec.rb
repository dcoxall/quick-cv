# encoding: utf-8
require_relative "../../models/position_presenter.rb"

describe PositionPresenter do
  let!(:data_hash) do
    {
      'title' => "Developer",
      'company' => { 'name' => "Quick CV" },
      'startDate' => { 'month' => 1, 'year' => 2013 },
      'endDate' => { 'month' => 2, 'year' => 2014 },
      'summary' => "Brief summary",
    }
  end
  let(:object) { PositionPresenter.new(data_hash) }
  subject { object }

  describe "provides accessor for job title" do
    its(:job_title) { should eql("Developer") }
  end

  describe "provides accessor for company" do
    its(:company_name) { should eql("Quick CV") }
  end

  describe "date range" do
    subject { object.date_range && object.date_range.to_a }

    context "yet to start" do
      before { data_hash['startDate'] = nil }
      it { should eql(nil) }
    end

    context "currently active" do
      before { data_hash['isCurrent'] = true }
      it { should include("Current") }
    end

    context "with months" do
      describe "displays short month name" do
        it { should include("Jan 2013", "Feb 2014") }
      end
    end

    context "without months" do
      describe "only displays years" do
        before { data_hash['startDate']['month'], data_hash['endDate']['month'] = nil }
        it { should include(2013, 2014) }
      end
    end
  end

  describe "provides accessor for responsibilities" do
    its(:responsibilities) { should eql("Brief summary") }
  end
end
