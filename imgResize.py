
import os
from subprocess import call
import shutil
import sys, getopt

dpiArray=["drawable-mdpi", "drawable-hdpi", "drawable-xhdpi",
          "drawable-xxhdpi", "drawable-xlarge-mdpi"]
dpiSizeArray=[1, 1.5, 2, 3,2]

inpath="!_src/"

def reCreateDirs():
    for file in dpiArray:
        if os.path.exists(file):
            shutil.rmtree(file)
        os.makedirs(file)

reCreateDirs();

height = 0
wight = 0


if len(sys.argv) != 3:
    print "Need 2 arg"
    sys.exit(-1)
else:
    if sys.argv[1] == "w":
       wight = int(sys.argv[2])
       height = 0;
    elif sys.argv[1] == "h":
       height = int(sys.argv[2])
       wight = 0;
    else:
        print "Unknown arg " +sys.argv[1] 
        sys.exit(-1)
    
print "Start..."
i = 0
for folder in dpiArray:
    sizeH = dpiSizeArray[i] * height
    sizeW = dpiSizeArray[i] * wight
    i += 1
    commands = ["nconvert.exe", "-out","png","-o",folder+"/%","-ratio",
                "-quiet","-resize",str(sizeW), str(sizeH), inpath+"*.*"]
#    print ' '.join(commands)
    call(commands)
print "Success!"
