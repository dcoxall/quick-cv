# encoding: utf-8
require_relative "../../models/certifications_presenter.rb"

describe CertificationsPresenter do
  let(:mock_one) { double(:certification_presenter_one) }
  let(:mock_two) { double(:certification_presenter_two) }
  let!(:data_hash) do
    {
      'values' => [
        {}, # Certifications data
        {}, # Certifications data
      ]
    }
  end
  let(:object) { CertificationsPresenter.new(data_hash) }
  subject { object }

  describe "enumerates through position presenter objects" do
    before { CertificationPresenter.should_receive(:new).and_return(mock_one, mock_two) }
    its(:to_a) { should include(mock_one, mock_two) }
  end
end
