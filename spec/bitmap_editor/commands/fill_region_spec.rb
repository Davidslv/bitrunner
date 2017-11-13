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

      context "complex bitmaps" do
        context "it should be able to replace X with Y" do
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

          it "changes the region colour except for X in coordinate 4,0" do
            subject.perform
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

        context "when the bitmap is 10x10" do
          let(:bitmap) { Bitmap.new(10, 10) }
          subject { FillRegion.new(bitmap, 7, 3, "F") }

          context "and has more than one color" do
            it "changes all A to color F" do
              build(
                bitmap,
                [
                  %w(A A O O A D A D B O),
                  %w(O O A B C A C A A C),
                  %w(C O A B A O A B O C),
                  %w(B D A C A O C A C O),
                  %w(C O D A C C A B A O),
                  %w(D D A A O A B A C A),
                  %w(B D B A A O A O B A),
                  %w(O B A C O O A B A B),
                  %w(O A O D O O B A A B),
                  %w(A O D O B O A A D B),
                ]
              )

              subject.perform
              expected = [
                %w(F F O O F D F D B O),
                %w(O O F B C F C F F C),
                %w(C O F B F O F B O C),
                %w(B D F C F O C F C O),
                %w(C O D F C C F B F O),
                %w(D D F F O F B F C F),
                %w(B D B F F O F O B F),
                %w(O B F C O O F B F B),
                %w(O F O D O O B F F B),
                %w(F O D O B O F F D B),
              ]

              assert_equal_bitmap(bitmap, expected)
            end

            it "changes all adjecent O's of the given coordinate to F" do
              build(
                bitmap,
                [
                  %w(B A A A A O B B A B),
                  %w(B O O O A A O B A O),
                  %w(O B B A O B B B B B),
                  %w(O A B O B B A O O O),
                  %w(A A B A O O O B O O),
                  %w(B B O O A B A A B A),
                  %w(B O O O O B A O A B),
                  %w(A A A O B O B B O A),
                  %w(O B A O A O A B A B),
                  %w(B O O A B O B B A A),
                ]
              )

              subject.perform
              expected = [
                %w(B A A A A O B B A B),
                %w(B F F F A A O B A O), # not adjacent
                %w(F B B A F B B B B B),
                %w(F A B F B B A F F F),
                %w(A A B A F F F B F F),
                %w(B B F F A B A A B A),
                %w(B F F F F B A O A B), # not adjacent
                %w(A A A F B F B B O A), # not adjacent
                %w(F B A F A F A B A B),
                %w(B F F A B F B B A A),
              ]

              assert_equal_bitmap(bitmap, expected)
            end
          end
        end

        context 'when the bitmap is 30x10' do
          let(:bitmap) { Bitmap.new(30, 10) }
          subject { FillRegion.new(bitmap, 0, 5, "F") }

          it "changes all adjecent O's of the given coordinate to F" do
            build(
              bitmap,
              [
                %w(B B A B O A A O O B A O O O A O A O O O A O O B O A O O O O),
                %w(O B B B B B O B O B O A O O O O A O O O A B O A O A O O O O),
                %w(B O A O B A A B B B O A O O A O A O O O A O O B O A O O O O),
                %w(B B O O B A O O B O O A O O B O A O O O A O B A O B O O O O),
                %w(A O O A A O B B O B O A O O A O A O O O O B O A O A O O O O),
                %w(O O O B O O A O A O B O O O B O A O O O A O O A O A B B O O),
                %w(A A O O O O A B B O O A O O A O O O O O A O O A O A B O B O),
                %w(A A A O O B B A A O O A O O B O A O O O A O O B O O B B O B),
                %w(O O A A A O O O B O O O O O A O A O O O A O O A O A O B B O),
                %w(O A B B A A B B A O O A O O A O A O O O A O O O B A O O O O),
              ]
            )

            expected = [
              %w(B B A B O A A O O B A F F F A F A F F F A F F B F A F F F F),
              %w(F B B B B B O B O B F A F F F F A F F F A B F A F A F F F F),
              %w(B F A F B A A B B B F A F F A F A F F F A F F B F A F F F F),
              %w(B B F F B A F F B F F A F F B F A F F F A F B A F B F F F F),
              %w(A F F A A F B B F B F A F F A F A F F F F B F A F A F F F F),
              %w(F F F B F F A F A F B F F F B F A F F F A F F A F A B B F F),
              %w(A A F F F F A B B F F A F F A F F F F F A F F A F A B F B F),
              %w(A A A F F B B A A F F A F F B F A F F F A F F B F F B B F B),
              %w(O O A A A F F F B F F F F F A F A F F F A F F A F A F B B F),
              %w(O A B B A A B B A F F A F F A F A F F F A F F F B A F F F F),
            ]

            subject.perform
            assert_equal_bitmap(bitmap, expected)
          end
        end
      end
    end
  end
end
