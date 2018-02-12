#!/usr/bin/env python

from twilio.rest import Client

# Your Account SID from twilio.com/console
account_sid = "ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
# Your Auth Token from twilio.com/console
auth_token  = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

client = Client(account_sid, auth_token)

message = client.messages.create(
    to="+1512xxxxxxx",              # personal phone #
    from_="+1737xxxxxxx",           # twilio phone #
    body="Hello from Python!")

print(message.sid)
