# frozen_string_literal: true

module BitmapEditor
  module Commands
    class DrawVertical
      def initialize(bitmap, x, y1, y2, c)
        @bitmap = bitmap
        @x = x
        @y1 = y1
        @y2 = y2
        @c = c
      end

      def perform
        (y1..y2).each do |y|
          @bitmap.set(x, y, c)
        end

        @bitmap
      end

      private

      attr_reader :bitmap, :x, :y1, :y2, :c
    end
  end
end
