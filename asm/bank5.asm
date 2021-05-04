
reset bytes

org $058000








print "Bank 5: inserted ", bytes, "/32768 bytes"

padbyte $00
pad $05FFFF
