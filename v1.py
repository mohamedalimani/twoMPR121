import serial 
import time

arduino = serial.Serial(port='COM3',baudrate=9600,timeout=.1)
while True:
	data = arduino.readline()
	x = data.decode("utf-8")
	if len(x) > 1:
		print(x)