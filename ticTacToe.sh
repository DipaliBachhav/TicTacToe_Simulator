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

resetBoard
assignedLetter
checkWhoPlayFirst
