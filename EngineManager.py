import RPi.GPIO as GPIO 
from time import sleep
from motors import *
from gpiozero import Button

#defines for flipper usage:
angle0 = 5
angle1 = 32
defaultAngle = 55 

#gpio defines:
ButtonIn = 21
ServoMotorIn = 4
Ena = 22
In1 = 27
In2 = 17
Enb = 26
In4 = 19
In3 = 13
Enc = 6
In5 = 5
In6 = 12


#Engine manager is manages two feeders and 1 servo(flipper).
###Today 30.11 the machines work with some help, what means you need to help feeder number 1 with roll it at start, and help servo
###	with tight his wires. 

class EnginesManager:
	def __init__(self):
		#self.servo = None
		self.motor1 = None
		self.motor2 = None
		self.motor3 = None
	#engine num is the number of the machine , wooden is 1
	def startEngine(self, EngineNum, x=25, t=0):
		print('starting engine num: ', EngineNum)
		if EngineNum == 0:
			self.motor1 = Motor(Ena, In1, In2)
			self.motor1.moveMotor(t=t, x=x)
			self.Flip(angle0)
		elif EngineNum == 1:
			self.motor2 = Motor(Enb, In4, In3)
			self.motor2.moveMotor(t=t, x=x)
			self.Flip(angle1)
		elif EngineNum == 2:
			self.motor3 = Motor(Enc, In5, In6)
			self.motor3.moveMotor(t=t, x=x)
			self.Flip(defaultAngle)
   
   	#engine num is the number of the machine , wooden is 1
	def stopEngine(self, EngineNum):
		print('stopping engine num:', EngineNum)
		if EngineNum == 0:
			if self.motor1 is not None:
				self.motor1.stopMotor()
		elif EngineNum == 1:
			if self.motor2 is not None:
				self.motor2.stopMotor()
		elif EngineNum == 2:
			if self.motor3 is not None:
				self.motor3.stopMotor()
		sleep(0.6)
		self.Flip(defaultAngle)
   #1 is straight(wire direction) and -1 is right, initilized to staright
	
	def Flip(self, angle):
		servo = ServoMotor(ServoMotorIn)
		servo.SetAngle(angle)
		#servo.stopServo()
		#print('flipped! val: ', self._servoVal )
		#self.servo.detach()

	def StartSlider(self):
		self.startEngine(2, x=20)
  
	def StopSlider(self):
    		self.stopEngine(2)
       
def StartMotor(gpio, t=1):
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(gpio, GPIO.OUT)
    GPIO.output(gpio, GPIO.HIGH)
    sleep(t)
    #GPIO.output(gpio, GPIO.LOW)
    #GPIO.cleanup()


# 5,32,55
def main():
# 	# print('starting!!')
# 	button = Button(ButtonIn)
# 	button.wait_for_press()
# 	#GPIO.cleanup()
		manager = EnginesManager()
		manager.Flip(angle1)
	# manager.Flip(5)
# 	# sleep(2)
# 	# manager.Flip(32)
# 	# sleep(2)
# 	# manager.Flip(55)
# 	# sleep(2)
# 	manager.StartSlider()
# 	#manager.StopSlider()
# 	#manager.startEngine(2, x=20, t=2)
# 	#manager.stopEngine(3)
# 	# manager.Flip(0)
# 	#StartMotor(MotorIn, 5)
# 	manager.startEngine(0, x=24)
# 	manager.stopEngine(0)
# 	# manager.Flip(33)
# 	#sleep(5)
# 	manager.startEngine(1, x=30)
# 	manager.stopEngine(1)
# 	manager.StopSlider()
# 	# manager.stopEngine(0)
# 	# manager.Flip(60)
# 	#sleep(2)
# 	#sleep(2)
# 	GPIO.setmode(GPIO.BCM)
	




if __name__ == '__main__':
    	main()
	
