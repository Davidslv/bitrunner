module BitmapEditor
  module Commands
    class FillRegion
      def initialize(bitmap, x, y, c, validator = Validators::CoordinatesValidator)
        @bitmap = bitmap
        @x, @y, @c = x, y, c
        @original_color = bitmap.get(x, y)
        @validator = validator
      end

      def perform
        _fill(x, y, c)
        bitmap.set(x, y, c)
      end

      private
      attr_reader :bitmap, :x, :y, :c, :original_color, :validator

      def _fill(x, y, c, visited = {})
        # Marks the visited coordinates before it validates
        # so it doesn't have to validate the same coordinate again.
        visited[x] ||= {}
        return if visited[x][y]
        visited[x][y] = true

        return unless validator.new(bitmap, x, y).valid?

        if bitmap.get(x, y) == original_color
          bitmap.set(x, y, c)

          _fill(x, y - 1, c, visited)      # north
          _fill(x, y + 1, c, visited)      # south

          _fill(x - 1, y, c, visited)      # west
          _fill(x - 1, y - 1, c, visited)  # north west
          _fill(x - 1, y + 1, c, visited)  # south west

          _fill(x + 1, y, c, visited)      # east
          _fill(x + 1, y - 1, c, visited)  # north east
          _fill(x + 1, y + 1, c, visited)  # south east
        end
      end
    end
  end
end
