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

STORETOSTACK: .word 0 # if we have to store to stack or not for the block default of 1 for false

##############################################################################
# Code
##############################################################################
	.text
	.globl main

    # Run the game.
main:

draw_border:
    li $t1, 0xD3D3D3             # Load a 16-bit color (0xD3D3) into $t1
    lw $t0, ADDR_DSPL          # Load the base address of the display into $gp

    # Draw specific pixels
    
##################################################################################################
#under this is all the borders,  its a pile of shitcode now, dont touch                          #
##################################################################################################

    # Draw pixel (6, 10)
    addi $t2, $t0, 768         # Row offset for row 6 (6 * 128 bytes)
    addi $t2, $t2, 40           # Column offset for column 10 (10 * 4 bytes)
    sw $t1, 0($t2)             # Store color at (6, 10)

    # Draw pixel (5, 10)
    addi $t2, $t0, 640         # Row offset for row 5 (5 * 128 bytes)
    addi $t2, $t2, 40           # Column offset for column 10 (10 * 4 bytes)
    sw $t1, 0($t2)             # Store color at (5, 10)
    
    # Draw pixel (6, 15)
    addi $t2, $t0, 768         # Row offset for row 6 (6 * 128 bytes)
    addi $t2, $t2, 60           # Column offset for column 10 (15 * 4 bytes)
    sw $t1, 0($t2)             # Store color at (6, 10)

    # Draw pixel (5, 15)
    addi $t2, $t0, 640         # Row offset for row 5 (5 * 128 bytes)
    addi $t2, $t2, 60           # Column offset for column 10 (15 * 4 bytes)
    sw $t1, 0($t2)             # Store color at (5, 10)

    # Set up the line-drawing loop

    # Initialize starting address for the horizontal line at (7, 4)
    addi $t2, $t0, 896         # Row offset for row 7 (7 * 128 bytes)
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
addi $t2, $t0, 896         # Row offset for row 7 (7 * 128 bytes)
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
li $t9, 0                  # Set loop counter $t9 to 0
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
    
##################################################################################################
#above this is all the borders,  its a pile of shitcode now, dont touch                          #
##################################################################################################

game_loop:
    # Step 1a: Check if key has been pressed
    li $v0, 32                # Syscall code for printing an integer in binary
	li $a0, 1                 # Pass the integer 1 to print in binary
	syscall

	
	# store everything on a stack:
	jal store_to_stack
	# draw everything on a stack:
	jal draw_by_stack
	# draw the block
	jal draw_block
	# keyboard checks, also check for collision
	lw $t0, ADDR_KBRD         # Load the keyboard base address into $t0
	lw $t2, 0($t0)            # Read the first word (status) from the keyboard
	beq $t2, 1, keyboard_input # If $t2 == 1 (key pressed), branch to keyboard_input
	clear_block_true: # dont mind this
	
	clear_block_false: # dont mind this
	
    # 5. Go back to Step 1
j game_loop
    


draw_block:
    # Load block's position and direction
    lw $t1, BLOCK_ROW          # Load block's row
    lw $t2, BLOCK_COL          # Load block's column
    lw $t9, COLOR1              # Load block's color
    lw $t0, ADDR_DSPL          # Load base address of the display
    
    # calculating the offsets
    sll $t4, $t1, 7            # Multiply BLOCK_ROW by 128 using a shift
    sll $t5, $t2, 2            # Multiply BLOCK_COL by 4 using a shift
    add $t6, $t0, $t4          # Add row offset to base address
    add $t6, $t6, $t5          # Add column offset to get the final address
    
    # Draw the pixel
    sw $t9, 0($t6)             # Store the color at the calculated address
    # also store it for later comparison
    add $s0, $t6, $zero
    
    # Draw the second block
    lw $t1, BLOCK_ROW2          # Load block's row
    lw $t2, BLOCK_COL2          # Load block's column
    lw $t9, COLOR2              # Load block's color
    lw $t0, ADDR_DSPL          # Load base address of the display
    
    # calculating the offsets
    sll $t4, $t1, 7            # Multiply BLOCK_ROW by 128 using a shift
    sll $t5, $t2, 2            # Multiply BLOCK_COL by 2 using a shift
    add $t6, $t0, $t4          # Add row offset to base address
    add $t6, $t6, $t5          # Add column offset to get the final address
    
    # Draw the pixel
    sw $t9, 0($t6)             # Store the color at the calculated address
    # also store it for later comparison
    add $s1, $t6, $zero

