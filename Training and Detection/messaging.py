from twilio.rest import Client 

account_sid = 'AC9807e8964cc05794c3de4f37c190247b' 
auth_token = '99e4c8c71fb32a756d89db6ef9ecfbf9' 
client = Client(account_sid, auth_token) 

message = client.messages.create( 
                              from_='whatsapp:+14155238886',  
                              body='ALERT a animal was detected!!\nReply with FALSE to tell system about false positives',
                              media_url="https://i.ibb.co/6tVPT59/Hospital.jpg",
                              to='whatsapp:+919324133348' 
                          ) 
 
print(message.sid)