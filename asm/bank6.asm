
reset bytes

org $068000








print "Bank 6: inserted ", bytes, "/32768 bytes"

padbyte $00
pad $06FFFF
