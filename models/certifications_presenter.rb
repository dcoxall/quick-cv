# encoding: utf-8
require_relative "certification_presenter.rb"

class CertificationsPresenter
  include Enumerable

  def initialize(data_hash)
    if data_hash != nil && data_hash.is_a?(Hash) && data_hash['values'] != nil
      @data = data_hash['values'].collect { |position| CertificationPresenter.new(position) }
    else
      @data = []
    end
  end

  def each(&block)
    @data.each(&block)
  end

end
