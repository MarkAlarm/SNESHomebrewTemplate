
reset bytes

org $0C8000

incsrc "spc_engine.asm"

InitSPC700:
	PHP
	PHB
	PHK
	PLB

	REP #$30
	
	LDA #$BBAA
.init
	CMP !APUIO0
	BNE .start
	
	LDA #!SPCEngineStart
	STA !APUIO2
	
	LDA #$01CC
	STA !APUIO0
	
	SEP #$20
	
.start
	CMP !APUIO0
	BNE .start
	
	LDX #$0000
	LDY #!SPCEngineSize-1

.next
	LDA SPCEngine,x
	STA !APUIO1
	TXA
	STA !APUIO0
	
.wait
	CMP !APUIO0
	BNE .wait
	
	INX
	DEY
	BPL .next
	
	REP #$20
	LDA #!SPCEngineStart
	STA !APUIO2
	
	SEP #$20
	LDA #$00
	STA !APUIO1
	
	LDA !APUIO0
	ADC #$02
	STA !APUIO0

	PLB
	PLP
	RTL

print "Bank C: inserted ", bytes, "/32768 bytes"

padbyte $00
pad $0CFFFF
