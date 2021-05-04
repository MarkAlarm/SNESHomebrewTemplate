
arch spc700

!SPCEngineStart = $0400

SPCEngine:
	CLRP
	
	MOV x, #$FF														; \ set stack pointer to $01FF
	MOV sp, x														; /
	MOV a, #$00
	
	MOV y, #$00

	-																; \ clear out $0000-$03FF
	MOV $0100+y, a													; |
	DBNZ y, -
	-
	MOV $0200+y, a
	DBNZ y, -
	-
	MOV $0300+y, a													; |
	DBNZ y, -														; /
	
	%dsp_write(!MVOLL, $7F)
	%dsp_write(!MVOLR, $7F)
	%dsp_write(!EVOLL, $00)
	%dsp_write(!EVOLR, $00)
	%dsp_write(!KON, $00)
	%dsp_write(!KOFF, $00)
	%dsp_write(!FLG, $00)
	%dsp_write(!ENDX, $7F)
	
	%dsp_write(!EFB, $7F)
	%dsp_write(!PMON, $7F)
	%dsp_write(!NON, $7F)
	%dsp_write(!EON, $7F)
	%dsp_write(!DIR, $80)
	%dsp_write(!ESA, $01)
	%dsp_write(!EDL, $00)
	
	MOV !CONTROL, #$30
	MOV !T0DIV, #$01
	MOV !CONTROL, #$01
	
SPCEngineMainLoop:
	MOV a, !T0OUT
	BEQ SPCEngineMainLoop
	
	JMP SPCEngineMainLoop

SampleDirectory:
	dw $0000, $0000
	
SPCEngineEnd:

!SPCEngineSize = SPCEngineEnd-SPCEngine

arch 65816
