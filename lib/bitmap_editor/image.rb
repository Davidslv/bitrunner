module BitmapEditor

  class Image
    MIN_DIMENSION       = 0
    MAX_DIMENSION       = 250
    DEFAULT_PIXEL_COLOR = 'O'

    attr_reader :pixels

    def initialize(m, n)
      @width  = m.to_i
      @height = n.to_i
      validate_dimmensions(@width, @height)

      @pixels = Array.new(@height) { Array.new(@width) { DEFAULT_PIXEL_COLOR } }
    end

    def show
      pixels.map(&:join).join("\n")
    end

    def clear
      pixels.map! { |n| n.map { |m| m = DEFAULT_PIXEL_COLOR } }
    end

    def colour(x, y, c)
      pixels[y.to_i - 1][x.to_i - 1] = c
    end

    def vertical(x, y1, y2, c)
      (y1..y2).each { |y| colour(x, y, c) }
    end

    def horizontal(x1, x2, y, c)
      (x1..x2).each { |x| colour(x, y, c) }
    end

    def fill(x, y, c)
      x = x.to_i - 1
      y = y.to_i - 1
      flood_fill(x, y, c)
    end

    private

    def flood_fill(x, y, c)
      return if (x < MIN_DIMENSION || x == @width)
      return if (y < MIN_DIMENSION || y == @height)
      return if (pixels[y][x] == c) || (pixels[y][x] != 'O')

      pixels[y][x] = c

      flood_fill(x - 1, y, c)
      flood_fill(x + 1, y, c)
      flood_fill(x, y + 1, c)
      flood_fill(x, y - 1, c)
    end

    def validate_dimmensions(width, height)
      if ( (MIN_DIMENSION < width && width > MAX_DIMENSION) || (MIN_DIMENSION < height && height > MAX_DIMENSION) )
        raise 'Your bitmap image should not be smaller than 0 neither bigger than 250'
      end
    end
  end
end
