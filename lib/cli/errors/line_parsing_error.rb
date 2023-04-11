# frozen_string_literal: true

module CLI
  module Errors
    class LineParsingError < StandardError
      def initialize(line)
        message = "Line #{line} in file could not be parsed"

        super(message)
      end
    end
  end
end
