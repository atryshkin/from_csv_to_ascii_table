# frozen_string_literal: true

module Printer
  # Base class
  class Base
    def initialize(data)
      @data = data
    end

    def call
      raise NotImplementedError
    end

    private

    attr_accessor :data
  end
end
