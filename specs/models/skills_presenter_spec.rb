# encoding: utf-8
require_relative "../../models/skills_presenter.rb"

describe SkillsPresenter do
  let!(:data_hash) do
    {
      'values' => [
        { 'skill' => { 'name' => 'Fictional Skill' } },
        { 'skill' => { 'name' => 'Example Skill' } },
      ]
    }
  end
  let(:object) { SkillsPresenter.new(data_hash) }
  subject { object }

  describe "enumerates through individual skills" do
    its(:to_a) { should include("Fictional Skill", "Example Skill") }
  end
end
