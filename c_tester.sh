#------------------------------------------------------------------#
#Author A simple program to check a C program expected output      #
# by redirecting the file with extension .in and comparing		     #
#with .out file													                           #
#------------------------------------------------------------------#
!bin/sh/
#PLEASE READ THE COMMENTS 

#Testing if the file has a .c extension
if test -e $1.c       #TEST TO SEE IF THE FILE EXIST
then
	gcc -o $1  $1.c 2>rich.text    #COMPILE AND SAVE THE RESULT IN A FILE(rename the file rich.text)
	if grep -q "error" rich.text   #CHECK IF THE FILE HAS THE WORD ERROR
	then 
	echo "Can't Compile"
else    #ADD THIS ELSE
	 
	for i in *.in  # FOR EVERY FILE THAT HAS .in NOTE : i is the counter
do
	trim=`basename $i .in`  	#trims the in #BASENAME IS A FUNCTION THAT STRIPS THE 00 FROM THE .in
	echo Running Test $trim 	 #PRINT RUNNING TEST $trim is 00 FOR THE FIRST RUN  		
	$1 < $trim.in  | diff - $trim.out   #COMPARE THE PROGRAM OUTPUT WITH THE INPUT USING DIFF COMMAND 

	if test $? -eq 0 #IF THE OUTPUT IS OK 
	then
	echo Test $trim passed    #PRINT $TRIM REMMEMBER IS THE NUMBER 
	else 
	echo Test $trim failed    #PRINT $TRIM FAILED
	fi	

	done

fi         #end of rich.text or ELSE

else 
	echo "File" $1.c "not found"    #CANT COMPILE
        exit 1
fi	 


