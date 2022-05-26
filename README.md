# bitrunner

A Bitmap Editor exercise written in Ruby.

## Exercise

Write a program that simulates a basic interactive bitmap editor.
A bitmap is represented as with a M x N matrix of pixels with each element representing a colour.

## Program input

The input consists of the user inputting a command per line,
where a command is represented by a single capital letter at the beginning of each line.

- Parameters of the command are separated by white spaces and they follow the command character.
- Pixel coordinates are a pair of integers:
  - a column number between 1 and 250,
  - and a row number between 1 and 250.
- Bitmaps starts at coordinates 1,1.
- Colours are specified by capital letters.


## Example

The application should behave like a [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop),
you start the application by writing in the terminal `./bitrunner`.

When implementing this program focus on quality and best practices.
Make sure the program works with odd input and doesn't crash.

In the example below, `>` represents each line of the program command line.

```
$ ./bitrunner

> I 5 6
> L 2 3 A
> S
O O O O O
O O O O O
O O O O O
O O A O O
O O O O O
O O O O O

> F 3 3 J
> V 2 3 4 W
> H 3 4 2 Z
> S
J J J J J
J J J J J
J J J Z Z
J J W J J
J J W J J
J J J J J
> X
```


## How to run?

You will need at least ruby version 2.7.2 to run this program.

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

| Command     | Description|
|:-----------:|:----------:|
| I M N       | Create a new M x N bitmap with all pixels coloured white (O)|
| C           | Clears the bitmap, setting all pixels to white (O) |
| L X Y C     | Colours the pixel (X,Y) with colour C. |
| V X Y1 Y2 C | Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive). |
| H X1 X2 Y C | Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).|
| F X Y C     | Fill the region R with the colour C. R is defined as: Pixel (X,Y) belongs to R. Any other pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs to this region. |
| S           | Show the contents of the current image |
| X           | Terminate the session |
| ?           | Shows in program help |
