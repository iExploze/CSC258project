################# CSC258 Assembly Final Project ###################
# This file contains our implementation of Dr Mario.
#
# Student 1: Congyi Zhang, 1009103729
# Student 2: Xian Shen, 1009137667
#
# We assert that the code submitted here is entirely our own 
# creation, and will indicate otherwise when it is not.
#
######################## Bitmap Display Configuration ########################
# - Unit width in pixels: 2       
# - Unit height in pixels: 2     
# - Display width in pixels: 64
# - Display height in pixels: 64
# - Base Address for Display: 0x10008000 ($gp)
##############################################################################

    .data
##############################################################################
# Immutable Data
##############################################################################
# The address of the bitmap display. Don't forget to connect it!
ADDR_DSPL:
    .word 0x10008000
# The address of the keyboard. Don't forget to connect it!
ADDR_KBRD:
    .word 0xffff0000
    
#the border for what to store on the stack:
STACK_INITIAL: .word 0x10008000
STACK_MAX: .word 0x10009000

##############################################################################
# Mutable Data
##############################################################################

BLOCK_ROW:   .word 5           # Initial row of the block's top-left corner 
BLOCK_COL:   .word 12          # Initial column of the block's top-left corner
BLOCK_DIR:  .word 0         # direction 0 - 3, 0 
BLOCK_ROW2: .word 5         # initial row of the second block
BLOCK_COL2: .word 13        # intial col of the second block
COLOR1:   .word 0xFF0000           # the color of the block1
COLOR2:   .word 0xFF0000            # the color of the block 2

color_red:    
    .word 0xFF0000
color_yellow: 
    .word 0xFFFF00
color_blue:   
    .word 0x0000FF

STORETOSTACK: .word 0 # if we have to store to stack or not for the block default of 1 for false

##############################################################################
# Code
##############################################################################
	.text
	.globl main

    # Run the game.
main:


lw $t0, ADDR_DSPL
addi $t2, $t0, 896

li $t1, 0xEADB1C
addi $t2, $t0, 908
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 16
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 16
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 16
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 12
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 12
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )


addi $t2, $t2, 12
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 24
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 28
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 12
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 16
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 12
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 12
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 12
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 12
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 8
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 32
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 16
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 16
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 16
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 16
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 16
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )


add $t2, $t2, 256

li $t1, 0xEADB1C
addi $t2, $t2, 12
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 12
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 16
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 12
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 16
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 16
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 16
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 28
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 16
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 16
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 12
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 12
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 16
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 8
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 12
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 16
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 12
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 12
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 28
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 12
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 16
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 16
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 8
sw $t1 0( $t2 )

li $t1, 0xEADB1C
addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

li $t1, 0xDF702B
addi $t2, $t2, 12
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 24
sw $t1 0( $t2 )

addi $t2, $t2, 20
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 8
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )

addi $t2, $t2, 12
sw $t1 0( $t2 )

addi $t2, $t2, 4
sw $t1 0( $t2 )
 
addi $t2, $t2, 4
sw $t1 0( $t2 )
