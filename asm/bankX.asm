
reset bytes

org $0X8000








print "Bank X: inserted ", bytes, "/32768 bytes"

padbyte $00
pad $0XFFFF
