
reset bytes

org $0D8000

font:
	incbin "gfx/font.bin"

print "Bank D: inserted ", bytes, "/32768 bytes"

padbyte $00
pad $0DFFFF
