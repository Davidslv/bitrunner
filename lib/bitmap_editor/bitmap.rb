module BitmapEditor
  class Bitmap
    MIN_DIMENSION       = 0
    MAX_DIMENSION       = 250
    DEFAULT_PIXEL_COLOR = 'O'

    attr_reader :pixels

    def initialize(width, height)
      validate_dimmensions(@width, @height)
      @width  = width
      @height = height
      init(width, height)
    end

    def show
      pixels.map(&:join).join("\n")
    end

    def clear
      init(width, height)
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

    def init(width, height)
      Array.new(height) do
        Array.new(width) { DEFAULT_PIXEL_COLOR }
      end
    end

    def validate_dimmensions(width, height)
      if ( (MIN_DIMENSION < width && width > MAX_DIMENSION) ||
        (MIN_DIMENSION < height && height > MAX_DIMENSION) )
        raise 'Your bitmap image should not be smaller than 0 neither bigger than 250'
      end
    end
  end
end
