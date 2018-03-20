require 'spec_helper'
require './lib/bitmap_editor/bitmap.rb'

module BitmapEditor
  RSpec.describe Bitmap do
    let(:bitmap) { Bitmap.new(3, 4) }

    describe '#clear' do
      it 'resets the bitmap to have default colour' do
        expect(bitmap.bitmap).to eql(bitmap.clear)
      end
    end
  end
end
