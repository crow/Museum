<?php

$IP="192.168.2.2";
$APPID="newdeveloper";

$data = "{";

$light = $_GET["light"];
$comma = 0;

if ($hue = $_GET["color"]) {
$data = $data . "\"hue\":" . $hue;
$comma = 1;
echo "what?";
}

if ($sat = $_GET["sat"]) {
if ($comma == 1) {$data = $data . ",";} else {$comma = 1;};
$data = $data . "\"sat\":" . $sat;
}
if ($trans = $_GET["trans"]) {
if ($comma == 1) {$data = $data . ",";} else {$comma = 1;};
$data = $data . "\"transitiontime\":" . $trans;	
//Transition time in 1/10ths of a second. 0 = snap. 
}

if ($bri = $_GET["bri"]) {
if ($comma == 1) {$data = $data . ",";} else {$comma = 1;};
$data = $data . "\"bri\":" . $bri;
}

if ($on = $_GET["on"]) {
if ($comma == 1) {$data = $data . ",";} else {$comma = 1;};
$data = $data . "\"on\":" . $on;

}

$data = $data . "}";

$url = "http://$IP/api/$APPID/lights/" .$light. "/state";

//$data = "{\"hue\": ".$hue.",\"sat\": ".$sat.",\"transitiontime\": ".$trans.",\"bri\":".$bri.",\"on\":".$on."}";

$ch = curl_init($url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "PUT");
$response1 = curl_exec($ch);
if(!$response1) {
return false;
}

echo $data . '
';

echo $response1;
echo "<br/>done";

?>
