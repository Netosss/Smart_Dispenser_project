import pyrebase

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    firebaseConfig = {
        'apiKey': "AIzaSyC1hNRnNx4zPS4lU9hRugfx3OlX7BD4sN8",
        'authDomain': "smartdispenser-9043d.firebaseapp.com",
        'databaseURL': "https://smartdispenser-9043d-default-rtdb.firebaseio.com",
        'projectId': "smartdispenser-9043d",
        'storageBucket': "smartdispenser-9043d.appspot.com",
        'messagingSenderId': "1059644042677",
        'appId': "1:1059644042677:web:fe599989918df767557dfc",
        'measurementId': "G-1V8PC6SFH1"
    }

    firebase = pyrebase.initialize_app(firebaseConfig)

    db = firebase.database()
    updating = False
    while not updating:
        updating = db.child("elements").get().val().get("done_updating")
        continue
    parent = db.child("elements")
    temp = parent.get().val()
    amount = temp.get("amount")
    users_list = []
    for i in range(amount):
        cur_user = "elements/element" + str(i)
        users_list.append(db.child(cur_user).get())
    for user in users_list:
        print(user.val().get("quantity"))
    db.child("elements").update({"done_updating": False})

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
