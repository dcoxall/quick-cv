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
      data << [{ content: @presenter.address, valign: :center },
        { content: @presenter.full_name, align: :center, valign: :center },
        { content: @presenter.phone_number, align: :right, valign: :center }]
      document.table(data, column_widths: [160, 220, 160]) do
        cells.borders = []
      end

      data = [[ { content: "Employment", colspan: 3 } ]]
      @presenter.employment.each do |position|
        data << [{ content: position.job_title, valign: :center },
          { content: position.company_name, align: :center, valign: :center },
          { content: position.date_range.join(" - "), align: :right, valign: :center }]
        data << [ { content: position.responsibilities, colspan: 3 } ] unless position.responsibilities.nil?
      end
      document.table(data, column_widths: [180, 180, 180]) do
        cells.borders = []
        header_cells = cells.filter do |cell|
          cell.colspan == 1
        end
        header_cells.borders = [:bottom]
      end

      data = [[ { content: "Education", colspan: 3 } ]]
      @presenter.education.each do |school|
        data << [{ content: school.qualification, valign: :center },
          { content: school.establishment, align: :center, valign: :center },
          { content: school.date_range.join(" - "), align: :right, valign: :center }]
        data << [ { content: school.summary, colspan: 3 } ] unless school.summary.nil?
      end
      document.table(data, column_widths: [180, 180, 180]) do
        cells.borders = []
        header_cells = cells.filter do |cell|
          cell.colspan == 1
        end
        header_cells.borders = [:bottom]
      end

      document.render
    end
  end
end
