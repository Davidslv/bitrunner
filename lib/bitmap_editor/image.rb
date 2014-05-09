module BitmapEditor

  class Image
    MAX_DIMENSION       = 250
    DEFAULT_PIXEL_COLOR = 'O'

    attr_reader :pixels

    def initialize(m, n)
      m, n = m.to_i, n.to_i

      if ( (0 < m && m > MAX_DIMENSION) || (0 < n && n > MAX_DIMENSION) )
        raise 'Your bitmap image should not be smaller than 0 neither bigger than 250'
      end

      @pixels = Array.new

      n.times { @pixels << Array.new(m, DEFAULT_PIXEL_COLOR) }
    end

    def show
      pixels.map { |n| n.join("") }.join("\n")
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
  end
end
