<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.OutputStreamWriter" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLConnection" %>
<%@ page import="net.sf.*" %>
    
<%
	String name = request.getParameter("name");
	String address = request.getParameter("address");
	String number = request.getParameter("number");
	String lat = request.getParameter("lat");
	String lng = request.getParameter("lng");
	
	String appKey = "AIzaSyBGBdcWIaj1tX2TFA-eP8HYL2AbyanE9lY";
//	String appKey = "AIzaSyBu-zqbdrboUS_A05Skt7C_2642ZjUS998";
	
	String keyWord = "";
	String numberKeyword = "";
	if(name!=null && name.trim().length()!=0)
		keyWord += URLEncoder.encode(name.trim());
	if(address!=null && address.trim().length()!=0)
		keyWord += "+"+URLEncoder.encode(address.trim());
	if(number!=null && number.trim().length()!=0){
		//if(number.trim().startsWith("+")==false){
		//	number =  "+"+number.trim();
		//}
		
		numberKeyword += URLEncoder.encode(number);
	}
	
	/*
	String url = "https://maps.googleapis.com/maps/api/place/radarsearch/json?"+
			"location="+lat+","+lng+
			"&radius=5000"+
			"&types=establishment"+
			"&keyword="+name+
			"&key="+appKey;
	*/
	
	String url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query="+keyWord+
		"&key="+appKey;
	
	/*
	{
	   "html_attributions" : [],
	   "results" : [
		      {
		         "geometry" : {
		            "location" : {
		               "lat" : 28.209654,
		               "lng" : 112.982191
		            }
		         },
		         "id" : "06c417ec84576497767abe3901bcc8adfca1edd9",
		         "place_id" : "ChIJCdhBPmtKJzQRGNBlMEkNaZk",
		         "reference" : "CnRpAAAAnINXHGIS6btwfTMQl-hYWLUJ28JFGnEzOactO3PPOpx5oLMIF0frQfyKwfPFpTnO7A9iumNSNuRr9ApZUz7CkVjKUdeUYr8T4vjJTtvnxCsI8e5GYt5XDH1_zr050icQYe1E7ty8bMNp2iJXhJqMoRIQnQdMAw8gm6N0FCJlJ5dlIxoULkxIlNQ4LkHKymLPIpNFaXHMwQg"
		      },
		      {
		         "geometry" : {
		            "location" : {
		               "lat" : 28.222223,
		               "lng" : 112.953736
		            }
		         },
		         "id" : "827b0d6875c521be0104dce68e1819ea64c4e324",
		         "place_id" : "ChIJwwenNTNKJzQRuK9yi07xz4I",
		         "reference" : "CnRsAAAAC6UuYQ4PiNOmy6TQTcPqFmJRJ4z16Mb1yntd-pcgaUxEl3F1nr_vt3uFvPhkJYnk1eZvfszini_9Af3tOJ6rPkUobsMqOhKv3Ref9O-RgnVUvCeaHp1X1oJa78UJAuajXEWlu7NidCWEbUjLZ1I1qxIQPm4g5X4OX842R3UOfrAVkhoU7Rv8Kle8hoqJsOa5bDQv6AS6vM8"
		      }
	      ]
      }
	*/
	String placesJsonStr = sendGet(url);
	
	System.out.println("1 search results:"+placesJsonStr);
	
	
	JSONObject placesJson = JSONObject.fromObject(placesJsonStr); //new JSONObject(placesJsonStr);
	JSONArray  placesJsonArray = placesJson.getJSONArray("results");
	
	String responseJson = "";
	
	/*
	{
	   "html_attributions" : [],
	   "result" : {
	      "address_components" : [
	         {
	            "long_name" : "30号",
	            "short_name" : "30号",
	            "types" : [ "street_number" ]
	         },
	         {
	            "long_name" : "人民中路",
	            "short_name" : "人民中路",
	            "types" : [ "route" ]
	         },
	         {
	            "long_name" : "雨花区",
	            "short_name" : "雨花区",
	            "types" : [ "sublocality_level_1", "sublocality", "political" ]
	         },
	         {
	            "long_name" : "长沙",
	            "short_name" : "长沙",
	            "types" : [ "locality", "political" ]
	         },
	         {
	            "long_name" : "湖南省",
	            "short_name" : "湖南省",
	            "types" : [ "administrative_area_level_1", "political" ]
	         },
	         {
	            "long_name" : "中国",
	            "short_name" : "CN",
	            "types" : [ "country", "political" ]
	         }
	      ],
	      "adr_address" : "\u003cspan class=\"country-name\"\u003e中国\u003c/span\u003e\u003cspan class=\"region\"\u003e湖南省\u003c/span\u003e\u003cspan class=\"locality\"\u003e长沙市\u003c/span\u003e\u003cspan class=\"extended-address\"\u003e雨花区\u003c/span\u003e\u003cspan class=\"street-address\"\u003e人民中路30号\u003c/span\u003e",
	      "formatted_address" : "中国湖南省长沙市雨花区人民中路30号",
	      "formatted_phone_number" : "(650) 253-0000",
	      "international_phone_number" : "+1 650-253-0000",
	      "name" : "谷歌公司",
	      "geometry" : {
	         "location" : {
	            "lat" : 28.185766,
	            "lng" : 112.987553
	         }
	      },
	      "icon" : "http://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png",
	      "id" : "8d4b3680dd48a45a70a4c2cca86161992e2d72f4",
	      "name" : "童泰母婴生活馆",
	      "place_id" : "ChIJw4xkP4hKJzQR_xZMiODWnlA",
	      "reference" : "CnRoAAAAgpp5N7M5yi359SfBVQ92LQnC-JZoPkiOZf2ti9hUjmDrEc5RTPnxQIo5-_4uKQaJ8BzM8XkO1Tfy2dCsijlOAjUchssV5VHVAjZqN-hZqK8huqGFHzxRz94qnxsLXfact9VE2Zokwd7hd5zUSpy8mBIQIklvAZaGWFdE6Z7t0V-RJxoUWEsIVKymD6upwipWTCFu67oZhdc",
	      "scope" : "GOOGLE",
	      "types" : [ "establishment" ],
	      "url" : "https://plus.google.com/106789661337886658405/about?hl=zh-CN",
	      "utc_offset" : 480,
	      "vicinity" : "长沙市雨花区人民中路30号"
	   },
	   "status" : "OK"
	}
	*/
	
	int min = 10;
	System.out.println("1 size:"+placesJsonArray.size());
	if(placesJsonArray.size()==0){
		url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query="+numberKeyword+
				"&key="+appKey;
		
		placesJsonStr = sendGet(url);
		System.out.println("2 search results:"+placesJsonStr);
		placesJson = JSONObject.fromObject(placesJsonStr); //new JSONObject(placesJsonStr);
		placesJsonArray = placesJson.getJSONArray("results");
		
	}
	
	System.out.println("2 size:"+placesJsonArray.size());
	
	
	if(placesJsonArray.size()>0){
				
//	for(int i=0; i<placesJsonArray.size() && i<min ; i++){
		JSONObject obj =(JSONObject) placesJsonArray.get(0);
		String placeId = obj.getString("place_id");
		String detailUrl = "https://maps.googleapis.com/maps/api/place/details/json?placeid="+placeId+"&key="+appKey;
		
		String placeDetailJsonStr = sendGet(detailUrl);
		
		System.out.println("detail result:"+placeDetailJsonStr);
		
		JSONObject placeDetailJson = JSONObject.fromObject(placeDetailJsonStr);//new JSONObject(placeDetailJsonStr);
		JSONObject placeDetail =  placeDetailJson.getJSONObject("result");
		
		String placeName = placeDetail.getString("name");
		
		String fullAddress = placeDetail.getString("formatted_address");
		String phoneNumber =  "";
		
		try{
			phoneNumber = placeDetail.getString("formatted_phone_number");
		}catch (Exception e){
			e.printStackTrace();
		}
		
		try{
			phoneNumber += ", "+placeDetail.getString("international_phone_number");
		}catch (Exception e){
			e.printStackTrace();
		}
		
		
//		if((i+1)<min && (i+1)<placesJsonArray.size()){
//			responseJson +=",";		
//		}
		
		responseJson+="{\"status\":true,\"name\":\""+name+"\", \"address\":\""+fullAddress+"\", \"phone\":\""+phoneNumber+"\"}";
	}else{
		responseJson+="{\"status\":false}";
	}
	
	response.setContentType("text/html; charset=utf-8");
	response.getWriter().write(responseJson);
	
