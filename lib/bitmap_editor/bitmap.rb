module BitmapEditor
  class Bitmap
    MIN_DIMENSION       = 0
    MAX_DIMENSION       = 250
    DEFAULT_PIXEL_COLOR = 'O'

    attr_reader :bitmap, :width, :height

    def initialize(width, height)
      @width  = width
      @height = height
      init(width, height)
    end

    def clear
      init(width, height)
    end

    private

    def init(width, height)
      @bitmap = Array.new(height) do
        Array.new(width) { DEFAULT_PIXEL_COLOR }
      end
    end
  end
end
