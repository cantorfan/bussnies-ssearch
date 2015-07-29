<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Bussiness Search</title>
	<link rel="stylesheet" href="index.css" />
</head>
<body>
	<div id="map-canvas"></div>
	<div id="resultList" class="resultList">
		<ul id="items">
			<!-- 
			<li><span class="same">1213123</span><span class="not-same">12312</span><span class="sample">312312</span></li>
			<li><span class="same">1213123</span><span class="not-same">12312</span><span class="sample">312312</span></li>
			<li><span class="same">1213123</span><span class="not-same">12312</span><span class="sample">312312</span></li>
			<li><span class="same">1213123</span><span class="not-same">12312</span><span class="sample">312312</span></li>
			 -->
		</ul>
	</div>
	<div id="form" class="form">
		<ul>
			<li><span>business name :</span><input type="text" size="50" id="name"/></li>
			<li><span>address :</span><input type="text" size="50" id="address"/></li>
			<li><span>phone number :</span><input type="text" size="50" id="number"/></li>
		</ul>
		<p><a id="searchSubmtBtn" href="javascript:void(0);">Search</a></p>
	</div>
</body>

<script type='text/javascript' src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true"></script>
<script type='text/javascript' src="jquery-1.7.2.js"></script>
<script type='text/javascript' src="index.js"></script>
</html>