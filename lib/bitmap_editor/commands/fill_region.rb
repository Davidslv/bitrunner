module BitmapEditor
  module Commands
    class FillRegion
      def initialize(bitmap, x, y, c)
        @bitmap = bitmap
        @x, @y, @c = x, y, c
        @original_color = bitmap.get(x, y)
      end

      def perform
        _fill(x, y, c)
        bitmap.set(x, y, c)
      end

      private
      attr_reader :bitmap, :x, :y, :c, :original_color

      def _fill(x, y, c)
        return unless bitmap.valid_coordinates?(x, y)

        if bitmap.get(x, y) == original_color
          bitmap.set(x, y, c)

          _fill(x - 1, y, c) # west
          _fill(x + 1, y, c) # east
          _fill(x, y + 1, c) # south
          _fill(x, y - 1, c) # north
        end
      end
    end
  end
end
