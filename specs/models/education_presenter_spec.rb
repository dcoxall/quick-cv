# encoding: utf-8
require_relative "../../models/education_presenter.rb"

describe EducationPresenter do
  let(:mock_one) { double(:college_presenter_one) }
  let(:mock_two) { double(:college_presenter_two) }
  let!(:data_hash) do
    {
      'values' => [
        {}, # College/School data
        {}, # College/School data
      ]
    }
  end
  let(:object) { EducationPresenter.new(data_hash) }
  subject { object }

  describe "enumerates through college presenter objects" do
    before { CollegePresenter.should_receive(:new).and_return(mock_one, mock_two) }
    its(:to_a) { should include(mock_one, mock_two) }
  end
end