jr $ra



#########################################################################################
#draw everything on the stack onto the screen                                           #
#########################################################################################

draw_by_stack:
    lw $t0, ADDR_DSPL
    lw $t1, STACK_INITIAL            # Load TOP_LEFT into $t1 (start address)
    lw $t2, STACK_MAX          # Load BOT_RIGHT into $t2 (end address)
    move $t3, $t1               # Copy $t1 into $t3 (initialize counter)

draw_loop_stack:
    # Step 0: Check if $sp equals 0x7FFFFFFC
    li $t6, 0x7FFFFFFC          # Load 0x7FFFFFFC into $t6
    beq $sp, $t6, draw_done_stack  # If $sp == 0x7FFFFFFC, exit the loop

    bgt $t3, $t2, draw_done_stack  # If $t3 > $t2, exit the loop
    
    # Step 1: Skip the fallable integer (1) on the stack
    addi $sp, $sp, 4            # Skip the next value (fallable flag)

    # Step 2: Pop the color location from the stack
    lw $t5, 0($sp)              # Load the top of the stack (color) into $t4
    addi $sp, $sp, 4            # Increment $sp to pop the location

    # Step 3: Pop the bitmap from the stack
    lw $t4, 0($sp)              # Load the next value from the stack (bitmap location) into $t5
    addi $sp, $sp, 4            # Increment $sp to pop the color

    # Step 4: Draw the color to the bitmap location
    sw $t5, 0($t4)              # Store the color ($t5) at the bitmap location ($t4)

    # Step 5: Increment the counter and loop again
    addi $t3, $t3, 4            # Increment $t3 by 4
    j draw_loop_stack           # Repeat the loop
    
draw_done_stack:
    jr $ra                      # Return to the caller


################################################################################
# store everything necessary onto the stack                                    #
################################################################################

store_to_stack:
    # get the location of the block to not be stored into the stack:
    # Load 1st block's position and direction
    lw $t1, BLOCK_ROW          # Load block's row
    lw $t2, BLOCK_COL          # Load block's column
    lw $t0, ADDR_DSPL          # Load base address of the display

    lw $t0, ADDR_DSPL
    lw $t1, STACK_INITIAL            # Load TOP_LEFT into $t1 (start address)
    lw $t2, STACK_MAX           # Load BOT_RIGHT into $t2 (end address)
    
    move $t3, $t1               # Copy $t1 into $t3 (initialize counter)

store_loop_start:
    bgt $t3, $t2, store_loop_end      # If $t3 > $t2, exit the loop

    # stack storing, 1 for location, 1 for color, 1 for fallable
    # Step 2: Push the location onto the stack
    addi $sp, $sp, -4           # Allocate space on the stack for location
    sw $t3, 0($sp)              # Store the calculated location on the stack
    # Step 3: Load the color at the calculated location
    lw $t7, 0($t3)              # Load the color at address $t6 into $t7
    # Step 4: Push the color onto the stack
    addi $sp, $sp, -4           # Allocate space on the stack for color
    sw $t7, 0($sp)              # Store the color on the stack
    # Step 5: Push the integer 1 onto the stack
    li $t7, 1                   # Load the value 1 into $t8
    addi $sp, $sp, -4           # Allocate space on the stack for the integer
    sw $t7, 0($sp)              # Store the integer 1 on the stack
    
