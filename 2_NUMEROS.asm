 
;LENGUAJES Y AUTOMATAS II
;Adrian Guadalupe Balam Jimenez

.model small
.stack 150
.data
msj1 db 'Numero 1: ','$'
msj2 db 13,10,'Numero 2: ','$'
msj3 db 13,10,'Suma: ','$'
msj4 db 13,10,'Resta: ','$'
msj5 db 13,10,'Multiplicacion: ','$'
msj6 db 13,10,'Division: ','$'
linea db 13,10,'$'
var1 db 0
var2 db 0
.code
.startup

call limpia
mov ah,09h
lea dx, msj1 ;desplegar numero 1:
int 21h

call leer ;lee primer numero
sub al,30h ;restar 30h para obtener el numero
mov var1,al ;lo guardo en var1
mov ah,09h
lea dx, msj2 ;desplegar numero 2:
int 21h

call leer ;lee segundo numero
sub al,30h ;restar 30h para obtener segundo valor
mov var2,al ;guardar en var2
mov bl,var2 ;mover a bl

;SUMA
add bl,var1 ; realizo la suma de var2(bl) y var1 y el resultado queda en bl
mov ah,09h
lea dx,msj3 ;imprimir suma
int 21h
mov dl,bl ;pongo en dl el numero a imprimir var2(bl)
add dl,30h ; agrego 30h para obtener el caracter    
mov ah,02h ;imprime un caracter
int 21h

;RESTA
mov bl,var1
sub bl,var2
mov ah,09h
lea dx,msj4 ;desplegar resta:
int 21h
mov dl,bl ;mover resta a dl para imprimir
add dl,30h ;sumar 30 para obtener caracter
mov ah,02h ;imprimir un caracter
int 21h

;MULTIPLICACION
mov ah,09h
lea dx,msj5 ;desplegar mult
int 21h

mov al,var1 
mov bl,var2
mul bl ;mult al=al*bl
mov dl,al ;mover al a dl para imprimir
add dl,30h ;sumar 30 para obtener caracter
mov ah,02h ;imprimir caracter
int 21h

;DIVISION
mov ah,09h
lea dx,msj6 ;desplegar div
int 21h
xor ax,ax ;limpiamos el registro ax. 
mov al,var2
mov bl,al
mov al,var1
div bl ; divide AX/BX el resultado lo almacena en AX, el residuo queda en DX
mov bl,al
mov dl,bl
add dl,30h
mov ah,02h
int 21h
.exit

; PROCEDIMIENTOS
salto proc near
mov ah,09h
lea dx,linea
int 21h
mov dl,00h
ret
salto endp

leer proc near
mov ah,01h;leer caracter desde el teclado
int 21h;lee primer caracter
ret
leer endp

limpia proc near
mov ah,00h
mov al,03h
int 10h
ret
limpia endp
end