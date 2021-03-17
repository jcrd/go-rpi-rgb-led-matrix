LIBDIR = lib/rpi-rgb-led-matrix/lib
LIB = $(LIBDIR)/librgbmatrix.so.1

all: $(LIB)
	go install -v ./...

$(LIB):
	$(MAKE) -C $(LIBDIR)

clean:
	$(MAKE) -C $(LIBDIR) clean

.PHONY: all clean
