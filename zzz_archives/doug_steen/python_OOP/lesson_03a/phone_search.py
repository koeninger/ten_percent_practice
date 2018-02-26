#!/usr/bin/env python

from twilio.rest import Client

# Your Account SID from twilio.com/console
account_sid = "ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
# Your Auth Token from twilio.com/console
auth_token  = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

client = Client(account_sid, auth_token)

numbers = client.available_phone_numbers("US") \
                .local \
                .list(area_code="512")

# Purchase the phone number
number = client.incoming_phone_numbers \
               .create(phone_number=numbers[0].phone_number)

print(number.sid)
