# bitrunner

A Bitmap Editor exercise written in Ruby

## How to run?

You will need at least ruby version 2.2.0 to run this program.

```shell
$ bundle
$ ./bitrunner
```

## How to run the tests
```shell
$ bundle
$ bundle exec rspec
```

## Commands

| Command | Description|
|:-------:|:----------:|
| I M N | Create a new M x N bitmap with all pixels coloured white (O)|
| C | Clears the bitmap, setting all pixels to white (O) |
| L X Y C | Colours the pixel (X,Y) with colour C. |
| V X Y1 Y2 C | Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive). |
| H X1 X2 Y C | Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).|
| F X Y C | Fill the region R with the colour C. R is defined as: Pixel (X,Y) belongs to R. Any other pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs to this region. |
| W F | Scales bitmap with given factor (in percentage) |
| S | Show the contents of the current image |
| X | Terminate the session |
| ? | Shows in program help |
