require 'spec_helper'
require './lib/bitmap_editor/bitmap'
require './lib/bitmap_editor/commands/fill_region'

module BitmapEditor
  module Commands
    RSpec.describe FillRegion do
      context 'when it is a bitmap with 3 x 4 dimensions' do
        let(:bitmap) { Bitmap.new(3, 4) }

        before do
          build(
            bitmap,
            [
              %w(A A O),
              %w(A B B),
              %w(A B O),
              %w(A O O),
            ]
          )
        end

        context 'and the chosen color is at the most top-left corner' do
          let(:subject) { described_class.new(bitmap, 0, 0, 'F') }

          it 'colors the region where color "A" is with color "F"' do
            expected = [
              %w(F F O),
              %w(F B B),
              %w(F B O),
              %w(F O O),
            ]

            subject.perform
            assert_equal_bitmap(bitmap, expected)
          end
        end

        context 'and the chosen color is at the most bottom-right corner' do
          let(:subject) { described_class.new(bitmap, 2, 3, 'F') }

          it 'colors the region where color "O" is with color "F"' do
            expected = [
              %w(A A O),
              %w(A B B),
              %w(A B F),
              %w(A F F),
            ]

            subject.perform
            assert_equal_bitmap(bitmap, expected)
          end
        end

        context 'and the chosen color in the middle of third row' do
          let(:subject) { described_class.new(bitmap, 1, 1, 'F') }

          it 'colors the region where color "B" is with color "F"' do
            expected = [
              %w(A A O),
              %w(A F F),
              %w(A F O),
              %w(A O O),
            ]

            subject.perform
            assert_equal_bitmap(bitmap, expected)
          end
        end
      end

      context "when is a complex bitmap" do
        let(:bitmap) { Bitmap.new(6, 5) }
        subject { FillRegion.new(bitmap, 3, 2, "Y") }

        before do
          build(
            bitmap,
            [
              %w(X X O O X O),
              %w(X X O O O O),
              %w(O O X X O O),
              %w(X X O O X X),
              %w(X X A A O O),
            ]
          )
        end

        it "changes the region colour" do
          subject.perform
          binding.pry
          expected = [
            %w(Y Y O O X O),
            %w(Y Y O O O O),
            %w(O O Y Y O O),
            %w(Y Y O O Y Y),
            %w(Y Y A A O O),
          ]

          assert_equal_bitmap(bitmap, expected)
        end
      end
    end
  end
end
