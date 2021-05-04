
reset bytes

org $088000








print "Bank 8: inserted ", bytes, "/32768 bytes"

padbyte $00
pad $08FFFF
