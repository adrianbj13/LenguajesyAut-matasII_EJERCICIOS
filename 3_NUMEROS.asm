
;LENGUAJES Y AUTOMATAS II
;Adrian Guadalupe Balam Jimenez

.MODEL SMALL
.STACK 64
.DATA
INCLUDE 'EMU8086.INC'
;SIMPLES MENSAJES
MSJ1 DB 0AH,0DH, 'INGRESE TRES DIGITOS DEL 0 AL 9 : ', '$'
MSJ2 DB 0AH,0DH, 'ESCRIBA EL PRIMER DIGITO: ', '$'
MSJ3 DB 0AH,0DH, 'ESCRIBA EL SEGUNDO DIGITO: ', '$'
MSJ4 DB 0AH,0DH, 'ESCRIBA TERCER DIGITO: ', '$'
MAYOR DB 0AH,0DH, 'DE LOS TRES EL MAYOR ES: ', '$'

DIGITO1 DB 100 DUP('$')
DIGITO2 DB 100 DUP('$')
DIGITO3 DB 100 DUP('$')

SALTO DB 13,10, '$' 
.CODE
INICIO:
MOV SI,0
MOV AX,@DATA
MOV DS,AX
MOV AH,09
MOV DX,OFFSET MSJ1 ;IMPRIMIMOS EL MSJ1
INT 21H

CALL SALTODELINEA;LLAMAMOS EL METODO SALTODELINEA.

CALL PEDIRCARACTER ;LLAMAMOS AL METODO

MOV DIGITO1,AL ;LO GUARDADO EN AL A DIGITO1

CALL SALTODELINEA

CALL PEDIRCARACTER

MOV DIGITO2,AL

CALL SALTODELINEA

CALL PEDIRCARACTER

MOV DIGITO3,AL

CALL SALTODELINEA

;COMPARAR

MOV AH,DIGITO1
MOV AL,DIGITO2
CMP AH,AL ;COMPARA PRIMERO CON EL SEGUNDO
JA COMPARA-1-3 ;SI ES MAYOR EL PRIMERO, AHORA LO COMPARA CON EL TERCERO
JMP COMPARA-2-3 ;SI EL PRIMERO NO ES MAYOR,AHORA COMPARA EL 2 Y 3 DIGITO
COMPARA-1-3:
MOV AL,DIGITO3 ;AH=PRIMER DIGITO, AL=TERCER DIGITO
CMP AH,AL ;COMPARA PRIMERO CON TERCERO
JA MAYOR1 ;SI ES MAYOR QUE EL TERCERO, ENTONCES EL PRIMERO ES MAYOR QUE LOS 3

COMPARA-2-3:
MOV AH,DIGITO2
MOV AL,DIGITO3
CMP AH,AL ;COMPARA 2 Y 3, YA NO ES NECESARIO COMPARARLO CON EL 1,PORQUE YA SABEMOS QUE EL 1 NO ES MAYOR QUE EL 2
JA MAYOR2 ;SI ES MAYOR EL 2,NOS VAMOS AL METODO PARA IMPRIMIRLO
JMP MAYOR3 ;SI EL 2 NO ES MAYOR, OBVIO EL 3 ES EL MAYOR

 
MAYOR1:

CALL MENSAJEMAYOR ;LLAMA AL METODO QUE DICE: EL DIGITO MAYOR ES:

MOV DX, OFFSET DIGITO1 ;IMPRIR EL DIGITO 1 ES MAYOR
MOV AH, 9
INT 21H
JMP EXIT

MAYOR2:
CALL MENSAJEMAYOR

MOV DX, OFFSET DIGITO2 ;SALTO DE LINEA
MOV AH, 9
INT 21H
JMP EXIT

MAYOR3:
CALL MENSAJEMAYOR

MOV DX, OFFSET DIGITO3 ;SALTO DE LINEA
MOV AH, 9
INT 21H
JMP EXIT

;METODOS

MENSAJEMAYOR:
MOV DX, OFFSET MAYOR ;EL DIGITO MAYOR ES:
MOV AH, 9
INT 21H

RET
PEDIRCARACTER:
MOV AH,01H; PEDIMOS PRIMER DIGITO
INT 21H
RET

SALTODELINEA:
MOV DX, OFFSET SALTO ;SALTO DE LINEA
MOV AH, 9
INT 21H
RET

EXIT:
MOV AX, 4C00H;UTILIZAMOS EL SERVICIO 4C DE LA INTERRUPCION 21H
INT 21H ;PARA TERMIANR EL PROGRAMA
ENDS