%>


<%!

public static String sendGet(String url) {
	
	System.out.println(url);
	
    String result = "";
    BufferedReader in = null;
    try {
        String urlNameString = url;
        URL realUrl = new URL(urlNameString);
        // 打开和URL之间的连接
        URLConnection connection = realUrl.openConnection();
        // 设置通用的请求属性
        connection.setRequestProperty("accept", "*/*");
        connection.setRequestProperty("connection", "Keep-Alive");
        connection.setRequestProperty("user-agent",
                "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
        // 建立实际的连接
        connection.connect();
        // 获取所有响应头字段
        //Map<String, List<String>> map = connection.getHeaderFields();
        // 遍历所有的响应头字段
        //for (String key : map.keySet()) {
        //    System.out.println(key + "--->" + map.get(key));
        //}
        // 定义 BufferedReader输入流来读取URL的响应
        in = new BufferedReader(new InputStreamReader(
                connection.getInputStream(), "UTF-8"));
        String line;
        while ((line = in.readLine()) != null) {
            result += line;
        }
    } catch (Exception e) {
        //System.out.println("发送GET请求出现异常！" + e);
        e.printStackTrace();
    }
    // 使用finally块来关闭输入流
    finally {
        try {
            if (in != null) {
                in.close();
            }
        } catch (Exception e2) {
            e2.printStackTrace();
        }
    }
    return result;
}

%>