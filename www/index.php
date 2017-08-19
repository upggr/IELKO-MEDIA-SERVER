<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Greek TV by UPG.GR</title>
<meta property="og:title" content="UPG.GR Media Streamer" />
<meta property="og:description" content="The dead easy media streamer by UPG.GR" />
<link rel="shortcut icon" href="favicon.ico">
<link rel="stylesheet" href="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<link rel="stylesheet" href="listview-grid.css">
<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
</head>
<body>
<div data-role="page" data-theme="b" id="demo-page" class="my-page" data-url="demo-page">     
  <div data-role="header">         
    <h1>UPG.GR Media Streamer - <a href="vlc.m3u">VLC Playlist</a> - <a href="/stat">Statistics</a></h1>
        </div>
      
  <div role="main" class="ui-content">         
    <ul data-role="listview" data-inset="true">
      <?php
$url    = "stream.xml";
$result = file_get_contents($url);
$xml = new SimpleXMLElement($result);
foreach($xml->channel->item as $item) {
foreach($item as $item2) {
	$title = $item2->attributes()->title;
	$imgurl = $item2->attributes()->hdposterurl;
	$hlsurl = $item2->attributes()->url;
echo "<li><a href='upgplayer.php?m3u8=".$hlsurl."&poster=".$imgurl."&type=hls&channel=".$title."' target='_blank'><img src='".$imgurl."' class='ui-li-thumb'><h2>".$title."</h2><p>".$title."</p><p class='ui-li-aside'>Watch Live</p></a></li>";
}
}
?>
              
    </ul>
        </div>
</div>
</body>
</html>