
reset bytes

org $0F8000








print "Bank F: inserted ", bytes, "/32768 bytes"

padbyte $00
pad $0FFFFF
