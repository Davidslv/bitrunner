require 'spec_helper'
require './lib/bitmap_editor/bitmap'

module BitmapEditor
  RSpec.describe Bitmap do
    let(:bitmap) { Bitmap.new(3, 4) }

    describe '#get' do
      it 'should return the colour of a given coordinate' do
        expect(bitmap.get(2, 2)).to eql 'O'
      end
    end

    describe '#set' do
      it 'should set a coordinate with a given colour' do
        bitmap.set(1, 1, 'A')

        expect(bitmap.get(1, 1)).to eql 'A'
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

    describe '#valid_coordinates?' do
      context 'when coordinate is out of bounds' do
        it 'returns false for coordinate next to left side' do
          expect(
            bitmap.valid_coordinates?(-1, 0)
          ).to be false
        end

        it 'returns false for coordiate over the top' do
          expect(
            bitmap.valid_coordinates?(0, -1)
          ).to be false
        end

        it 'returns false for coordinate next to right side' do
          expect(
            bitmap.valid_coordinates?(3, 1)
          ).to be false
        end

        it 'returns false for coordinate under the bottom' do
          expect(
            bitmap.valid_coordinates?(1, 4)
          ).to be false
        end
      end

      context 'when coordinate is within bounds' do
        it 'returns true for top-left' do
          expect(
            bitmap.valid_coordinates?(0, 0)
          ).to be true
        end

        it 'returns true for top-right' do
          expect(

            bitmap.valid_coordinates?(2, 0)
          ).to be true
        end

        it 'returns true for bottom-right' do
          expect(
            bitmap.valid_coordinates?(2, 3)
          ).to be true
        end

        it 'returns true for bottom-left' do
          expect(
            bitmap.valid_coordinates?(0, 3)
          ).to be true
        end
      end
    end
  end
end
