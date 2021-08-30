# u need to import pySerial to use this code 
import serial
import os.path

#entities declaration 
arduino = serial.Serial(port='COM3',baudrate=9600,timeout=.1)
pointId = 1
title = "history"
fileId = 1 
fileName = "history1.txt"

# generate new log file with different name than the previous ones
while os.path.isfile(fileName):
	fileId = fileId + 1
	fileName = title + str(fileId) + ".txt"
f = open(fileName,"x")

#read, decode and write data sent via serial into log file 
f.write("\nUSER TOUCHED THE SENSORS AT THESE COORDINATES :\n")
f.write("-------------------------------------------------\n")
f.write("point n: X Y \n")
f.write("-------------------------------------------------\n")
while True:
	data = arduino.readline()
	x = data.decode("utf-8")
	if len(x) > 1:
		f.write("point "+str(pointId)+": "+str(x))
		print(x)
		pointId += 1
