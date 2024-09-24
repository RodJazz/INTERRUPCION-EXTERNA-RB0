    ;AUTOR:Calle Condori Rodrigo
    __CONFIG _XT_OSC & _WDTE_OFF & _PWRTE_ON & _CP_OFF & _BOREN_OFF & _LVP_OFF
    LIST  P=16F877A
    INCLUDE<P16F877A.INC>

    #DEFINE  ON_OFF   PORTA,3
    #DEFINE  MOTOR_DC PORTB,1
    #DEFINE  MOTOR_AC PORTA,0
    #DEFINE  PULSADOR_INT PORTB,0
                   ORG    0X00    
                   GOTO   CONFIGURACION
                   ORG    0X04
                   GOTO   INT_RB0
CONFIGURACION:
                   BCF    STATUS,RP0
                   BCF    STATUS,RP1
                   CLRF   PORTA
                   BSF    STATUS,RP0
                   MOVLW  0X06
                   MOVWF  ADCON1
                   MOVLW  0XFE   ;11111110
                   MOVWF  TRISA
                   MOVLW  0X01   ;00000001
                   MOVWF  TRISB
                   MOVLW  B'01000000'
                   MOVWF  OPTION_REG
                   BCF    STATUS,RP0
                   MOVLW  B'10010000'
                   MOVWF  INTCON
                   CLRF   PORTA
                   CLRF   PORTB
MAIN:
                   BTFSS  ON_OFF      ;PREGUNTAMOS SI EL BIT ON_OFF ES 0 LOGICO
                   GOTO   APAGAR      ;NO ES 0 LOGICO, IR A BUCLE 
                   BSF    MOTOR_DC    ;SI ES 0 LOGICO, SETEAMOS EL BIT MOTOR_DC A 1 LOGICO                   
                   GOTO   MAIN
APAGAR:            
                   BCF    MOTOR_DC    ;ENCIENDE MOTOR_DC
                   GOTO   MAIN        ;CERRA BUCLE


INT_RB0:
                   BTFSS  INTCON,INTF        ;VERIFICAMOS SI ES POR RB0
	               GOTO	  LIMPIAR         ;IR A INT_RB0
MOTOR: 
   	               BCF	  MOTOR_DC        ;SI ES 0 LOGICO, APAGAMOS EL BIT MOTOR_DC
                   BSF    MOTOR_AC        ;Y LUEGO PRENDEMOS EL MOTOR_AC
                   BTFSS  PULSADOR_INT
                   GOTO   LIMPIAR
                   GOTO   MOTOR
LIMPIAR:
                   BCF    MOTOR_AC
	               BCF	  INTCON,INTF       ;LIMPIAMOS LA BANDERA DE INTERRUPCION INTF 
	               RETFIE                 ;SALIMOS DE LA INTERRUPCION
                   END
    