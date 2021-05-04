
reset bytes

org $008000
	SEI
	CLC
	XCE
	
	REP #$30
	LDA #$0000
	TCD
	LDA #$1FFF
	TCS
	SEP #$30
	
	; can probably set DP to $2100 so this is faster
	
	LDA #$8F								; \ initialize SNES registers
	STA !INIDISP							; |
	
	STZ !OBSEL
	STZ !OAMADDL
	STZ !OAMADDH
	STZ !OAMDATA
	STZ !BGMODE
	STZ !MOSAIC
	STZ !BG1SC
	STZ !BG2SC
	STZ !BG3SC
	STZ !BG4SC
	STZ !BG12NBA
	STZ !BG34NBA
	
	STZ !BG1HOFS
	STZ !BG1HOFS
	STZ !BG2HOFS
	STZ !BG2HOFS
	STZ !BG3HOFS
	STZ !BG3HOFS
	STZ !BG4HOFS
	STZ !BG4HOFS
	
	LDA #$80
	STA !VMAIN
	STZ !VMADDL
	STZ !VMADDH
	STZ !VMDATAL
	STZ !VMDATAH
	
	STZ !M7SEL
	STZ !M7SEL
	STZ !M7A
	STZ !M7A
	STZ !M7B
	STZ !M7B
	STZ !M7C
	STZ !M7C
	STZ !M7D
	STZ !M7D
	STZ !M7X
	STZ !M7X
	STZ !M7Y
	STZ !M7Y
	
	STZ !CGADD
	
	STZ !CGDATA
	STZ !CGDATA
	
	STZ !W12SEL
	STZ !W34SEL
	STZ !WOBJSEL
	STZ !WH0
	STZ !WH1
	STZ !WH2
	STZ !WH3
	STZ !WBGLOG
	STZ !WOBJLOG
	STZ !TM
	STZ !TS
	STZ !TMW
	STZ !TSW
	STZ !CGWSEL
	STZ !CGADSUB
	STZ !COLDATA
	STZ !SETINI
	
	STZ !SLHV
	
	STZ !APUIO0
	STZ !APUIO1
	STZ !APUIO2
	STZ !APUIO3
	
	STZ !WMDATA
	STZ !WMADDL
	STZ !WMADDM								; |
	STZ !WMADDH								; /
	
	REP #$20
	
	LDA #$8008								; \ clear all of WRAM
	STA !DMAP0								; |
	LDA #FixedByte00
	STA !A1T0L
	LDY.b #FixedByte00>>16
	STY !A1B0
	LDA #$0000
	STA !DAS0L
	LDY #$01
	STY !MDMAEN								; |
	STY !MDMAEN								; /

	LDY #$80								; \ clear all of VRAM
	STY !VMAIN								; |
	LDA #$0000
	STA !VMADDL
	LDA #$1809
	STA !DMAP0
	LDA #FixedByte00
	STA !A1T0L
	LDY.b #FixedByte00>>16
	STY !A1B0
	LDA #$0000
	STA !DAS0L
	LDY #$01								; |
	STY !MDMAEN								; /
	
	STZ !CGADD								; \ clear all of CGRAM
	LDA #$220A								; |
	STA !DMAP0
	LDA #FixedByte00
	STA !A1T0L
	LDY.b #FixedByte00>>16
	STY !A1B0
	LDA #$0200
	STA !DAS0L
	LDY #$01								; |
	STY !MDMAEN								; /
	
	JSL InitSPC700
	
	SEP #$20
	
MainGameLoop:
	LDA #$80
	TRB !NMITIMEN

	REP #$30
	
	INC !frame_counter
	JSL ProcessGameMode
	
	SEP #$30
	
	LDA #$80
	TSB !NMITIMEN
	
	WAI
	JMP MainGameLoop
	