skip_iteration:
    addi $t3, $t3, 4            # Increment $t3 by 4
    j store_loop_start                # Repeat the loop

store_loop_end:
    jr $ra


##############################Clearing screen whole################################
clear_screen:
    lw $t0, ADDR_DSPL          # Load the base address of the display
    li $t1, 0x000000           # Black color (clear screen color)
    li $t3, 0                  # Start row index
    li $t4, 64                 # Total rows (64 for a 64x64 display)

clear_row:
    # Initialize starting address for the current row
    mul $t2, $t3, 128          # Row offset: row * 128 bytes
    add $t2, $t2, $t0          # Add the base address
    li $t9, 0                  # Reset loop counter for columns
    li $t8, 64                 # Total columns (64 for a 64x64 display)

clear_column:
    sw $t1, 0($t2)             # Store black color at the current pixel
    addi $t2, $t2, 4           # Move to the next column (4 bytes per pixel)
    addi $t9, $t9, 1           # Increment column counter
    bne $t9, $t8, clear_column # Repeat until the end of the row

    # Move to the next row
    addi $t3, $t3, 1           # Increment row counter
    bne $t3, $t4, clear_row    # Repeat until all rows are cleared

    jr $ra                     # Return to caller
    
keyboard_input:
    # Get the ASCII code of the pressed key
    lw $a0, 4($t0)             # Load the ASCII code from the keyboard

    # Check which key was pressed
    beq $a0, 0x77, rotate       # 'w' for Rotate (ASCII 0x77)
    beq $a0, 0x73, move_down    # 's' for Move Down (ASCII 0x73)
    beq $a0, 0x61, move_left    # 'a' for Move Left (ASCII 0x61)
    beq $a0, 0x64, move_right   # 'd' for Move Right (ASCII 0x64)
    beq $a0, 0x71, quit         # 'q' for Quit (ASCII 0x71)
    
keyboard_input_exits:
    # also clears the block here
    li $t1, 0                  # Load black color (value 0) into $t1
    sw $t1, 0($s0)             # Store black color at the address in $s0
    sw $t1, 0($s1)             # Store black color at the address in $s1
    jr $ra                 # Return to game loop if no valid key is pressed
    
rotate:
    lw $t1, BLOCK_DIR           # Load current direction into $t1
    addi $t1, $t1, 1            # Increment by 1
    blt $t1, 4, skip_reset      # If $t1 < 4, skip resetting to 0
    li $t1, 0                   # Reset $t1 to 0 if it reaches 4

skip_reset:
    sw $t1, BLOCK_DIR           # Save the updated BLOCK_DIR back to memory

    # Check BLOCK_DIR
    li $t4, 0                   # Load constant 0 for comparison
    beq $t1, $t4, dir_0_adjust  # If BLOCK_DIR == 0, branch to dir_0_adjust
    li $t4, 1                   # Load constant 1 for comparison
    beq $t1, $t4, dir_1_adjust  # If BLOCK_DIR == 1, branch to dir_1_adjust
    li $t4, 2                   # Load constant 2 for comparison
    beq $t1, $t4, dir_2_adjust  # If BLOCK_DIR == 2, branch to dir_2_adjust
    li $t4, 3                   # Load constant 3 for comparison
    beq $t1, $t4, dir_3_adjust  # If BLOCK_DIR == 3, branch to dir_3_adjust

dir_0_adjust:
    #change the location by 1
    lw $t1, BLOCK_ROW2
    addi $t1, $t1, 1            # Increment the row
    sw $t1, BLOCK_ROW2           # Save the updated row
    lw $t1, BLOCK_COL2
    addi $t1, $t1, 1            # Increment the row
    sw $t1, BLOCK_COL2           # Save the updated row
    j skip_adjust               # Skip to the end

