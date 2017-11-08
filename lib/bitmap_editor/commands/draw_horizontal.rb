module BitmapEditor
  module Commands
    class DrawHorizontal
      def initialize(bitmap, x1, x2, y, c)
        @bitmap = bitmap
        @x1, @x2, @y, @c = x1, x2, y, c
      end

      def perform
        (x1..x2).each do |x|
          @bitmap.set(x, y, c)
        end

        @bitmap
      end

      private
      attr_reader :bitmap, :x1, :x2, :y, :c
    end
  end
end