ProcessGameMode:
	LDA !gamemode
	ASL
	CLC
	ADC !gamemode
	TAX
	LDA GameModePointers,x
	STA !scratch_00
	LDA GameModePointers+$02,x
	STA !scratch_02
	SEP #$30
	
	JMP [!scratch_00|$0000]
	
GameModePointers:
	dl GameMode00
	dl GameMode01
	dl GameMode02
	dl GameMode03
	dl GameMode04
	dl GameMode05
	dl GameMode06
	dl GameMode07
	dl GameMode08
	dl GameMode09
	dl GameMode0A
	dl GameMode0B
	dl GameMode0C
	dl GameMode0D
	dl GameMode0E
	dl GameMode0F

COPRoutine:
BRKRoutine:
	-
	BRA -
	
UpdateHardwareRegisters:
	LDA !BG1HOFS_mirror
	STA !BG1HOFS
	LDA !BG1HOFS_mirror+1
	STA !BG1HOFS
	LDA !BG1VOFS_mirror
	STA !BG1VOFS
	LDA !BG1VOFS_mirror+1
	STA !BG1VOFS
	
	LDA !BG2HOFS_mirror
	STA !BG2HOFS
	LDA !BG2HOFS_mirror+1
	STA !BG2HOFS
	LDA !BG2VOFS_mirror
	STA !BG2VOFS
	LDA !BG2VOFS_mirror+1
	STA !BG2VOFS
	
	LDA !BG3HOFS_mirror
	STA !BG3HOFS
	LDA !BG3HOFS_mirror+1
	STA !BG3HOFS
	LDA !BG3VOFS_mirror
	STA !BG3VOFS
	LDA !BG3VOFS_mirror+1
	STA !BG3VOFS
	
	LDA !BG4HOFS_mirror
	STA !BG4HOFS
	LDA !BG4HOFS_mirror+1
	STA !BG4HOFS
	LDA !BG4VOFS_mirror
	STA !BG4VOFS
	LDA !BG4VOFS_mirror+1
	STA !BG4VOFS
	
	RTS
	
UpdateOAM:
	LDY #$1F
	LDX #$7C
	-
	LDA !OAM_size+3,x
	ASL #2
	ORA !OAM_size+2,x
	ASL #2
	ORA !OAM_size+1,x
	ASL #2
	ORA !OAM_size,x
	STA !OAM_bit_size,y
	
	DEX #4
	DEY
	BPL -
	
	STZ !OAMADDL

	REP #$20
	
	LDA #$0400
	STA !DMAP0
	LDA #!OAM_start
	STA !A1T0L
	LDY #$7E
	STY !A1B0
	LDA #$0220
	STA !DAS0L
	
	LDY #$01
	STY !MDMAEN
	
	SEP #$20
	
	RTS
	
UpdateControllers:
	LDA !P1_byetudlr_held
	STA !scratch_00
	LDA !P1_axlr0000_held
	STA !scratch_01
	
	LDY #$10
	LDA #$01
	STA !JOYSER0
	STZ !JOYSER0
	
	-
	LDA !JOYSER0
	LSR
	ROL !P1_axlr0000_held
	ROL !P1_byetudlr_held
	DEY
	BNE -
	
	LDA !scratch_00
	EOR !P1_byetudlr_held
	AND !P1_byetudlr_held
	STA !P1_byetudlr_press
	
	LDA !scratch_01
	EOR !P1_axlr0000_held
	AND !P1_axlr0000_held
	STA !P1_axlr0000_press
	
	RTS
	
UpdateTilemaps:
	%vram_write($7E, $3000, $5000, $1000, 0)
	RTS
	
NMIRoutine:
	LDA !RDNMI
	
	JSR UpdateHardwareRegisters
	JSR UpdateOAM
	JSR UpdateControllers
	JSR UpdateTilemaps
	
	RTI
	
IRQRoutine:
	LDA !TIMEUP
	RTI
	
FixedByte00:
	db $00

print "Bank 0: inserted ", bytes, "/32768 bytes"

padbyte $00
pad $00FFFF
