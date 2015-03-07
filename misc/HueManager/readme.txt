the file "light.php" is a simple manager to control the Philips Hue smart bulbs.

The hub was plugged directly into a Macbook's ethernet port and was assigned IP address 192.168.2.2 which is hardcoded in the script.
 	
It assumes that the hub has already been provisioned per the instructions described at http://rsmck.co.uk/hue

For our demo, once provisioned, we had the userID of "newdeveloper", giving us an addressable light that looked like:

http://192.168.2.2/api/newdeveloper/lights/2/state

where "2" would be light number 2 in the control array, for example.

