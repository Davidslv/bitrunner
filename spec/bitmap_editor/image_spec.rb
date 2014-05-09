require 'spec_helper'
require 'bitmap_editor/image'

module BitmapEditor
  describe Image do
    subject { described_class }
    let(:image) { subject.new(4, 4) }

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
    end

    describe "#show" do
      subject { described_class.new(5, 5) }

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

    describe "#fill" do
      # Fills the region R with the colour C. R is defined as: Pixel (X,Y) belongs to R.
      # Any other pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs to this region.

      context 'when there is a "blank" image' do

        it 'fills the entire image with color E' do
          # INITIAL     # FILL
          #   1 2 3 4   #   1 2 3 4
          # 1 O O O O   # 1 E E E E
          # 2 O O O O   # 2 E E E E
          # 3 O O O O   # 3 E E E E
          # 4 O O O O   # 4 E E E E

          image.fill(2, 3, 'E')
          image.show.should eql("EEEE\nEEEE\nEEEE\nEEEE")
        end
      end

      context 'when there is already one pixel filled' do
        # INITIAL     # FILL
        #   1 2 3 4   #   1 2 3 4
        # 1 O O O O   # 1 E E E E
        # 2 O A O O   # 2 E A E E
        # 3 O O O O   # 3 E E E E
        # 4 O O O O   # 4 E E E E

        before do
          image.colour(2, 2, 'A')
        end

        it 'does not fill it with color E' do
          image.fill(4, 4, 'E')
          image.show.should eql("EEEE\nEAEE\nEEEE\nEEEE")
        end
      end

    end
  end
end