dir_1_adjust:
    #change the location by 1
    lw $t1, BLOCK_ROW2
    addi $t1, $t1, 1            # Increment the row
    sw $t1, BLOCK_ROW2           # Save the updated row
    lw $t1, BLOCK_COL2
    subi $t1, $t1, 1            # Increment the row
    sw $t1, BLOCK_COL2           # Save the updated row
    j skip_adjust               # Skip to the end

dir_2_adjust:
    #change the location by 1
    lw $t1, BLOCK_ROW2
    subi $t1, $t1, 1            # Increment the row
    sw $t1, BLOCK_ROW2           # Save the updated row
    lw $t1, BLOCK_COL2
    subi $t1, $t1, 1            # Increment the row
    sw $t1, BLOCK_COL2           # Save the updated row
    j skip_adjust               # Skip to the end

dir_3_adjust:
    #change the location by 1
    lw $t1, BLOCK_ROW2
    subi $t1, $t1, 1            # Increment the row
    sw $t1, BLOCK_ROW2           # Save the updated row
    lw $t1, BLOCK_COL2
    addi $t1, $t1, 1            # Increment the row
    sw $t1, BLOCK_COL2           # Save the updated row
    j skip_adjust               # Skip to the end

skip_adjust:
    j keyboard_input_exits          # Jump to the next part of the program


####################################################################################################
# Checking going down                 below                                                        #
####################################################################################################
move_down:
    # Step 1: Load current row, column, and orientation into $t1, $t2, and $t3
    lw $t1, BLOCK_ROW           # $t1 = BLOCK_ROW
    lw $t2, BLOCK_DIR           # $t2 = BLOCK_DIR
    lw $t3, BLOCK_COL           # $t3 = BLOCK_COL
    li $t4, 0x00000000
    lw $t0, ADDR_DSPL           # $t0 = ADDR_DSPL (base address of bitmap)
    
    sll $t6, $t1, 7             # $t6 = BLOCK_ROW * 128 (shift $t1 left by 7)
    sll $t7, $t3, 2             # $t7 = BLOCK_COL * 4 (shift $t3 left by 2)
    add $t6, $t6, $t7           # $t6 = row offset + column offset
    add $t6, $t6, $t0           # $t6 = $t6 + base address ($t0)


    # Step 2: Check orientation
    li $t5, 0                   # Load comparison value 0
    beq $t2, $t5, orientationD_0 # If BLOCK_DIR == 0, branch to orientation_0
    li $t5, 1                   # Load comparison value 1
    beq $t2, $t5, orientationD_1 # If BLOCK_DIR == 1, branch to orientation_1
    li $t5, 2                   # Load comparison value 2
    beq $t2, $t5, orientationD_2 # If BLOCK_DIR == 2, branch to orientation_2
    li $t5, 3                   # Load comparison value 3
    beq $t2, $t5, orientationD_3 # If BLOCK_DIR == 3, branch to orientation_3


orientationD_0:
    # Orientation 0: Calculate the address
    addi $t8, $t6, 128          # $straight underneath and one over
    addi $t9, $t6, 132          
    
    lw $t5, 0($t8)
    bne $t5, $t4, check_4
    lw $t5, 0($t9)
    bne $t5, $t4, check_4
    
    # Return to continue execution
    j skip_orientationD_check    # Skip to move_down logic


orientationD_1:
    # Orientation 1: Calculate the address
    addi $t9, $t6, 256          # $ 2 blocks under
    
    lw $t5, 0($t9)
    bne $t5, $t4, check_4
    
    # Return to continue execution
    j skip_orientationD_check    # Skip to move_down logic

orientationD_2:
    # Orientation 2: Calculate the address
    addi $t8, $t6, 124          # $straight underneath and one left
    addi $t9, $t6, 128          
    
    lw $t5, 0($t8)
    bne $t5, $t4, check_4
    lw $t5, 0($t9)
    bne $t5, $t4, check_4
    
    # Return to continue execution
    j skip_orientationD_check    # Skip to move_down logic

