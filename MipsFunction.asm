#Dominik Szaci³owski
#Projekt: Rysowanie funkcji 3 stopnia [ARKO]
#
#
# 
# &s0 - deskryptor
# $s1 - rozmiar pliku
# $s2 - szerokosc
# $s3 - wysokosc
# $s4 - adres poczatkowy obrazka
# $s5 - padding w kazdym wierszu
# $s6 - aktualny X
#

	.data
nazwa_pliku_in:	.asciiz "C:/Users/dszac/Desktop/Mars/add_files/315.bmp"
nazwa_pliku_out:	.asciiz "C:/Users/dszac/Desktop/Mars/add_files/blue301COPY.bmp"
error:	.asciiz "Nie udalo sie otworzyc pliku."
text1:	.asciiz "Zakres wspólczynników wynosi: <-8,7> (tylko liczby calkowite). Podaj i zatwierdŸ enterem kolejne wspólczynniki." 	
bufor:	.align 2 
	.space 4
X_lewo:	.word -16
X_prawo:	.word 16
wsp_lewo:	.word -8
wsp_prawo:	.word 7
Y_gora:		.word 500
Y_dol:		.word -500
A:		.space 4
B:		.space 4
C:		.space 4
D:		.space 4
skala_X:	.space 4
skala_Y:	.space 4

	.text
	.globl main

main:
	li $v0, 4		#wczytanie wspolczynnikow
	la $a0, text1
	syscall
	li $v0, 5
	syscall
	sw $v0, A
	li $v0, 5
	syscall
	sw $v0, B
	li $v0, 5
	syscall
	sw $v0, C
	li $v0, 5
	syscall
	sw $v0, D
	
wczytajBMP:
	la $a0, nazwa_pliku_in	#wczytanie pliku bmp
	li $a1, 0
	li $a2, 0
	li $v0, 13
	syscall
	
	move $s0, $v0	
	bltz $s0, blad_otwarcia
	
	move $a0, $s0		#BM
	la $a1, bufor
	li $a2, 2
	li $v0,14
	syscall
	
	move $a0, $s0		#Rozmiar pliku
	la $a1, bufor
	li $a2, 4
	li $v0,14
	syscall
	lw $s1, bufor
	
	addiu $a0, $s0, 2		#Zarezerwuj pamiec + 2 dla wyrownania (plus 2 bajty aby moc uzyc operacji sb po wpisaniu BM)
	li $v0, 9
	syscall
	addiu $s4, $v0, 2
	
	move $t0, $s4			#wpisz BM oraz rozmiar pliku
	li $t1, 'B'
	sb $t1, 0($t0)
	addiu $t0, $t0, 1
	li $t1, 'M'
	sb $t1, 0($t0)
	addiu $t0, $t0, 1
	la $t1, 0($s1)
	sw $t1, 0($t0)
	addiu $t0, $t0, 4
	
	move $a0, $s0		#nieuzywane
	la $a1, bufor
	li $a2, 4
	li $v0,14
	syscall
	
	lw $t1, bufor
	sw $t1, 0($t0)
	addiu $t0, $t0, 4
	
	move $a0, $s0		#Rozmiar offsetu
	la $a1, bufor
	li $a2, 4
	li $v0,14
	syscall
	
	lw $t1, bufor
	sw $t1, 0($t0)
	addiu $t0, $t0, 4
	
	move $a0, $s0		#Rozmiar infoHeadera
	la $a1, bufor
	li $a2, 4
	li $v0,14
	syscall
	
	lw $t1, bufor
	sw $t1, 0($t0)
	addiu $t0, $t0, 4
	
	move $a0, $s0		#Szerokosc
	la $a1, bufor
	li $a2, 4
	li $v0,14
	syscall
	lw $s2, bufor
	
	lw $t1, bufor
	sw $t1, 0($t0)
	addiu $t0, $t0, 4
	
	move $a0, $s0		#Wysokosc
	la $a1, bufor
	li $a2, 4
	li $v0,14
	syscall
	lw $s3, bufor
	
	lw $t1, bufor
	sw $t1, 0($t0)
	addiu $t0, $t0, 4
	
	move $a0, $s0		#Plaszczyzny i ilosc bitow na pixel
	la $a1, bufor
	li $a2, 4
	li $v0,14
	syscall
	
	lw $t1, bufor
	sw $t1, 0($t0)
	addiu $t0, $t0, 4
	
	move $a0, $s0		#Kompresja
	la $a1, bufor
	li $a2, 4
	li $v0,14
	syscall
	
	lw $t1, bufor
	sw $t1, 0($t0)
	addiu $t0, $t0, 4
	
	move $a0, $s0		#Rozmiar pliku skompresowanego
	la $a1, bufor
	li $a2, 4
	li $v0,14
	syscall
	
	lw $t1, bufor
	sw $t1, 0($t0)
	addiu $t0, $t0, 4

	move $a0, $s0		#rozdzielczoscX
	la $a1, bufor
	li $a2, 4
	li $v0,14
	syscall
	
	lw $t1, bufor
	sw $t1, 0($t0)
	addiu $t0, $t0, 4
	
	move $a0, $s0		#rozdzielczoscY
	la $a1, bufor
	li $a2, 4
	li $v0,14
	syscall
	
	lw $t1, bufor
	sw $t1, 0($t0)
	addiu $t0, $t0, 4
	
	move $a0, $s0		#uzyte kolory
	la $a1, bufor
	li $a2, 4
	li $v0,14
	syscall
	
	lw $t1, bufor
	sw $t1, 0($t0)
	addiu $t0, $t0, 4
	
	move $a0, $s0		#wazne kolory
	la $a1, bufor
	li $a2, 4
	li $v0,14
	syscall
	
	lw $t1, bufor
	sw $t1, 0($t0)
	addiu $t0, $t0, 4
	
