# frozen_string_literal: true

require 'csv'
require_relative 'base.rb'

module Parser
  # CSV
  class CSV < Base
    def call
      result = []
      ::CSV.parse(file_content, col_sep: ';') do |row|
        unless headers
          self.headers = row
          next
        end
        result << row.each_with_index.map do |value, index|
          value_by_type(headers[index], value)
        end
      end
      result
    end
  end
end
