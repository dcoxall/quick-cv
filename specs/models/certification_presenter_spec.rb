# encoding: utf-8
require_relative "../../models/certification_presenter.rb"

describe CertificationPresenter do
  let!(:data_hash) do
    {
      'name' => "Certification Name",
      'authority' => "Example Authority Name",
      'number' => "ABC123",
      'startDate' => { 'month' => 1, 'year' => 2013 },
      'endDate' => { 'month' => 2, 'year' => 2014 },
    }
  end
  let(:object) { CertificationPresenter.new(data_hash) }
  subject { object }

  describe "provides accessor for name" do
    its(:name) { should eql("Certification Name") }
  end

  describe "provides accessor for authority" do
    its(:authority) { should eql("Example Authority Name") }
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

  describe "provides accessor for number" do
    its(:number) { should eql("ABC123") }
  end
end
