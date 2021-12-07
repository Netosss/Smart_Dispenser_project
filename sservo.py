import RPi.GPIO as GPIO 
from gpiozero import Servo
from time import sleep
flipperIn = 17
In1 = 27
Ena = 16
In2 = 22
Enb = 21
In4 = 26
In3 = 20

#Engine manager is manages two feeders and 1 servo(flipper).
###Today 30.11 the machines work with some help, what means you need to help feeder number 1 with roll it at start, and help servo
###	with tight his wires. 

class EnginesManager:
	def __init__(self):
		GPIO.setmode(GPIO.BCM)
		GPIO.setup(In1, GPIO.OUT)
		GPIO.setup(Ena, GPIO.OUT)
		GPIO.setup(In2, GPIO.OUT)
		GPIO.setup(In4, GPIO.OUT)
		GPIO.setup(Enb, GPIO.OUT)
		GPIO.setup(In3, GPIO.OUT)
		self.p = GPIO.PWM(In2, 7000)
		self.p2 = GPIO.PWM(Enb, 7000)
		self.servo = Servo(flipperIn)
		self._servoVal = 1
		self.servo.value = self._servoVal
	#engine num is the number of the machine , wooden is 1
	def startEngine(self, EngineNum):
		print('starting engine num: ', EngineNum)
		if EngineNum == 1:
			GPIO.output(In1, GPIO.HIGH)
			GPIO.output(Ena, GPIO.HIGH)
			self.p.start(1)
		elif EngineNum == 2:
			GPIO.output(In3, GPIO.HIGH)
			GPIO.output(In4, GPIO.HIGH)
			self.p2.start(1)
   	#engine num is the number of the machine , wooden is 1
	def stopEngine(self, EngineNum):
		print('stopping engine num:', EngineNum)
		if EngineNum == 1:
			GPIO.output(In1, GPIO.LOW)
			GPIO.output(Ena, GPIO.LOW)
			self.p.stop()
		elif EngineNum == 2:
			GPIO.output(In3, GPIO.LOW)
			GPIO.output(In4, GPIO.LOW)
			self.p2.stop()
   #1 is straight(wire direction) and -1 is right, initilized to staright 
	def Flip(self):
		if self._servoVal == 1:
			self._servoVal = -1
		else:
			self._servoVal = 1
		self.servo.value = self._servoVal
		print('flipped! val: ', self._servoVal )
       

def main():
	print('started!!')
	manager = EnginesManager()
	#manager.Flip()
	#sleep(2)
	#manager.Flip()
	#sleep(2)
	#manager.Flip()
	manager.startEngine(1)
	sleep(5)
	manager.stopEngine(1)
	sleep(5)
	manager.startEngine(2)
	sleep(5)
	manager.stopEngine(2)
	manager.Flip()
	sleep(6)
	manager.Flip()
	sleep(6)



#servo = Servo(17)

#val = -1
#while True:
#	servo.value = val
#	sleep(5)
#	val = val+ 2
#	if val > 1 :
#		val = -1
if __name__ == '__main__':
    	main()
	