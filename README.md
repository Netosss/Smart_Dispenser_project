# smart_dispenser
project story : "Migdal Or" is an organization who employs people with visual impairments. Most of the work at the comapny combines work with a various of machines and each one using diffrent screws set and amounts. They find it difficult to count the screws and it is very difficult to distinguish between them.
In order to invent a solution to this problem, we built a robot who will receive a stack of screws and transfer them to various labeled containers according to identification and the needed amount.

As part of the robot creation process we have written useful code snippets that we will present here in the repostory.

# How it's work?

As you can see at the system diagram below, our proccess start's at the edge user. The user can define the amouts of screws from each type that he would like to get at the application, than our system read the amounts from the fire base (wi-fi is needed). when the data arrive we start to vibrate the screws to the camera area (using DC-motor) in order to count the objects, (on the counting proccess you will read at the next paragraph.) At the end we are direct the object to the suitable box by using servo motor.
![system diagram sd](https://user-images.githubusercontent.com/92423203/167307712-e646ae8e-e858-4979-b002-c172261a3f6f.jpg)



# How we make the counting?
Computer vision is fantastic. With this resource, a computer system "learns to see" and, with that, perform increasingly complex and useful tasks in modern day-to-day life, such as: identifying objects, identifying people and/or faces, recognizing objects and obtaining characteristics from them. , determine movement of objects, measure speed of objects, and so on. And the computer system in question can be a common Single-Board Computer , like a Raspberry Pi, for example.

In this project, a use of the Raspberry Pi in computer vision will be shown: based on OpenCV and Python, allow counting of moving objects using computer vision. (mainly with contour and tracking algorithm).

![](https://www.embarcados.com.br/wp-content/uploads/2017/08/GIFAnimadoProjetoContagem.gif)
