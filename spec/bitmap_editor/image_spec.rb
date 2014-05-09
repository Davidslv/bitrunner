require 'spec_helper'
require 'bitmap_editor/image'

module BitmapEditor
  describe Image do
    subject { described_class }
    let(:image) { subject.new(4,4) }

    describe "#new" do
      context 'when image is bigger than 250x250' do
        it 'raises an error' do
          expect {
            subject.new(251, 251)
          }.to raise_error
        end
      end

      context 'when image is equal to 250x250' do
        it 'does not raises an error' do
          expect {
            subject.new(250, 250)
          }.to_not raise_error
        end

        it 'should have an image with 62500 pixels' do
          image = subject.new(250, 250)
          image.pixels.flatten.should have(62500).pixels
        end
      end

      describe "#show" do
        subject { described_class.new(5,5) }

        its(:show) { should eql("OOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOOO") }
      end

      describe "#colour" do
        it 'colours the image with A at X1 Y2' do
          #   1 2 3 4
          # 1 A O O O
          # 2 O O O O
          # 3 O O O O
          # 4 O O O O
          image.colour(1, 2, 'A')
          image.show.should eql("OOOO\nAOOO\nOOOO\nOOOO")
        end
      end

      describe "#clear" do
        it 'clears the image to default value O' do
          image.colour(2, 2, 'B')
          image.clear
          image.show.should eql("OOOO\nOOOO\nOOOO\nOOOO")
        end
      end

      describe "#vertical" do
        it 'draws vertically between Y1 and Y2 in column X' do
          #   1 2 3 4
          # 1 O O O O
          # 2 X O O O
          # 3 X O O O
          # 4 X O O O
          image.vertical(1, 2, 4, 'X')
          image.show.should eql("OOOO\nXOOO\nXOOO\nXOOO")
        end
      end

      describe "#horizontal" do
        it 'draws horizontally between X1 and X2 in row Y' do
          #   1 2 3 4
          # 1 O O O O
          # 2 O O O O
          # 3 R R R O
          # 4 O O O O
          image.horizontal(1, 3, 3, 'R')
          image.show.should eql("OOOO\nOOOO\nRRRO\nOOOO")
        end

      end
    end
  end

end
