# encoding: utf-8
require "prawn"
require "securerandom"
require_relative "user_presenter.rb"

module CV
  class Document
    def initialize(presenter)
      raise "Must provide a UserPresenter" unless presenter.is_a?(UserPresenter)
      @presenter = presenter
    end

    def generate
      document = Prawn::Document.new
      data = []

      # Insert table header
      data << [@presenter.address, @presenter.full_name, @presenter.phone_number]

      data << [ { content: "Employment", colspan: 3 } ]
      @presenter.employment.each do |position|
        data << [position.job_title, position.company_name, position.date_range.join(" - ")]
        data << [ { content: position.responsibilities, colspan: 3 } ] unless position.responsibilities.nil?
      end

      data << [ { content: "Education", colspan: 3 } ]
      @presenter.education.each do |school|
        data << [school.qualification, school.establishment, school.date_range.join(" - ")]
        data << [ { content: school.summary, colspan: 3 } ] unless school.summary.nil?
      end

      document.table(data, column_widths: [180, 180, 180])

      document.render
    end
  end
end
