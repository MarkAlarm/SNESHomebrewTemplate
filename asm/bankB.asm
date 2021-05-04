
reset bytes

org $0B8000








print "Bank B: inserted ", bytes, "/32768 bytes"

padbyte $00
pad $0BFFFF
