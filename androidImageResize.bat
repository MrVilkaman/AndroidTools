if [ -z "$1" ] ; then 
 	echo "Error argument!" 
	exit 0
fi
dpiArray=("drawable-mdpi" "drawable-hdpi" "drawable-xhdpi" "drawable-xxhdpi" "drawable-xlarge-mdpi")
dpiSizeArray=(2 3 4 6 4)

inpath="!_src/"
height=0
wight=0
onlyclear=0
while [ 1 ] ; do 
	if [ "$1" = "-h" ] ; then 
      shift ; height="$1" 
	elif [ "$1" = "-w" ] ; then 
      shift ; wight="$1" 
	elif [ "$1" = "-d" ] ; then 
      shift ; inpath="$1" 
	elif [ "$1" = "-clear" ] ; then 
      shift ; onlyclear=1 
	elif [ -z "$1" ] ; then 
      break 
	else 
		expr $1 : '-\?[0-9]\+$' >/dev/null &&
		  height="$1" && wight=0 && break  ||
		echo "unknown param $1" 
		exit 0
		
	fi 
	shift 
done 

rm -r ${dpiArray[*]} 
expr $onlyclear = 1  >/dev/null  &&
echo "Done!" && exit 0

if [ ! -d "$inpath" ]; then
echo "$inpath doesn't exist."
exit -1
fi

mkdir ${dpiArray[*]}

echo "Start..."
for (( i = 0; i < ${#dpiArray[@]}; i++ )); do
sizeH=$((${dpiSizeArray[$i]} * $height /2))
sizeW=$((${dpiSizeArray[$i]} * $wight /2))
nconvert.exe  -out png -o "${dpiArray[$i]}/%" -ratio -quiet -resize $sizeW $sizeH $inpath*.png 
done
echo "Success!"
