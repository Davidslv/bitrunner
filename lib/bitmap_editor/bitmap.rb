module BitmapEditor
  class Bitmap
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

    private
    attr_reader :bitmap

    def init(width, height)
      @bitmap = Array.new(height) do
        Array.new(width) { DEFAULT_PIXEL_COLOR }
      end
    end
  end
end
