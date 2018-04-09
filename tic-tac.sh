#!/bin/bash
#tput cup Y X
define -a a
count=0
for((i=0;i<=100;i++))
do
	a[i]=0
done
position()
{
	tput cup 11 14    			#to set cursor position
	echo "1  2  3"
	tput cup 14 14
	echo "4  5  6"
	tput cup 17 14
	echo "7  8  9"
}	
tic_tac_board()
{
	tput clear					#clear the screen
	position             		#call position function
	tput cup 4 26
	tput rev
	echo "TIC TAC TOE GAME"
	tput sgr0
	tput cup 5 26
	echo "****************"
	#tput cup 10 25
	t="..................."
	t1="     "
	tput cup 9 25
	echo $t
	tput cup 10 25
	echo -e "|$t1|$t1|$t1|"
	tput cup 11 25
	echo -e "|$t1|$t1|$t1|"
	tput cup 12 25
	echo $t
	tput cup 13 25
	echo -e "|$t1|$t1|$t1|"
	tput cup 14 25
	echo -e "|$t1|$t1|$t1|"
	tput cup 15 25
	echo $t
	tput cup 16 25
	echo -e "|$t1|$t1|$t1|"
	tput cup 17 25
	echo -e "|$t1|$t1|$t1|"
	tput cup 18 25
	echo $t

}
menu()
{ 
    clear
	echo -e "1.start game\n2.quit the game\nenter your choice(1-2):"
	read ch
	case $ch in
		"1") tic_tac_board
		;;
		"2") exit
	    ;;
	    *) echo -e "wrong choice\ntry again"
			menu
		;;
	esac	
}
print()	
{
	case $1 in
		"1") tput cup 11 28
			 echo $2
			 ;;
		"2") tput cup 11 34
			 echo $2
			 ;;
		"3") tput cup 11 40
			 echo $2
			 ;;
		"4") tput cup 14 28 
			 echo $2
			 ;;
		"5") tput cup 14 34
			 echo $2
			 ;;
		"6") tput cup 14 40
			 echo $2
			 ;;
		"7") tput cup 17 28
			 echo $2
			 ;;
		"8") tput cup 17 34
			 echo $2
			 ;;
		"9") tput cup 17 40
			 echo $2
			 ;;	
    esac 	 	 	 
}
result()
{
	#checking the column row and diagonal match or not
	if(((${a[2]} == $1 && ${a[5]} == $1 && ${a[8]} == $1) || (${a[3]} == $1 && ${a[6]} == $1 && ${a[9]} == $1) || (${a[1]} == $1 && ${a[4]} == $1 && ${a[7]} == $1)))
        then

        tput cup 25 26
        echo "$2 wins.congrates!"
        return 1
    fi
    if((${a[1]} == $1 && ${a[2]} == $1 && ${a[3]} == $1 || ${a[4]} == $1 && ${a[5]} == $1 && ${a[6]} == $1 || ${a[7]} == $1 && ${a[8]} == $1 && ${a[9]} == $1))
        then
        tput cup 25 26
        echo "$2 wins.congrates!"
        return 1 
    fi
    if((${a[1]} == $1 && ${a[5]} == $1 && ${a[9]} == $1 || ${a[3]} == $1 && ${a[5]} == $1 && ${a[7]} == $1))
        then
        tput cup 25 26
        echo "$2 wins.congrates!"
        return 1
    fi
    if(($count==9))
    	then
    	tput cup 25 26
    	echo "---MATCH DRAW---"
    	return 2
    fi
}
check()
{

	if((${a[$1]}!=0))
		then
		tput cup 20 1
		echo "wrong input,try again"
		return 1
    elif(($1>9 || $1<1))
    	then
    	tput cup 20 1
    	echo "wrong input,try again"
    	return 1
    else
    	tput cup 20 1
    	echo "                     "
    	a[$1]=$2
    	count=$(echo "$count+1"|bc)
    	print $1 $3
    fi
}
playerX()
{
	tput cup 21 25
	echo -e "\033[2K"
	tput cup 21 25
	echo "X turn  enter position(1-9):"
	tput cup 21 53
	read n
	tput setaf 1      					#set the colour for input(X)  1 for red
	check $n 2 'X' 
	t=$?							#check the position that it is correct or not
	tput sgr0							#stop the input colour
	if((t==1))
		then
		playerX
	fi

}
playerO()
{
	tput cup 21 25
	echo -e "\033[2K"
	tput cup 21 25
	echo "O turn  enter position(1-9):"
	#echo "enter position:"
	tput cup 21 53
	read n
	tput setaf 4     #set the colour for O
	check $n 3 'O'
	t=$?
	tput sgr0
	if((t==1))
		then
		playerO
	fi
} 
replay()
{  
	count=0
	for((i=0;i<=100;i++))
	do
		a[i]=0
	done
	tput cup 29 26
	echo "1.play again"
	tput cup 30 26
	echo "2.exit the game"
	tput cup 31 26
	echo "enter choice(1-2): "
	tput cup 32 26
	read chh
	case $chh in
		"1") maingame
			 ;;
		"2") exit
		     ;;
    esac	 	
}
maingame()
{
	tput cup 0 0
 	menu
	while(($count!=9))
	do
		playerX
		result 2 'X'
		t=$?
		if(($t==1))
			then
			replay
		fi
		if(($t==2))
			then
			replay
		fi
		playerO
		result 3 'O'
		t=$?
		if(($t==1))
			then
			replay
		fi
		if(($t==2))
			then
			replay
		fi
	done
}
maingame






