   __CONFIG _XT_OSC & _WDTE_OFF & _PWRTE_ON & _CP_OFF & _BOREN_OFF & _LVP_OFF
   LIST  P=16F877A
   INCLUDE <P16F877A.INC>
   #DEFINE  PULSADOR_RB0  PORTB,0
   #DEFINE  MOTOR_DC      PORTB,1
                   ORG    0X00           ;INICIA EL PROGRAMA EN ESTA DIRECCION
                   GOTO   CONFIGURAR     ;SALTA A LA ETIQUETA CONFIGURAR
                   ORG    0X04           ;VECTOR DE INTERRUOCIÓN
                   GOTO   INT_RB0        ;SE DIRIGE A LA SUBRUTINA INT_RB0
CONFIGURAR:
                   BSF    STATUS,RP0     ;SE INGRESA AL BANCO 1
                   BCF    STATUS,RP1
                   MOVLW  B'00000001'    ;CARGAMOS ESTE VALOR AL REGISTRO TRISB
                   MOVWF  TRISB 
                   MOVLW  B'01000000'    ;CARGAMOS ESTE VALOR PARA CONFIGURAR LA ENTRADA POR RB0
                   MOVWF  OPTION_REG
                   BCF    STATUS,RP0     ;INGRESA AL BANCO 0
                   MOVLW  B'10010000'    ;CARGAMOS ESTE VALOR PARA CONFIGURAR EL TIPO DE INTERRUPCIÓN
                   MOVWF  INTCON
                   CLRF   PORTB
;---------------PRINCIPAL--------------
MAIN:
                   SLEEP
;AQUÍ PUEDE INTRODUCIR UN PROGRAMA PRINCIPAL
                   GOTO   MAIN
;--------------------------------------
;SUBRUTINA DE INTERRUCIÓN
INT_RB0:
                   BTFSS  PULSADOR_RB0   ;SALTA SI EL PULSADOR ESTÁ EN 1 LOGICO
                   GOTO   INT_RB0        ;IR A LA ETIQUETA INT_RB0
                   BTFSC  MOTOR_DC       ;SALTA SI EL MOTOR_DC ESTÁ APAGADO
                   GOTO   OFF            ;IR A LA ETIQUETA OFF
                   BSF    MOTOR_DC       ;ACTIVA EL MOTOR_DC
                   BCF    INTCON,INTF    ;LIMPIA LA BANDERA DE INTERRUPCIÓN POR RB0
                   RETFIE                ;SALIR DE LA INTERRUPCIÓN
OFF:
                   BCF    MOTOR_DC       ;APAGAR MOTOR
                   BCF    INTCON,INTF    ;LIMPIA LA BANDERA DE INTERRUPCIÓN POR RB0
                   RETFIE                ;SALIR DE LA INTERRUPCIÓN
                   END
                     