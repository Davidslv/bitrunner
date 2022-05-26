# frozen_string_literal: true

module BitmapEditor
  module Validators
    class Base
      MIN_DIMENSION = 0
      MAX_DIMENSION = 250

      def initialize(bitmap, x, y)
        @bitmap = bitmap
        @x = x
        @y = y
      end

      protected

      attr_reader :bitmap, :x, :y
    end
  end
end
