
reset bytes

org $0A8000








print "Bank A: inserted ", bytes, "/32768 bytes"

padbyte $00
pad $0AFFFF
