
reset bytes

org $038000








print "Bank 3: inserted ", bytes, "/32768 bytes"

padbyte $00
pad $03FFFF
