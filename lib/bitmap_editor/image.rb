module BitmapEditor

  class Image
    MAX_DIMENSION       = 250
    DEFAULT_PIXEL_COLOR = 'O'

    attr_reader :pixels

    def initialize(m, n)
      validate_dimmensions(m, n)

      @width  = m
      @height = n
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

    private

    def validate_dimmensions(m, n)
      if ( (0 < m && m > MAX_DIMENSION) || (0 < n && n > MAX_DIMENSION) )
        raise 'Your bitmap image should not be smaller than 0 neither bigger than 250'
      end
    end
  end
end
