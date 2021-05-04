
org $00FFC0
	;  "123456789012345678901"		; Internal ROM Name				| $FFC0
	db "My Homebrew Template "		; Internal ROM Name				| $FFC0
	db $20							; Mapping Mode					| $FFD5
	db $02							; Cartridge Type				| $FFD6
	db $09							; ROM Size						| $FFD7
	db $03							; SRAM Size						| $FFD8
	db $0E							; Region of Release				| $FFD9
	db $00							; Developer ID					| $FFDA
	db $00							; Version Number				| $FFDB
	dw $0000						; Checksum Complement			| $FFDC
	dw $0000						; Checksum						| $FFDE
	
	dw $FFFF						; Unused						| $FFE0
	dw $FFFF						; Unused						| $FFE2
	dw #COPRoutine					; Native mode COP				| $FFE4
	dw #BRKRoutine					; Native mode BRK				| $FFE6
	dw $FFFF						; Native mode Abort (unused)	| $FFE8
	dw #NMIRoutine					; Native mode NMI				| $FFEA
	dw $FFFF						; Unused						| $FFEC
	dw #IRQRoutine					; Native mode IRQ				| $FFEE
	
	dw $FFFF						; Unused						| $FFF0
	dw $FFFF						; Unused						| $FFF2
	dw #COPRoutine					; Emulation mode COP			| $FFF4
	dw $FFFF						; Unused						| $FFF6
	dw $FFFF						; Emulation mode Abort (unused)	| $FFF8
	dw #NMIRoutine					; Emulation mode NMI			| $FFFA
	dw $8000						; Emulation mode Reset			| $FFFC
	dw $FFFF						; Emulation mode IRQ/BRK		| $FFFE
