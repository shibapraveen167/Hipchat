This project takes a chat message string and returns a JSON string containing information about its contents like emoticons, mentions and links.
For e.g. 
For
Input: "@Anil Happy Birthday!"
Return (string):

{ "mentions": [ "Anil" ] }

Input: "Good morning! (coffee)"
Return (string):

{ "emoticons": [ "coffee" ] }
