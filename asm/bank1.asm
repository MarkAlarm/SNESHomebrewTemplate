
reset bytes

org $018000

GameMode00:
	LDA #$03
	STA !OBSEL
	
	LDA #$09
	STA !BGMODE
	
	LDA #$41
	STA !BG1SC
	LDA #$49
	STA !BG2SC
	LDA #$51
	STA !BG3SC
	STZ !BG4SC
	
	STZ !BG12NBA
	LDA #$03
	STA !BG34NBA
	
	LDA #$1F
	STA !TM
	STA !TS
	
	%vram_write(font>>16, font, $3000, $0800, 0)
	
	STZ $2121
	STZ $2122
	STZ $2122
	LDA #$01
	STA $2122
	STA $2122
	INC
	STA $2122
	STA $2122
	INC
	STA $2122
	STA $2122

	LDA #$0F
	STA !INIDISP
	
	INC !gamemode
	
	RTL
	
GameMode01:
	LDA !frame_counter+1
	AND #$F0
	LSR #4
	STA $7E3000
	LDA !frame_counter+1
	AND #$0F
	STA $7E3002
	LDA !frame_counter
	AND #$F0
	LSR #4
	STA $7E3004
	LDA !frame_counter
	AND #$0F
	STA $7E3006
	
	LDA #$00
	STA $7E3001
	STA $7E3003
	STA $7E3005
	STA $7E3007
	
	LDA !P1_byetudlr_held
	AND #$03
	BEQ +
	CMP #$01
	BEQ .r
	CMP #$02
	BEQ .l
	BRA +
	
	.r
	REP #$20
	INC !BG3HOFS_mirror
	INC !BG3HOFS_mirror
	SEP #$20
	BRA +
	
	.l
	REP #$20
	DEC !BG3HOFS_mirror
	DEC !BG3HOFS_mirror
	SEP #$20
	
	+
	LDA !P1_byetudlr_held
	AND #$0C
	BEQ +
	CMP #$04
	BEQ .d
	CMP #$08
	BEQ .u
	BRA +
	
	.d
	REP #$20
	INC !BG3VOFS_mirror
	INC !BG3VOFS_mirror
	SEP #$20
	BRA +
	
	.u
	REP #$20
	DEC !BG3VOFS_mirror
	DEC !BG3VOFS_mirror
	SEP #$20
	
	+
	RTL
	
GameMode02:
GameMode03:
GameMode04:
GameMode05:
GameMode06:
GameMode07:
GameMode08:
GameMode09:
GameMode0A:
GameMode0B:
GameMode0C:
GameMode0D:
GameMode0E:
GameMode0F:
	RTL
	
FixedByteFC:
	db $FC

print "Bank 1: inserted ", bytes, "/32768 bytes"

padbyte $00
pad $01FFFF
