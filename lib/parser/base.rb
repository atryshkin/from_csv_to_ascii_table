# frozen_string_literal: true

module Parser
  # Base class
  class Base
    def initialize(file_content)
      @file_content = file_content
    end

    def call
      raise NotImplementedError
    end

    def value_by_type(type, value)
      case type
      when 'int'
        value.to_i
      when 'string'
        value.split(' ')
      when 'money'
        value.to_f
      end
    end

    private

    attr_accessor :file_content, :headers, :max_values
  end
end
