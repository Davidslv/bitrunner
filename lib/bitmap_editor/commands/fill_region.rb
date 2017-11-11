module BitmapEditor
  module Commands
    class FillRegion
      def initialize(bitmap, x, y, c)
        @bitmap = bitmap
        @x, @y, @c = x, y, c
      end

      def perform
        _fill(x, y, c)
      end

      private
      attr_reader :bitmap, :x, :y, :c

      def _fill(x, y, c)
        return if (x < MIN_DIMENSION || x == @width)
        return if (y < MIN_DIMENSION || y == @height)
        return if (pixels[y][x] == c) || (pixels[y][x] != 'O')

        pixels[y][x] = c

        flood_fill(x - 1, y, c)
        flood_fill(x + 1, y, c)
        flood_fill(x, y + 1, c)
        flood_fill(x, y - 1, c)
      end
    end
  end
end
