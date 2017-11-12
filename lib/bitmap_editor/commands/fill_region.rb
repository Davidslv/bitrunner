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

          puts "west"
          _fill(x - 1, y, c) # west
          puts "east"
          _fill(x + 1, y, c) # east

          puts "south"
          puts "x: #{x+1}, y: #{y}, c: #{c}"
          binding.pry
          _fill(x, y + 1, c) # south
          puts "north"
          _fill(x, y - 1, c) # north
        end
      end
    end
  end
end
