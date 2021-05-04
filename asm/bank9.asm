
reset bytes

org $098000








print "Bank 9: inserted ", bytes, "/32768 bytes"

padbyte $00
pad $09FFFF
