require 'spec_helper'
require './lib/bitmap_editor/bitmap'
require './lib/bitmap_editor/commands/draw_vertical'

module BitmapEditor
  module Commands
    RSpec.describe DrawVertical do
      def assert_equal_bitmap(bitmap, expected)
        expected.each_with_index do |row, y|
          row.each_with_index do |_column, x|
            expect(
              bitmap.get(x, y)
            ).to eql expected[y][x]
          end
        end
      end

      context 'when receives coordinates' do
        let(:bitmap) { Bitmap.new(3, 4) }
        let(:subject) { described_class.new(bitmap, 1, 0, 2, 'A') }

        #   0 1 2
        # 0 O A O
        # 1 O A O
        # 2 O A O
        # 3 O O O

        it 'should color the coordinates between given x coordinates' do
          expected = [
            %w(O A O),
            %w(O A O),
            %w(O A O),
            %w(O O O),
          ]

          subject.perform
          assert_equal_bitmap(bitmap, expected)
        end
      end

      context 'when receives coordinates' do
        let(:bitmap) { Bitmap.new(6, 4) }
        let(:subject) { described_class }

        #   0 1 2 3 4 5
        # 0 A O O C O O
        # 1 A O O C O D
        # 2 A O B O O D
        # 3 O O B O O O

        it 'should color the coordinates between given x xx coordinates' do
          expected = [
            %w(A O O C O O),
            %w(A O O C O D),
            %w(A O B O O D),
            %w(O O B O O O),
          ]

          subject.new(bitmap, 0, 0, 2, 'A').perform
          subject.new(bitmap, 2, 2, 3, 'B').perform
          subject.new(bitmap, 3, 0, 1, 'C').perform
          subject.new(bitmap, 5, 1, 2, 'D').perform

          assert_equal_bitmap(bitmap, expected)
        end
      end
    end
  end
end