orientationD_3:
    # Orientation 3: Calculate the address
    addi $t9, $t6, 128          # straight underneath
    
    lw $t5, 0($t9)
    bne $t5, $t4, check_4
    
    # Return to continue execution
    j skip_orientationD_check    # Skip to move_down logic
    
store_to_reg_true:
    li $t1, 1                      # Load the value 1 into $t0
    la $t2, check_4           # Load the address of STORETOSTACK into $t1
    sw $t1, 0($t2)                 # Store the value 1 at the address of STORETOSTACK

skip_orientationD_check:

    # Step 1: Increment BLOCK_ROW
    lw $t1, BLOCK_ROW
    addi $t1, $t1, 1            # Increment the row
    sw $t1, BLOCK_ROW           # Save the updated row
    
    lw $t1, BLOCK_ROW2
    addi $t1, $t1, 1            # Increment the row
    sw $t1, BLOCK_ROW2           # Save the updated row

    # Step 4: Return to keyboard input handling
    j keyboard_input_exits      # Jump back to the keyboard input handling
    
check_4:
    
# Load BLOCK_DIR into $t0
    lw $t0, BLOCK_DIR          # Load the direction into $t0

# Branch based on BLOCK_DIR value
    li $t8, 0                  # Load 0 into $t8
    beq $t0, $t8, checkdir0    # If BLOCK_DIR == 0, go to checkdir0

    li $t8, 3                  # Load 3 into $t8
    beq $t0, $t8, checkdir3    # If BLOCK_DIR == 3, go to checkdir3

    # If BLOCK_DIR is not 0 or 3, do both checks
    j do_both

checkdir0:
    # Perform checkdir0 logic
    add $t1, $s0, $zero       # Load the value of $s0 into $t1
    addi $t2, $t1, 128        # $t2 = $t1 + 128
    addi $t3, $t2, 128        # $t3 = $t2 + 128
    addi $t4, $t3, 128        # $t4 = $t3 + 128

    lw $t5, 0($t1)            # Load the word at $t1 into $t5
    lw $t6, 0($t2)            # Load the color at $t2 into $t6
    bne $t6, $t5, checkdir3         # If $t6 != $t5, skip to end
    lw $t6, 0($t3)            # Load the color at $t3 into $t6
    bne $t6, $t5, checkdir3         # If $t6 != $t5, skip to end
    lw $t6, 0($t4)            # Load the color at $t4 into $t6
    bne $t6, $t5, checkdir3         # If $t6 != $t5, skip to end

    # If all match, set to black
    li $t7, 0                 # Load black color (value 0) into $t7
    sw $t7, 0($t1)            # Store black at $t1
    sw $t7, 0($t2)            # Store black at $t2
    sw $t7, 0($t3)            # Store black at $t3
    sw $t7, 0($t4)            # Store black at $t4
    j checkdir3                     # Jump to end

checkdir3:
    # Perform checkdir3 logic
    add $t1, $s1, $zero       # Load the value of $s1 into $t1
    addi $t2, $t1, 128        # $t2 = $t1 + 128
    addi $t3, $t2, 128        # $t3 = $t2 + 128
    addi $t4, $t3, 128        # $t4 = $t3 + 128

    lw $t5, 0($t1)            # Load the word at $t1 into $t5
    lw $t6, 0($t2)            # Load the color at $t2 into $t6
    bne $t6, $t5, end         # If $t6 != $t5, skip to end
    lw $t6, 0($t3)            # Load the color at $t3 into $t6
    bne $t6, $t5, end         # If $t6 != $t5, skip to end
    lw $t6, 0($t4)            # Load the color at $t4 into $t6
    bne $t6, $t5, end         # If $t6 != $t5, skip to end

    # If all match, set to black
    li $t7, 0                 # Load black color (value 0) into $t7
    sw $t7, 0($t1)            # Store black at $t1
    sw $t7, 0($t2)            # Store black at $t2
    sw $t7, 0($t3)            # Store black at $t3
    sw $t7, 0($t4)            # Store black at $t4
    j end                     # Jump to end

