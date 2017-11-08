require 'spec_helper'
require './lib/bitmap_editor/bitmap.rb'

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
  end
end
