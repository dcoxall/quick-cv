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
        { content: @presenter.full_name, align: :center, valign: :center, size: 18, font_style: :bold },
        { content: [@presenter.phone_number, @presenter.email_address].join("\n"), align: :right, valign: :center }]
      document.table(data, column_widths: [160, 220, 160]) do
        cells.borders = []
      end

      data = [[ { content: "EMPLOYMENT", colspan: 3, font_style: :bold, size: 14, padding: [20, 5, 0, 5] } ]]
      @presenter.employment.first(3).each do |position|
        data << [{ content: position.job_title, valign: :center, font_style: :bold },
          { content: position.company_name, align: :center, valign: :center, font_style: :bold },
          { content: position.date_range.join(" - "), align: :right, valign: :center, font_style: :bold }]
        data << [ { content: position.responsibilities, colspan: 3 } ] unless position.responsibilities.nil?
      end
      document.table(data, column_widths: [180, 180, 180]) do
        cells.borders = []
        header_cells = row(0)
        header_cells.borders = [:bottom]
        header_cells.border_width = 2
      end

      data = [[ { content: "EDUCATION", colspan: 3, font_style: :bold, size: 14, padding: [20, 5, 0, 5] } ]]
      @presenter.education.each do |school|
        data << [{ content: school.qualification, valign: :center, font_style: :bold },
          { content: school.establishment, align: :center, valign: :center, font_style: :bold },
          { content: school.date_range.join(" - "), align: :right, valign: :center, font_style: :bold }]
        data << [ { content: school.summary, colspan: 3 } ] unless school.summary.nil?
      end
      document.table(data, column_widths: [180, 180, 180]) do
        cells.borders = []
        header_cells = row(0)
        header_cells.borders = [:bottom]
        header_cells.border_width = 2
      end

      document.render
    end
  end
end
