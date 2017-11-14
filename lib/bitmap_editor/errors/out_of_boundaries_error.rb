module BitmapEditor
  module Errors
    class OutOfBoundariesError < StandardError
      def initialize(bitmap, x, y)
        super(
          %Q{
            Coordinates X: #{x} and Y: #{y} are out of the bitmap boundaries,
            coordinate X should be between 0 and #{bitmap.width}
            coordinate Y should be between 0 and #{bitmap.height}
          }
        )
      end
    end
  end
end
