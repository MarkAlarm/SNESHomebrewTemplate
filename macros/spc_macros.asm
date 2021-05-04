
macro dsp_write(addr, data)
	MOV !DSPADDR, #<addr>
	MOV !DSPDATA, #<data>
endmacro
