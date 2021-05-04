
reset bytes

org $048000








print "Bank 4: inserted ", bytes, "/32768 bytes"

padbyte $00
pad $04FFFF
