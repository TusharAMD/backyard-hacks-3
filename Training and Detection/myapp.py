import numpy as np
import cv2 
cap = cv2.VideoCapture(0)
import os
import base64
import requests

from twilio.rest import Client 
account_sid = 'AC9807e8964cc05794c3de4f37c190247b' 
auth_token = '99e4c8c71fb32a756d89db6ef9ecfbf9' 
client = Client(account_sid, auth_token) 

while True:

    ret, frame = cap.read()

    cv2.imshow('frame', frame)
    cv2.imwrite("myimg.jpg", frame)
    if cv2.waitKey(1) == ord('q'):
        break
    os.system("python tools/infer.py --weights runs/train/exp/weights/best_ckpt.pt --source myimg.jpg --yaml data/dataset.yaml --device 0 --save-txt")
    f = open('D:/SIH/yolo/YOLOv6-on-Custom-Dataset/YOLOv6/runs/inference/exp/labels/myimg.txt', 'r')
    content = f.readlines()
    #print(content[-1][0])
    animals = ["Florida Panther","Badger","Wolf","Koala","Squirrel"]
    try:
        if content[-1][0] == "0":
            print("Detected a Florida Panther")
        elif content[-1][0] == "1":
            print("Detected a Badger")
        elif content[-1][0] == "2":
            print("Detected a Wolf")
        elif content[-1][0] == "3":
            print("Detected a Koala")
        elif content[-1][0] == "4":
            print("Detected a Squirrel")
    except:
        pass
    f.close()
    f = open('D:/SIH/yolo/YOLOv6-on-Custom-Dataset/YOLOv6/runs/inference/exp/labels/myimg.txt', 'w')
    f.write("")
    f.close()
    
    with open("D:/SIH/yolo/YOLOv6-on-Custom-Dataset/YOLOv6/runs/inference/exp/myimg.jpg", "rb") as file:
        url = "https://api.imgbb.com/1/upload"
        payload = {
            "key": "fb13020baf1e55ab0f8abe7be3834531",
            "image": base64.b64encode(file.read()),
        }
        res = requests.post(url, payload)
    img_url = res.json()["data"]["url"]
    ## TWILIO
    try:
        message = client.messages.create( 
                                  from_='whatsapp:+14155238886',  
                                  body=f'ALERT a {animals[int(content[-1][0])]} was detected!!\nReply with FALSE to tell system about false positives',
                                  media_url=img_url,
                                  to='whatsapp:+919324133348' 
                              )
        print(message.sid)
    except:
        pass
 
    
cap.release()
cv2.destroyAllWindows()