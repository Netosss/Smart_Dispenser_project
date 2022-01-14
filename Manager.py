from EngineManager import *
from firebaseManager import *
from cameraManager import *
import threading
import time
import signal
from gpiozero import Button

class Manager:
    def __init__(self):
        self.engine_manager = EnginesManager()
        self.fire_base_con = FireBaseManager()
        self.con_success = self.fire_base_con.Connect() #here we continue only if base got the amounts
        self.success=True
        if self.con_success == False:
            #here we decide what to do in case of connection failure
            print("Connection failed or unsupport amounts was given")
            self.success=False
            return
        self.Camera = Camera()
        self.amounts = self.fire_base_con.amountList #return amounts in list accordingly
        self.engine_manager.StartSlider() #start vibration on slider
        sleep(2) #wait 2 seconds for stablization 
        
    def Type_Counting(self,number):
        print("start counting type_a, the given amount is: {}".format(self.amounts[number]))
        self.engine_manager.startEngine(number)
        self.Camera.Counting(self.amounts[number]) #wait to the camera finish counting
        self.engine_manager.stopEngine(number)
 
if __name__ == '__main__':
    button = Button(ButtonIn)
    button.wait_for_press()
    manager=Manager()
    if manager.success==True:
        for i in range(len(manager.amounts)):
            manager.Type_Counting(i)
            sleep(5)
        manager.engine_manager.StopSlider() #start vibration on slider
