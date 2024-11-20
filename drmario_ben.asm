################# CSC258 Assembly Final Project ###################
# This file contains our implementation of Dr Mario.
#
# Student 1: Congyi Zhang, 1009103729
# Student 2: Name, Student Number (if applicable)
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

color_red:    
    .word 0xFF0000
color_yellow: 
    .word 0xFFFF00
color_blue:   
    .word 0x0000FF

pre_color_1:
    .word 0xFF0000

pre_color_2:
    .word 0xFF0000
##############################################################################
# Mutable Data
##############################################################################

##############################################################################
# Code
##############################################################################
	.text
	.globl main

    # Run the game.
main:
    li $t1, 0xD3D3D3             # Load a 16-bit color (0xD3D3) into $t1
    lw $t0, ADDR_DSPL            # Load the base address of the display into $gp

    # Draw specific pixels

    # Draw pixel (6, 10)
    addi $t2, $t0, 768          # Row offset for row 6 (6 * 128 bytes)
    addi $t2, $t2, 40           # Column offset for column 10 (10 * 4 bytes)
    sw $t1, 0($t2)              # Store color at (6, 10)

    # Draw pixel (5, 10)
    addi $t2, $t0, 640         # Row offset for row 5 (5 * 128 bytes)
    addi $t2, $t2, 40          # Column offset for column 10 (10 * 4 bytes)
    sw $t1, 0($t2)             # Store color at (5, 10)
    
    # Draw pixel (6, 15)
    addi $t2, $t0, 768         # Row offset for row 6 (6 * 128 bytes)
    addi $t2, $t2, 60          # Column offset for column 10 (15 * 4 bytes)
    sw $t1, 0($t2)             # Store color at (6, 10)

    # Draw pixel (5, 15)
    addi $t2, $t0, 640         # Row offset for row 5 (5 * 128 bytes)
    addi $t2, $t2, 60          # Column offset for column 10 (15 * 4 bytes)
    sw $t1, 0($t2)             # Store color at (5, 10)

    # Set up the line-drawing loop

    # Initialize starting address for the horizontal line at (7, 4)
    addi $t2, $t0, 896          # Row offset for row 7 (7 * 128 bytes)
    addi $t2, $t2, 16           # Column offset for column 4 (4 * 4 bytes)

    # Initialize loop counter
    li $t9, 0                  # Set loop counter $t9 to 0
    li $t8, 7                  # Set the loop limit to 7 pixels
    
draw_loop:
    # Draw the color at the current calculated address in $t2
    sw $t1, 0($t2)             # Store color at the current pixel

    # Move to the next pixel to the right (add 4 bytes to the address)
    addi $t2, $t2, 4           # Move to the next pixel in the same row (4 bytes per pixel)

    # Increment loop counter
    addi $t9, $t9, 1           # Increment loop counter $t9

    # Check if we have drawn 7 pixels
    bne $t9, $t8, draw_loop    # Continue if $t9 is not equal to $t8
    
    # Initialize starting address for the horizontal line at (7, 15)
    addi $t2, $t0, 896          # Row offset for row 7 (7 * 128 bytes)
    addi $t2, $t2, 60           # Column offset for column 4 (15 * 4 bytes)
    
    # Initialize loop counter
    li $t9, 0                  # Set loop counter $t9 to 0
    li $t8, 7                  # Set the loop limit to 7 pixels
    
draw_loop2:
    # Draw the color at the current calculated address in $t2
    sw $t1, 0($t2)             # Store color at the current pixel

    # Move to the next pixel to the right (add 4 bytes to the address)
    addi $t2, $t2, 4           # Move to the next pixel in the same row (4 bytes per pixel)

    # Increment loop counter
    addi $t9, $t9, 1           # Increment loop counter $t9

    # Check if we have drawn 7 pixels
    bne $t9, $t8, draw_loop2    # Continue if $t9 is not equal to $t8
    
    # Initialize starting address for the horizontal line at (29, 4)
    addi $t2, $t0, 3712         # Row offset for row 7 (29 * 128 bytes)
    addi $t2, $t2, 16           # Column offset for column 4 (4 * 4 bytes)
    
    # Initialize loop counter
    li $t9, 0                   # Set loop counter $t9 to 0
    li $t8, 18                  # Set the loop limit to 18 pixels
    
