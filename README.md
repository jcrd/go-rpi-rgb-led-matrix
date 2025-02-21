# go-rpi-rgb-led-matrix [![GoDoc](https://godoc.org/github.com/mcuadros/go-rpi-rgb-led-matrix?status.svg)](https://godoc.org/github.com/mcuadros/go-rpi-rgb-led-matrix) [![Build Status](https://travis-ci.org/mcuadros/go-rpi-rgb-led-matrix.svg?branch=master)](https://travis-ci.org/mcuadros/go-rpi-rgb-led-matrix) 
<img width="250" src="https://cloud.githubusercontent.com/assets/1573114/20248154/c17c1f2e-a9dd-11e6-805b-bf7d8ee73121.gif" align="right" />

Go binding for [`rpi-rgb-led-matrix`](https://github.com/hzeller/rpi-rgb-led-matrix) an excellent C++ library to control [RGB LED displays](https://learn.adafruit.com/32x16-32x32-rgb-led-matrix/overview) with Raspberry Pi GPIO.

This library includes the basic bindings to control de LED Matrix directly and also a convenient [ToolKit](https://godoc.org/github.com/mcuadros/go-rpi-rgb-led-matrix#ToolKit) with more high level functions.

The [`Canvas`](https://godoc.org/github.com/mcuadros/go-rpi-rgb-led-matrix#Canvas) struct implements the [`image.Image`](https://golang.org/pkg/image/#Image) interface from the Go standard library. This makes the interaction with the matrix simple as work with a normal image in Go, allowing the usage of any Go library build around the `image.Image` interface.

To learn about the configuration and the wiring go to the [original library](https://github.com/hzeller/rpi-rgb-led-matrix), is highly detailed and well explained. 

Installation
------------

This library is meant to be included in your project as a vendored dependency.

The `go mod vendor` command will not work for this purpose as it *excludes* the
`lib/` directory containing the required C++ library.

It is recommended to use a tool like [vend](https://github.com/nomad-software/vend) instead.

The C++ library must be built with:
```sh
cd vendor/github.com/jcrd/go-rpi-rgb-led-matrix/
make
```

Examples
--------

Setting all the pixels to white:

```go
// create a new Matrix instance with the DefaultConfig
m, _ := rgbmatrix.NewRGBLedMatrix(&rgbmatrix.DefaultConfig)

// create the Canvas, implements the image.Image interface
c := rgbmatrix.NewCanvas(m)
defer c.Close() // don't forgot close the Matrix, if not your leds will remain on
 
// using the standard draw.Draw function we copy a white image onto the Canvas
draw.Draw(c, c.Bounds(), &image.Uniform{color.White}, image.ZP, draw.Src)

// don't forget call Render to display the new led status
c.Render()
``` 

Playing a GIF into your matrix during 30 seconds:

```go
// create a new Matrix instance with the DefaultConfig
m, _ := rgbmatrix.NewRGBLedMatrix(&rgbmatrix.DefaultConfig)

// create a ToolKit instance
tk := rgbmatrix.NewToolKit(m)
defer tk.Close() // don't forgot close the Matrix, if not your leds will remain on

// open the gif file for reading
file, _ := os.Open("mario.gif")

// play of the gif using the io.Reader
close, _ := tk.PlayGIF(f)
fatal(err)

// we wait 30 seconds and then we stop the playing gif sending a True to the returned chan
time.Sleep(time.Second * 30)
close <- true
```

The image of the header was recorded using this few lines, the running _Mario_ gif, and three 32x64 pannels. 
<img src="https://cloud.githubusercontent.com/assets/1573114/20248173/2e2f97ae-a9de-11e6-95e6-e0548199501d.gif" align="right" width="100" />


License
-------

MIT, see [LICENSE](LICENSE)
