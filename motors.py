from typing import ForwardRef
import RPi.GPIO as GPIO 
from gpiozero import Servo
#from gpiozero import Servo
from time import sleep
ServoIn = 21
servo = Servo(ServoIn)

GPIO.setwarnings(False)

class Motor():
    def __init__(self, Ena, In1, In2, ServoNum):
        self.Ena = Ena
        self.In1 = In1
        self.In2 = In2
        self.ServoNum = ServoNum
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(self.Ena, GPIO.OUT)
        GPIO.setup(self.In1, GPIO.OUT)
        GPIO.setup(self.In2, GPIO.OUT)
        self.pwm = GPIO.PWM(Ena, 100)
        self.pwm.start(0)
    
    def moveMotor(self, x=55, t=0):
        GPIO.output(self.In1, GPIO.LOW)  
        GPIO.output(self.In2, GPIO.HIGH)
        self.pwm.ChangeDutyCycle(100)
        sleep(0.6)
        print("moving engine")
        self.pwm.ChangeDutyCycle(x)
        servo.value = self.ServoNum
        sleep(0.6)
        sleep(t)
    
    def stopMotor(self, t=0):
        self.pwm.ChangeDutyCycle(0)
        servo.value = 0
        sleep(0.6)
        GPIO.cleanup()
        print("stopping engine")
        sleep(t)

#motor1 = Motor(22, 27, 17)
#motor1.moveMotor(x = 50, t = 3)
#motor1.stopMotor()
#motor2 = Motor(19, 6, 13)
#motor2.moveMotor(t = 5)
#motor2.stopMotor()