# encoding: utf-8
class SkillsPresenter
  include Enumerable

  def initialize(data_hash = {})
    @skills = data_hash['values'].collect { |s| s['skill']['name'] }
  end

  def each(&block)
    @skills.each(&block)
  end
end
