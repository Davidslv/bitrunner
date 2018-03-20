module BitmapEditor
  class Bitmap
    MIN_DIMENSION       = 0
    MAX_DIMENSION       = 250
    DEFAULT_PIXEL_COLOR = 'O'.freeze

    attr_reader :width, :height

    def initialize(width, height)
      @width  = width
      @height = height
      init(width, height)
    end

    def set(x, y, c)
      bitmap[y][x] = c
    end

    def get(x, y)
      bitmap[y][x]
    end

    def clear!
      init(width, height)
    end

    def width
      bitmap[0].size
    end

    def height
      bitmap.size
    end

    def valid_coordinates?(x, y)
      validate_coordinate(x, width) &&
      validate_coordinate(y, height)
    end

    private
    attr_reader :bitmap

    def init(width, height)
      @bitmap = Array.new(height) do
        Array.new(width) { DEFAULT_PIXEL_COLOR }
      end
    end

    def validate_coordinate(position, dimension)
      position.between?(MIN_DIMENSION, dimension - 1)
    end
  end
end
