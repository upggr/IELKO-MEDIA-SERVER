<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>UPG Media Player</title>
<link href="http://vjs.zencdn.net/5.9.2/video-js.css" rel="stylesheet">
<style>
.video-js {
	padding-top: 56.25%
}
.vjs-fullscreen {
	padding-top: 0px
}
</style>
</head>

<body>
<?php
$m3u8= $_GET["m3u8"]; $poster= $_GET["poster"]; $title= $_GET["channel"]; $rtmp = str_replace("http","rtmp",$m3u8); $rtmp = substr($rtmp,0,-5);
?>
<div class="wrapper">
  <div class="videocontent">
    <video id=example-video class="video-js vjs-default-skin vjs-fullscreen" preload=none  poster="<?php echo $poster;?>" width=auto height=auto  autoplay=true>
    <source src="<?php echo $rtmp; ?>" type="rtmp/mp4">
      <source src="<?php echo $m3u8;?>" type="application/x-mpegURL">
    </video>
  </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script> 
<script src="http://videojs.github.io/videojs-contrib-hls/node_modules/video.js/dist/video-js/video.dev.js"></script> 
<script src="http://videojs.github.io/videojs-contrib-hls/node_modules/videojs-contrib-media-sources/src/videojs-media-sources.js"></script> 
<script src="https://github.com/videojs/videojs-contrib-hls/releases/download/v2.0.1/videojs-contrib-hls.js"></script> 
<script> var player = videojs('example-video');</script>
<script>
  videojs.options.techOrder = ['flash', 'html5'];
</script>
</body>
</html>