do_both:
    # Perform checkdir0 logic
    j checkdir0               # Jump to checkdir0 (it will continue to checkdir3 after end)

end:
    
reset_block:

    li $t1, 5
    sw $t1, BLOCK_ROW
    li $t1, 12
    sw $t1, BLOCK_COL
    li $t1, 0
    sw $t1, BLOCK_DIR
    li $t1, 5
    sw $t1, BLOCK_ROW2
    li $t1, 13
    sw $t1, BLOCK_COL2

jr $ra

   
####################################################################################################
# Checking going down      above                                                                   #
####################################################################################################


move_left:
    # Step 1: Load current row, column, and orientation into $t1, $t2, and $t3
    lw $t1, BLOCK_ROW           # $t1 = BLOCK_ROW
    lw $t2, BLOCK_DIR           # $t2 = BLOCK_DIR
    lw $t3, BLOCK_COL           # $t3 = BLOCK_COL
    li $t4, 0x00000000
    lw $t0, ADDR_DSPL           # $t0 = ADDR_DSPL (base address of bitmap)
    
    sll $t6, $t1, 7             # $t6 = BLOCK_ROW * 128 (shift $t1 left by 7)
    sll $t7, $t3, 2             # $t7 = BLOCK_COL * 4 (shift $t3 left by 2)
    add $t6, $t6, $t7           # $t6 = row offset + column offset
    add $t6, $t6, $t0           # $t6 = $t6 + base address ($t0)


    # Step 2: Check orientation
    li $t5, 0                   # Load comparison value 0
    beq $t2, $t5, orientationL_0 # If BLOCK_DIR == 0, branch to orientation_0
    li $t5, 1                   # Load comparison value 1
    beq $t2, $t5, orientationL_1 # If BLOCK_DIR == 1, branch to orientation_1
    li $t5, 2                   # Load comparison value 2
    beq $t2, $t5, orientationL_2 # If BLOCK_DIR == 2, branch to orientation_2
    li $t5, 3                   # Load comparison value 3
    beq $t2, $t5, orientationL_3 # If BLOCK_DIR == 3, branch to orientation_3


orientationL_0:
    # Orientation 0: Calculate the address         
    subi $t9, $t6, 4          # one to the left
    
    lw $t5, 0($t9)
    bne $t5, $t4, keyboard_input_exits
    
    # Return to continue execution
    j skip_orientationL_check    # Skip to move_down logic


orientationL_1:
    # Orientation 1: Calculate the address
    subi $t8, $t6, 4          # one to the left
    addi $t9, $t6, 124         # one underneath and one left
    
    lw $t5, 0($t8)
    bne $t5, $t4, keyboard_input_exits
    lw $t5, 0($t9)
    bne $t5, $t4, keyboard_input_exits
    
    # Return to continue execution
    j skip_orientationL_check    # Skip to move_down logic

orientationL_2:
    # Orientation 2: Calculate the address
    subi $t9, $t6, 8          # two to the left
    
    lw $t5, 0($t9)
    bne $t5, $t4, keyboard_input_exits
    
    # Return to continue execution
    j skip_orientationL_check    # Skip to move_down logic

orientationL_3:
    # Orientation 3: Calculate the address
    subi $t8, $t6, 4          # one to the left
    subi $t9, $t6, 124         # one above and one left
    
    lw $t5, 0($t8)
    bne $t5, $t4, keyboard_input_exits
    lw $t5, 0($t9)
    bne $t5, $t4, keyboard_input_exits
    
    # Return to continue execution
    j skip_orientationL_check    # Skip to move_down logic

