
reset bytes

org $0E8000








print "Bank E: inserted ", bytes, "/32768 bytes"

padbyte $00
pad $0EFFFF
