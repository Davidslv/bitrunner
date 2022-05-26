require './lib/bitmap_editor/bitmap'
require './lib/bitmap_editor/validators/base'
require './lib/bitmap_editor/validators/coordinates_validator'

module BitmapEditor
  module Validators
    RSpec.describe CoordinatesValidator do
      let(:bitmap) { Bitmap.new(3, 4) }

      describe '#valid?' do
        context 'when coordinates are out of the bitmap boundaries' do
          it 'returns false for coordinate next to left side' do
            validator = CoordinatesValidator.new(bitmap, -1, 0)

            expect(validator.valid?).to be false
          end

          it 'returns false for coordiate over the top' do
            validator = CoordinatesValidator.new(bitmap, 0, -1)

            expect(validator.valid?).to be false
          end

          it 'returns false for coordinate next to right side' do
            validator = CoordinatesValidator.new(bitmap, 3, 1)

            expect(validator.valid?).to be false
          end

          it 'returns false for coordinate under the bottom' do
            validator = CoordinatesValidator.new(bitmap, 1, 4)

            expect(validator.valid?).to be false
          end
        end

        context 'when coordinates are within the bitmap boundaries' do
          it 'returns true for top-left' do
            validator = CoordinatesValidator.new(bitmap, 0, 0)

            expect(validator.valid?).to be true
          end

          it 'returns true for top-right' do
            validator = CoordinatesValidator.new(bitmap, 2, 0)

            expect(validator.valid?).to be true
          end

          it 'returns true for bottom-right' do
            validator = CoordinatesValidator.new(bitmap, 2, 3)

            expect(validator.valid?).to be true
          end

          it 'returns true for bottom-left' do
            validator = CoordinatesValidator.new(bitmap, 0, 3)

            expect(validator.valid?).to be true
          end
        end
      end
    end
  end
end
