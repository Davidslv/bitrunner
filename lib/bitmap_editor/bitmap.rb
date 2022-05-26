# frozen_string_literal: true

module BitmapEditor
  class Bitmap
    DEFAULT_PIXEL_COLOR = 'O'

    def initialize(width, height, validator = Validators::CoordinatesValidator)
      @width  = Integer(width)
      @height = Integer(height)
      @validator = validator
      init(@width, @height)
    end

    def set(x, y, c)
      validate_input!(x, y)

      bitmap[y][x] = c
    end

    def get(x, y)
      validate_input!(x, y)

      bitmap[y][x]
    end

    def to_s
      bitmap.map { |row| row.join(' ') }.join("\n")
    end

    def clear!
      init(@width, @height)
    end

    def width
      bitmap[0].size
    end

    def height
      bitmap.size
    end

    private

    attr_reader :bitmap, :validator

    def init(width, height)
      @bitmap = Array.new(height) do
        Array.new(width) { DEFAULT_PIXEL_COLOR }
      end
    end

    def validate_input!(x, y)
      raise Errors::OutOfBoundariesError.new(self, x, y) unless validator.new(self, x, y).valid?
    end
  end
end