draw_loop3:
    # Draw the color at the current calculated address in $t2
    sw $t1, 0($t2)             # Store color at the current pixel

    # Move to the next pixel to the right (add 4 bytes to the address)
    addi $t2, $t2, 4           # Move to the next pixel in the same row (4 bytes per pixel)

    # Increment loop counter
    addi $t9, $t9, 1           # Increment loop counter $t9

    # Check if we have drawn 7 pixels
    bne $t9, $t8, draw_loop3    # Continue if $t9 is not equal to $t8
    
    
#drawing the vertical lines:
# Initialize starting address for the vertical line at (8, 4)
addi $t2, $t0, 1024         # Row offset for row 8 (8 * 128 bytes)
addi $t2, $t2, 16           # Column offset for column 4 (4 * 4 bytes)
li $t8, 21 # load the loop counter for vertical line limites
li $t9, 0 # the counter variable

vertical1:
    sw $t1, 0( $t2 )
    addi $t2, $t2, 128
    addi $t9, $t9, 1
    bne $t9, $t8, vertical1
 
# Initialize starting address for the vertical line at (8, 21)
addi $t2, $t0, 1024         # Row offset for row 8 (8 * 128 bytes)
addi $t2, $t2, 84           # Column offset for column 21 (21 * 4 bytes)
li $t8, 21 # load the loop counter for vertical line limites
li $t9, 0 # the counter variable
vertical2:
    sw $t1, 0( $t2 )
    addi $t2, $t2, 128
    addi $t9, $t9, 1
    bne $t9, $t8, vertical2

##############################################################################
# Draw random virus on the board
##############################################################################
li $t8, 4
li $t9, 0
random_virus:                       # get random position for virus (only the bottom half of the bottle)
    addi $t2, $t0, 2196             # the first block of posible virus, which located at the top left of the bottom half of the bottle -> $t2
    li $v0, 42
    li $a0, 0                # set minimum
    li $a1, 16               # set maximum
    syscall                  # get a random number from [0,2] and store it in $a0
    sll $t7, $a0, 2          # get a random position for roll (times 2^2 = 4)
    
    li $v0, 42
    li $a0, 0                # set minimum
    li $a1, 9                # set maximum
    syscall                  # get a random number from [0,2] and store it in $a0
    sll $t5, $a0, 7          # get a random position for column (times 2^7 = 128)
    
    add $t2, $t2, $t7        # update the position for column
    add $t2, $t2, $t5        # update the position for column
    
    jal get_random_color
    sw $t6, 0( $t2 )
    
    addi $t9, $t9, 1
    bne $t9, $t8, random_virus
    
##############################################################################
# Generate the preview bolcks
##############################################################################
generate_pre_block:                     # Generate the color of the preview blocks and stored in pre_color_1 and pre_color_2
    jal get_random_color
    sw $t6, pre_color_1

    jal get_random_color
    sw $t6, pre_color_2

draw_pre_block:                         # Draw the preview's block
    addi $t5, $t0, 1384
    lw $t6, pre_color_1
    sw $t6, 0($t5)
    
    addi $t5, $t5, 4
    lw $t6, pre_color_2
    sw $t6, 0($t5)
    
    j game_loop
    
##############################################################################
# Get a random color and store it into $t6
##############################################################################
get_random_color:                   # after calling this function a random color of red, yellow or blue would be store in $t6
    li $v0, 42
    li $a0, 0               # set minimum
    li $a1, 3               # set maximum
    syscall
    # get a random number from [0,2] and store it in $a0
    
    beq $a0, 0, color_red_case      # If $a0 is 0, jump to color red case
    beq $a0, 1, color_yellow_case   # If $a0 is 1, jump to color yellow case
    beq $a0, 2, color_blue_case     # If $a0 is 2, jump to color blue case

color_red_case:  
    lw $t6, color_red               # store color red in $t6
    jr $ra

color_yellow_case:
    lw $t6, color_yellow            # store color yellow in $t6
    jr $ra

color_blue_case:
    lw $t6, color_blue              # store color blue in $t6
    jr $ra

##############################################################################
# Check if the bottle entrance is blocked, and quit the game if true
##############################################################################
    lw $t2, 940 
    lw $t3, 944
    lw $t4, 948
    lw $t5, 952
    # These are the position of the four pixel at the bottle's entrance
    li $zero, 0x0

    bne $t2, $zero, quit

    bne $t3, $zero, quit

    bne $t4, $zero, quit

    bne $t5, $zero, quit
    
    j game_loop


quit:
    li $v0, 10                 # Syscall to terminate the program
    syscall

 game_loop:
  
 
 
 
 