skopiuj_pixele:
	subiu $t3, $s1, 54	#ile pixeli
skopiuj_pixele_loop:
	blez $t3, rysuj_os_Y
	
	move $a0, $s0		#pixele
	la $a1, bufor
	li $a2, 4
	li $v0,14
	syscall
	
	lw $t1, bufor
	sw $t1, 0($t0)
	addiu $t0, $t0, 4
	subiu $t3, $t3, 4
	j skopiuj_pixele_loop
	
rysuj_os_Y:
	li $a0, 0			# $a0 - X
	sra $a1, $s3, 1			# $a1 - Y
	subu $a1, $zero, $a1
wyliczenia_pomocnicze:			#brak potrzeby powtarzania
	li $t7, 3
	mulu $t5, $s2, $t7 
	andi $s5, $t5, 0x0003		#obliczenie bajtow paddingowych
	li $t0, 4
	subu $s5, $t0, $s5		#$s5 - bajty paddingowe
	
	sra $t0, $s2, 1			#$t0 - polowa szerokosci obrazka
	sra $t1, $s3, 1			#$t1 - polowa wysokosci obrazka
	
rysuj_os_Y_loop:
					#wylicz_pixel

	addu $a0, $a0, $t0
	addu $a1, $a1, $t1
	
	addu $t2, $t5, $s5
	mulu $t2, $a1, $t2
	mulu $t6, $a0, $t7
	addu $t2, $t2, $t6		#$t2 - przesuniecie pierwszego bajtu pixela
	
	subu $a0, $a0, $t0
	subu $a1, $a1, $t1

					#rysuj_pixel
	addiu $t3, $s4, 54
	addu $t3, $t3, $t2
	
	li $t4, 255
	sb $t4, 0($t3)
	sb $t4, 1($t3)
	sb $t4, 2($t3)
	
	bge $a1, $t1, rysuj_os_X
	addiu $a1, $a1, 1
	j rysuj_os_Y_loop
	
rysuj_os_X:
	li $a1, 0			# $a0 - X
	sra $a0, $s2, 1			# $a1 - Y
	subu $a0, $zero, $a0
	
