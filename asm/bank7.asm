
reset bytes

org $078000








print "Bank 7: inserted ", bytes, "/32768 bytes"

padbyte $00
pad $07FFFF
