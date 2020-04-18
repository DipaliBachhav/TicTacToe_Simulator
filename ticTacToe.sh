#!/bin/bash -x
echo "Welcome To TicTacToe Simulator...."

position=9
function resetBoard()
{
	for (( i=0; i<=$position; i++ ))
	do
		board[$i]="-"
	done
}

resetBoard

