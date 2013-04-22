# encoding: utf-8
class SkillsPresenter
  include Enumerable

  def initialize(data_hash = {})
    if data_hash != nil && data_hash.is_a?(Hash) && data_hash['values'] != nil
      @skills = data_hash['values'].collect { |s| s['skill']['name'].to_s }
    else
      @skills = []
    end
  end

  def each(&block)
    @skills.each(&block)
  end
end