rysuj_os_X_loop:
					#wylicz pixel
	addu $a0, $a0, $t0
	addu $a1, $a1, $t1
	
	addu $t2, $t5, $s5
	mulu $t2, $a1, $t2
	mulu $t6, $a0, $t7
	addu $t2, $t2, $t6		#$t2 - przesuniecie pierwszego bajtu pixela
	
	subu $a0, $a0, $t0
	subu $a1, $a1, $t1

					#rysuj pixel
	addiu $t3, $s4, 54
	addu $t3, $t3, $t2
	
	li $t4, 255
	sb $t4, 0($t3)
	sb $t4, 1($t3)
	sb $t4, 2($t3)
	
	bge $a0, $t0, wylicz_skale
	addiu $a0, $a0, 1
	j rysuj_os_X_loop
	

wylicz_skale:
	lw $t0, X_prawo
	sll $t0, $t0, 1
	div $t1, $t0, $s2
	sll $t1, $t1, 4
	mfhi $t2
	sll $t2, $t2, 4
	div $t2, $t2, $s2
	add $t1, $t2, $t1
	sw $t1, skala_X
	
	lw $t0, Y_gora
	sll $t0, $t0, 1
	div $t1, $t0, $s3
	sll $t1, $t1, 4
	mfhi $t2
	sll $t2, $t2, 4
	div $t2, $t2, $s3
	add $t1, $t2, $t1
	sw $t1, skala_Y
	
rysuj_wykres:
	sra $t9, $s2, 1			#polowa szerokossci
	sub $a3, $zero, $t9
	lw $t4, skala_X
	mul $a0, $a3, $t4
rysuj_wykres_loop:
oblicz_Y:
	 
	lw $t0, D
	lw $t1, C
	mul $t1, $t1, $a0
	sll $t0, $t0, 4
	add $t0, $t0, $t1
	lw $t1, B
	mul $t1, $t1, $a0
	mul $t1, $t1, $a0
	sll $t0, $t0, 4
	add $t0, $t0, $t1
	lw $t1, A
	mul $t1, $t1, $a0
	mul $t1, $t1, $a0
	mul $t1, $t1, $a0
	sll $t0, $t0, 4
	add $t0, $t0, $t1

oblicz_pixel:
	lw $t1, skala_Y
	sll $t1, $t1, 8
	div $t2, $t0, $t1
	
	move $a1, $t2
				#czy nie wyjezdza poza obrazek?
	sra $t4, $s3, 1		#polowa wysokosci obrazka
	bge $a1, $t4, next
	sub $t4, $zero, $t4
	blt $a1, $t4, next
rysuj_pixel:	
	li $t7, 3
	mulu $t5, $s2, $t7 
	andi $s5, $t5, 0x0003		#obliczenie bajtow paddingowych
	li $t0, 4
	subu $s5, $t0, $s5		#$s5 - bajty paddingowe
	
	sra $t0, $s2, 1			#$t0 - polowa szerokosci obrazka
	sra $t1, $s3, 1			#$t1 - polowa wysokosci obrazka

	addu $a3, $a3, $t0
	addu $a1, $a1, $t1
	
	addu $t2, $t5, $s5
	mulu $t2, $a1, $t2
	mulu $t6, $a3, $t7
	addu $t2, $t2, $t6		#$t2 - przesuniecie pierwszego bajtu pixela
	
	subu $a3, $a3, $t0
	subu $a1, $a1, $t1

					#rysuj_pixel
	addiu $t3, $s4, 54
	addu $t3, $t3, $t2
	
	li $t4, 0
	sb $t4, 0($t3)
	sb $t4, 1($t3)
	sb $t4, 2($t3)
next:
	addi $a3, $a3, 1
	lw $t4, skala_X
	mul $a0, $a3, $t4
	bgt $a3, $t9, zamknij_plik
	j rysuj_wykres_loop
	
zamknij_plik:
	move $a0,$s0
	li $v0,16
	syscall
zapisz_plik:
	la $a0, nazwa_pliku_out
	li $a1, 1
	li $a2, 0
	li $v0, 13
	syscall
	
	move $t0, $v0 
	bltz $t0, blad_otwarcia
	
	move $a0, $t0
	la $a1, 0($s4)
	la $a2, 0($s1)
	li $v0, 15
	syscall
zamknij:
	li $v0, 10
	syscall
blad_otwarcia:
	la $a0, error
	li $v0, 4
	syscall
	li $v0, 10
	syscall
