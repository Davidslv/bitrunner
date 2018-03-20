require 'spec_helper'
require './lib/bitmap_editor/validators/base'
require './lib/bitmap_editor/validators/coordinates_validator'
require './lib/bitmap_editor/errors/out_of_boundaries_error'
require './lib/bitmap_editor/bitmap'

module BitmapEditor
  RSpec.describe Bitmap do
    let(:bitmap) { Bitmap.new(3, 4) }

    describe '#get' do
      context 'when within bitmap boundaries' do
        it 'returns the colour of a given coordinate' do
          expect(bitmap.get(2, 2)).to eql 'O'
        end
      end

      context 'when outside bitmap boundaries' do
        it 'raises an OutOfBoundariesError error' do
          expected_message = %Q{
            Coordinates X: -1 and Y: -1 are out of the bitmap boundaries,
            coordinate X should be between 0 and 3
            coordinate Y should be between 0 and 4
          }

          expect {
            bitmap.set(-1, -1, 'A')
          }.to raise_error(Errors::OutOfBoundariesError, expected_message)
        end
      end
    end

    describe '#set' do
      context 'when within bitmap boundaries' do
        it 'sets a coordinate with a given colour' do
          bitmap.set(1, 1, 'A')

          expect(bitmap.get(1, 1)).to eql 'A'
        end
      end

      context 'when outside bitmap boundaries' do
        it 'raises an OutOfBoundariesError error' do
          expected_message = %Q{
            Coordinates X: -1 and Y: -1 are out of the bitmap boundaries,
            coordinate X should be between 0 and 3
            coordinate Y should be between 0 and 4
          }

          expect {
            bitmap.set(-1, -1, 'A')
          }.to raise_error(Errors::OutOfBoundariesError, expected_message)
        end
      end
    end

    describe '#clear!' do
      it 'resets the bitmap to have default colour' do
        bitmap.set(1, 2, 'B')

        expect(bitmap.get(1, 2)).to eql 'B'
        bitmap.clear!

        expect(bitmap.get(1, 2)).to eql 'O'
      end
    end
  end
end
