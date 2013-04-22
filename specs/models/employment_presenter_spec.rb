# encoding: utf-8
require_relative "../../models/employment_presenter.rb"

describe EmploymentPresenter do
  let(:mock_one) { double(:position_presenter_one) }
  let(:mock_two) { double(:position_presenter_two) }
  let!(:data_hash) do
    {
      'values' => [
        {}, # Position data
        {}, # Position data
      ]
    }
  end
  let(:object) { EmploymentPresenter.new(data_hash) }
  subject { object }

  describe "enumerates through position presenter objects" do
    before { PositionPresenter.should_receive(:new).and_return(mock_one, mock_two) }
    its(:to_a) { should include(mock_one, mock_two) }
  end
end
