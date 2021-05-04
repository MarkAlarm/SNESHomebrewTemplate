
reset bytes

org $028000

ProcessSpriteCode:
	PHB
	PHK
	PLB
	
	; insert shid
	
	PLB
	RTL





;#######################;
;# Insert Name Routine #;
;#                     #;
;# Input    - None     #;
;#                     #;
;# Output   - None     #;
;#                     #;
;# Destroys - None     #;
;#                     #;
;#######################;







print "Bank 2: inserted ", bytes, "/32768 bytes"

padbyte $00
pad $02FFFF
