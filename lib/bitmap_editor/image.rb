module BitmapEditor

  class Image
    MAX_DIMENSION  = 250
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

  end
end
