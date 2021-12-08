import RPi.GPIO as GPIO 

from time import sleep
from motors import *
flipperIn = 21
Ena = 22
In1 = 27
In2 = 17
Enb = 19
In4 = 6
In3 = 13

#Engine manager is manages two feeders and 1 servo(flipper).
###Today 30.11 the machines work with some help, what means you need to help feeder number 1 with roll it at start, and help servo
###	with tight his wires. 

class EnginesManager:
	def __init__(self):
		#self.servo = None
		self.motor1 = None
		self.motor2 = None
	#engine num is the number of the machine , wooden is 1
	def startEngine(self, EngineNum, x=55, t=0):
		print('starting engine num: ', EngineNum)
		if EngineNum == 1:
			#self.servo = Servo(flipperIn)
			#self.servo.value = -1
			self.motor1 = Motor(Ena, In1, In2, 1)
			self.motor1.moveMotor(t=t, x=x)
		elif EngineNum == 2:
			#self.servo = Servo(flipperIn)
			#self.servo.value = 1
			self.motor2 = Motor(Enb, In4, In3, -1)
			self.motor2.moveMotor(t=t, x=x)
   	#engine num is the number of the machine , wooden is 1
	def stopEngine(self, EngineNum):
		print('stopping engine num:', EngineNum)
		if EngineNum == 1:
			if self.motor1 is not None:
				#self.servo.value = 0
				#self.servo.detach()
				self.motor1.stopMotor()
		elif EngineNum == 2:
			if self.motor2 is not None:
				#self.servo.value = 0
				#sleep(2)
				#self.servo.detach()
				self.motor2.stopMotor()

   #1 is straight(wire direction) and -1 is right, initilized to staright 
	def Flip(self):
		GPIO.setmode(GPIO.BCM)
		GPIO.input(flipperIn)
		self.servo = Servo(flipperIn)
		if self._servoVal == 1:
			self._servoVal = -1
		else:
			self._servoVal = 1
		self.servo.value = self._servoVal
		print('flipped! val: ', self._servoVal )
		self.servo.detach()
		GPIO.cleanup()
       

def main():
	print('started!!')
	#GPIO.cleanup()
	manager = EnginesManager()
	#manager.Flip()
	#sleep(2)
	#manager.Flip()
	#sleep(2)
	#manager.Flip()
	manager.startEngine(2, x=65, t=5)
	#sleep(2)
	manager.stopEngine(2)
	#sleep(5)
	manager.startEngine(1, x=100, t=5)
	manager.stopEngine(1)
	#manager.Flip()
	#sleep(2)
	#manager.Flip()
	#sleep(2)
	




if __name__ == '__main__':
    	main()
	