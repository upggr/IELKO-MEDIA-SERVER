<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>IELKO MEDIA SERVER</title>
<meta property="og:title" content="UPG.GR Media Streamer" />
<meta property="og:description" content="The dead easy media streamer by IELKO" />
<link rel="shortcut icon" href="favicon.ico">
<link rel="stylesheet" href="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<link rel="stylesheet" href="ielko-media-server.css">
<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
</head>
<body>
<div data-role="page" data-theme="b" id="demo-page" class="my-page" data-url="demo-page">
  <div data-role="header">
    <h1>IELKO Media Streamer</h1>
        </div>

  <div role="main" class="ui-content">
    <ul data-role="listview" data-inset="true">
      <?php

function buildSecureLink($baseUrl, $path, $secret, $ttl, $userIp)
{
    $expires = time() + $ttl;
    $md5 = md5("$expires$path$userIp $secret", true);
    $md5 = base64_encode($md5);
    $md5 = strtr($md5, '+/', '-_');
    $md5 = str_replace('=', '', $md5);
    return $baseUrl . $path . '?md5=' . $md5 . '&expires=' . $expires;
}

$secret = 'IELKO';  //This is the secret configured at nginx.conf
$baseUrl = 'http://replaceip'; //this is your website that the content will be played from (replace replaceip with your domain name)
$path = '/hls/stream4.m3u8'; //this is the stream url (replace replaceip with your domain name)
$ttl = 120;
$userIp = $_SERVER['REMOTE_ADDR'];
$secure_stream4 = buildSecureLink($baseUrl, $path, $secret, $ttl, $userIp);

$url    = "stream.xml";
$result = file_get_contents($url);
$xml = new SimpleXMLElement($result);
foreach($xml->channel->item as $item) {
foreach($item as $item2) {
	$title = $item2->attributes()->title;
	$imgurl = $item2->attributes()->hdposterurl;
	$hlsurl = $item2->attributes()->url;
echo "<li><a href='player/play.html?play=".$hlsurl."' target='_blank'><img src='".$imgurl."' class='ui-li-thumb'><h2>".$title."</h2><p>".$title."</p><p class='ui-li-aside'>Watch Live</p></a></li>";
}
}
echo "<li><a href='player/play.html?play=".$secure_stream4."' target='_blank'><img src='testing.png' class='ui-li-thumb'><h2>Secure Stream 4</h2><p>Secure Stream 5</p><p class='ui-li-aside'>Watch Live</p></a></li>";

?>

    </ul>
        </div>
</div>
</body>
</html>