skip_orientationL_check:
    # Step 1: Update BLOCK_COL
    lw $t1, BLOCK_COL           # Load current column
    subi $t1, $t1, 1            # Subtract 1 from the column
    sw $t1, BLOCK_COL           # Save the updated column
    
    lw $t1, BLOCK_COL2           # Load current column
    subi $t1, $t1, 1            # Subtract 1 from the column
    sw $t1, BLOCK_COL2           # Save the updated column

    # Step 4: Return to keyboard input handling
    j keyboard_input_exits      # Jump back to the keyboard input handling


move_right:
    # Step 1: Load current row, column, and orientation into $t1, $t2, and $t3
    lw $t1, BLOCK_ROW           # $t1 = BLOCK_ROW
    lw $t2, BLOCK_DIR           # $t2 = BLOCK_DIR
    lw $t3, BLOCK_COL           # $t3 = BLOCK_COL
    li $t4, 0x00000000
    lw $t0, ADDR_DSPL           # $t0 = ADDR_DSPL (base address of bitmap)
    
    sll $t6, $t1, 7             # $t6 = BLOCK_ROW * 128 (shift $t1 left by 7)
    sll $t7, $t3, 2             # $t7 = BLOCK_COL * 4 (shift $t3 left by 2)
    add $t6, $t6, $t7           # $t6 = row offset + column offset
    add $t6, $t6, $t0           # $t6 = $t6 + base address ($t0)


    # Step 2: Check orientation
    li $t5, 0                   # Load comparison value 0
    beq $t2, $t5, orientationR_0 # If BLOCK_DIR == 0, branch to orientation_0
    li $t5, 1                   # Load comparison value 1
    beq $t2, $t5, orientationR_1 # If BLOCK_DIR == 1, branch to orientation_1
    li $t5, 2                   # Load comparison value 2
    beq $t2, $t5, orientationR_2 # If BLOCK_DIR == 2, branch to orientation_2
    li $t5, 3                   # Load comparison value 3
    beq $t2, $t5, orientationR_3 # If BLOCK_DIR == 3, branch to orientation_3


orientationR_0:
    # Orientation 0: Calculate the address         
    addi $t9, $t6, 8          # two to the right
    
    lw $t5, 0($t9)
    bne $t5, $t4, keyboard_input_exits
    
    # Return to continue execution
    j skip_orientationR_check    # Skip to move_down logic


orientationR_1:
    # Orientation 1: Calculate the address
    addi $t8, $t6, 4          # one to the right
    addi $t9, $t6, 132         # one underneath and one rught
    
    lw $t5, 0($t8)
    bne $t5, $t4, keyboard_input_exits
    lw $t5, 0($t9)
    bne $t5, $t4, keyboard_input_exits
    
    # Return to continue execution
    j skip_orientationR_check    # Skip to move_down logic

orientationR_2:
    # Orientation 2: Calculate the address
    addi $t9, $t6, 4          # one to the right
    
    lw $t5, 0($t9)
    bne $t5, $t4, keyboard_input_exits
    
    # Return to continue execution
    j skip_orientationR_check    # Skip to move_down logic

orientationR_3:
    # Orientation 3: Calculate the address
    addi $t8, $t6, 4          # one to the right
    addi $t9, $t6, 124         # one above and one right
    
    lw $t5, 0($t8)
    bne $t5, $t4, keyboard_input_exits
    lw $t5, 0($t9)
    bne $t5, $t4, keyboard_input_exits
    
    # Return to continue execution
    j skip_orientationR_check    # Skip to move_down logic

skip_orientationR_check:
    # Step 1: Update BLOCK_COL
    lw $t1, BLOCK_COL           # Load current column
    addi $t1, $t1, 1            # Increment the column
    sw $t1, BLOCK_COL           # Save the updated column
    
    lw $t1, BLOCK_COL2           # Load current column
    addi $t1, $t1, 1            # Increment the column
    sw $t1, BLOCK_COL2           # Save the updated column

    # Step 4: Return to keyboard input handling
    j keyboard_input_exits      # Jump back to the keyboard input handling

    
quit:
    li $v0, 10                 # Syscall to terminate the program
    syscall
