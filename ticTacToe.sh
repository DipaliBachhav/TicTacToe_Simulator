#!/bin/bash -x
echo "Welcome To TicTacToe Simulator...."

tail='-'
boardPosition=10
player='X'
computer='O'
nonEmptyCount=1
numberOfColumns=3
numberOfRows=3
boardPosition=10
playerTurn=false
winner=false
turn=0
computerP=0
playerP=0
winMove=false

function resetBoard()
{
	for (( i=0; i<=$boardPosition; i++ ))
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

function computerInput(){
	row=1
	column=3
	playerTurn=false
	echo "computer is playing"
	checkWinningMove $row $column
	checkWinningMove $column $row
	checkWinningMovePlayer $row $column
        checkWinningMovePlayer $column $row

	cornerCheck
	centerCheck
	sideCheck
	position=$(( (RANDOM%9)+1 ))
	if [[ $winMove == false ]] && [[ $playerTurn == false ]]
	then
		if [[ ${board[$position]} == $tail ]]
		then
			board[$position]=$computer
			printBoard
		else
			echo "Invalid input"
			computerInput
		fi
	fi
	playerTurn=true
}


function checkWinningMove(){
	if [[ $winMove == false ]]
	then
	counter=1
	for (( i=1;i<=3;i++))
	do
		if [[ ${board[$counter]} == ${board[$counter+$1+$1]} ]] && [[ ${board[$counter+$1]} == $tail ]] && [[ ${board[$counter]} == $computer ]] 
		then
			computerP=$(( $counter+$1 ))
			echo "winning move is ."$computrP
			board[$computerP]=$computer
			printBoard
			winMove=true
			playerTurn=true
			break
		elif [[ ${board[$counter]} == ${board[$counter+$1]} ]] && [[ ${board[$counter+$1+$1]} == $tail ]] && [[ ${board[$counter]} == $computer ]]
		then
			computerP=$(( $counter+$1+$1 ))
			echo "winning move is .."$computrP
			board[$computerP]=$computer
			printBoard
			winMove=true
			playerTurn=true
			break
		elif [[ ${board[$counter+$1]} == ${board[$counter+$1+$1]} ]] && [[ ${board[$counter]} == $tail ]] && [[ ${board[$counter+$1]} == $computer ]]
		then
			computerP=$counter
			echo "winning move is ..."$computrP
			board[$computerP]=$computer
			printBoard
			winMove=true
			playerTurn=true
			break
		fi
	counter=$(( $counter+$2 ))
	done
	fi
}

function checkWinningMovePlayer(){
	counterPlayer=1
	if [[ $playerTurn == false ]]
	then
	for (( i=1;i<=3;i++))
	do
		if [[ ${board[$counterPlayer]} == ${board[$counterPlayer+$1+$1]} ]] && [[ ${board[$counterPlayer+$1]} == $tail ]] && [[ ${board[$counterPlayer]} == $player ]] 
		then
			playerP=$(( $counterPlayer+$1 ))
			echo "blocking move is "$playerP
			board[$playerP]=$computer
			playerTurn=true
			break
		elif [[ ${board[$counterPlayer]} == ${board[$counterPlayer+$1]} ]] && [[ ${board[$counterPlayer+$1+$1]} == $tail ]] && [[ ${board[$counterPlayer]} == $player ]]
		then
			playerP=$(( $counterPlayer+$1+$1 ))
			echo "blocking move is "$playerP
			board[$playerP]=$computer
			playerTurn=true
			break
		elif [[ ${board[$counterPlayer+$1]} == ${board[$counterPlayer+$1+$1]} ]] && [[ ${board[$counterPlayer]} == $tail ]] && [[ ${board[$counterPlayer+$1]} == $player ]]
		then
			playerP=$counterPlayer
			echo "blocking move is "$playerP
			board[$playerP]=$computer
			playerTurn=true
			break
		fi
	counterPlayer=$(( $counterPlayer+$2 ))
	done
	fi
}

function cornerCheck(){
	if [[ $winMove == false ]] && [[ $playerTurn == false ]]
	then
		for ((i=1;i<boardPosition;i=$(($i+2)) ))
		do
			if [[ ${board[$i]} == '-' ]]
			then
				echo "Corner move"
				computerP=$i
				board[$computerP]=$computer
				printBoard
				playerTurn=true
				break
			fi
			if [ $i -eq 3 ]
			then
				i=$(($i+2))
			fi
		done
	fi
}

function centerCheck(){
	center=5
	if [[ $winMove == false ]] && [[ ${board[$center]} == $tail ]] && [[ $playerTurn == false ]]
	then
		echo "Center move"
		computerP=$center
		board[$computerP]=$computer
		printBoard
		playerTurn=true
	fi
}

resetBoard
assignedLetter
checkWhoPlayFirst

while [[ $winner == false ]]
do
	printBoard
	if [[  $playerTurn == true ]]
	then
		userInput
		checkHorizontalCase $player
		checkVerticalCase $player
		checkDiagonalCase $player
		checkTieCase $player
		playerTurn=false
	else
		computerInput
		checkHorizontalCase $computer
		checkVerticalCase $computer
		checkDiagonalCase $computer
		checkTieCase $computer
		playerTurn=true
	fi
done
