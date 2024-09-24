# MPLAB IDE generated this makefile for use with GNU make.
# Project: INTERRUPCION POR RB0.mcp
# Date: Mon Sep 23 19:36:01 2024

AS = MPASMWIN.exe
CC = 
LD = mplink.exe
AR = mplib.exe
RM = rm

INT\ POR\ RB0.cof : INT\ POR\ RB0.o
	$(CC) /p16F877A "INT POR RB0.o" /u_DEBUG /z__MPLAB_BUILD=1 /z__MPLAB_DEBUG=1 /o"INT POR RB0.cof" /M"INT POR RB0.map" /W /x

INT\ POR\ RB0.o : INT\ POR\ RB0.asm ../../../../Program\ Files\ (x86)/Microchip/MPASM\ Suite/P16F877A.INC
	$(AS) /q /p16F877A "INT POR RB0.asm" /l"INT POR RB0.lst" /e"INT POR RB0.err" /d__DEBUG=1

clean : 
	$(CC) "INT POR RB0.o" "INT POR RB0.hex" "INT POR RB0.err" "INT POR RB0.lst" "INT POR RB0.cof"

