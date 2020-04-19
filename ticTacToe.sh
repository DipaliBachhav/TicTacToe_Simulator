#!/bin/bash -x
echo "Welcome To TicTacToe Simulator...."

position=9
player='X'
computer='O'
function resetBoard()
{
	for (( i=0; i<=$position; i++ ))
	do
		board[$i]="-"
	done
}

function assignedLetter()
{
	echo "Letter Assigned To Player := " $player
	echo "Letter Assigned To Computer := " $computer
}

function checkWhoPlayFirst()
{
	random=$(( RANDOM%2 ))
	if [[ $random -eq 1 ]]
	then
		echo "Player Play First"
	else
		echo "Computer Play First"
	fi
}

function printBoard()
{
	echo " --------------"
	echo " | "${board[1]}" | "${board[2]}" | "${board[3]}" | "
	echo " --------------"
	echo " | "${board[4]}" | "${board[5]}" | "${board[6]}" | "
	echo " --------------"
	echo " | "${board[7]}" | "${board[8]}" | "${board[9]}" | "
	echo " --------------"
}

function checkHorizontalCase(){
	if [ $winner == false ]
	then
		numberOfRows=3
		position=1
		counter=1
		while [ $counter -le $numberOfRows ]
		do
			if [[ ${board[$position]} == ${board[$position+1]} ]] && [[ ${board[$position+1]} == ${board[$position+2]} ]] && [[ ${board[$position+2]} == ${board[$position]} ]] && [[ ${board[$position]} == $1 ]]
			then
				printBoard
				echo "$1 wins Horizontal"
				winner=true
				break
			else
				position=$(( $position+$numberOfRows ))
			fi
		counter=$(( $counter+1 ))
		done
	fi
}
function checkVerticalCase(){
	if [ $winner == false ]
	then
		numberOfColumns=3
		position=1
		counter=1
		while [ $counter -le $numberOfColumns ]
		do
			if [[ ${board[$position]} == ${board[$position+3]} ]] && [[ ${board[$position+3]} == ${board[$position+6]} ]] && [[ ${board[$position+6]} == ${board[$position]} ]] && [[ ${board[$position]} == $1 ]]
			then
				printBoard
				echo "$1 wins Vertical"
				winner=true
				break
			else
				position=$(( $position+1))
			fi
		counter=$(( $counter+1 ))
		done
	fi
}
function checkDiagonalCase(){
	if [ $winner == false ]
	then
		position=1
		if [[ ${board[$position]} == ${board[$position+4]} ]] && [[ ${board[$position+4]} == ${board[$position+8]} ]] && [[ ${board[$position+8]} == ${board[$position]} ]] && [[ ${board[$position]} == $1 ]]
			then
				printBoard
				echo "$1 wins Diagonal"
				winner=true
		elif [[ ${board[$position+2]} == ${board[$position+4]} ]] && [[ ${board[$position+4]} == ${board[$position+6]} ]] && [[ ${board[$position+6]} == ${board[$position+2]} ]] && [[ ${board[$position+2]} == $1 ]] 
			then
				printBoard
				echo "$1 wins Diagonal"
				winner=true
		fi
	fi
}

function userInput(){
	row=1
	column=3
	echo "user is playing"
	read -p "Enter position in between 1-9: " position
	if [[ ${board[$position]} == $tail ]]
	then
		echo "player turn"
		board[$position]=$player
		turn=$(( $turn+1 ))
	else
		echo "Invalid input"
		userInput
	fi
	playerTurn=false
}

resetBoard
assignedLetter
checkWhoPlayFirst

