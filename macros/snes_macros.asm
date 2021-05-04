
macro vram_write(srcbank, srcaddr, destaddr, datasize, channel)
	PHP
	
	REP #$20
	SEP #$10
	
	LDY #$80
	STY !VMAIN
	LDA #<destaddr>
	STA !VMADDL
	
	LDA #$1801
	STA $43<channel>0
	LDA #<srcaddr>
	STA $43<channel>2
	LDY #<srcbank>
	STY $43<channel>4
	LDA #<datasize>
	STA $43<channel>5
	
	if <channel> == 0
		LDY #$01
	elseif <channel> == 1
		LDY #$02
	elseif <channel> == 2
		LDY #$04
	elseif <channel> == 3
		LDY #$08
	elseif <channel> == 4
		LDY #$10
	elseif <channel> == 5
		LDY #$20
	elseif <channel> == 6
		LDY #$40
	elseif <channel> == 7
		LDY #$80
	endif
	
	STY !MDMAEN
	
	PLP
endmacro

macro cgram_write(srcbank, srcaddr, destaddr, datasize, channel)
	PHP
	
	; bruh
	
	PLP
endmacro
