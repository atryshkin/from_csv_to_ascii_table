require_relative 'base.rb'

module Printer
  # IO
  class IO < Base
    def call
      print Table.new(data).call
    end

    private

    attr_accessor :width

    # Table row
    class Table
      attr_accessor :rows, :width, :columns_width

      def initialize(data)
        @width = 0
        @columns_width = []
        @rows = data.map do |row_data|
          Row.new(row_data, self)
        end
      end

      def call
        buffer = row_delimiter
        rows.each do |row|
          buffer << row.call
        end
        buffer
      end

      def row_delimiter
        "+#{'-' * width}+\n"
      end
    end

    # Table row
    class Row
      attr_accessor :table, :columns, :height

      def initialize(row, table)
        @table = table
        width = 0
        @height = 1
        @columns = row.each_with_index.map do |col, index|
          column = Column.new(col)
          if !columns_width[index] || columns_width[index] < column.width
            columns_width[index] = column.width
          end
          width += column.width
          @height = column.height if @height < column.height
          column
        end

        width = width + columns_width.length - 1

        table.width = width if table.width < width
      end

      def call
        buffer = ''
        height.times do |row_index|
          buffer << '|'
          columns.each_with_index do |column, index|
            buffer << column.call(column_width(index), row_index)
          end
          buffer << "\n"
        end
        buffer << table.row_delimiter
        buffer
      end

      private

      def column_width(index)
        columns_width[index]
      end

      def columns_width
        table.columns_width
      end
    end

    # Table column
    class Column
      attr_accessor :value, :width, :height

      def initialize(value)
        @value = value

        @width = width_by_type(value)
        @height = height_by_type(value)
      end

      def call(width, index = 0)
        print_by_type(width, index).concat('|')
      end

      private

      def print_by_type(width, index)
        case value
        when Integer, Float
          spaces = width - (index.zero? ? value.to_s.length : 0)
          "#{' ' * spaces}#{index.zero? ? value.to_s : ''}"
        when Array
          spaces = width - value[index].length
          "#{value[index]}#{' ' * spaces}"
        end
      end

      def width_by_type(value)
        case value
        when Integer, Float
          value.to_s.length
        when Array
          value.max_by(&:length).length
        end
      end

      def height_by_type(value)
        case value
        when Integer, Float
          1
        when Array
          value.length
        end
      end
    end
  end
end
