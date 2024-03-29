# frozen_string_literal: true

module BitmapEditor
  module Validators
    class CoordinatesValidator < Base
      def valid?
        validate_coordinate(x, bitmap.width) &&
          validate_coordinate(y, bitmap.height)
      end

      private

      def validate_coordinate(position, dimension)
        position.between?(MIN_DIMENSION, dimension - 1)
      end
    end
  end
end
