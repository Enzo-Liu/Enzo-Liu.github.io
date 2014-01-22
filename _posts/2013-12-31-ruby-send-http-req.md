---
layout: post
title: "ruby send http req"
description: ""
category: "ruby http"
tags: []
---
{% include JB/setup %}

经过昨天的实验，倘若接口做的事情过多时间超长，会被nginx拒绝请求返回超时。

所以用ruby做了一个批量调接口的小脚本，**有需要的人自取自改**。
{% highlight ruby %}	
require "open-uri"  
require "net/https"
require "uri"

#返回的cookie  
cookie =  'dpadmin=360cc4800098092534fa9aedb4a78bf0b33f67e84c35660076ba6c9eab84847e0d3614348edfa4d4a8bf630529b40a28322230194c2ac52ef51c2ba4f310b9b1; Domain=dper.com; Expires=Mon, 30-Dec-2013 22:38:45 GMT; JSESSIONID=EA9BE36A86DCE564D7ED47571E79D82C; '  
$headers = {"cookie"=>cookie}

def getFromUri(dealGroupId,uri,headers)
	req = Net::HTTP::Get.new(uri,headers) 
	res = Net::HTTP.start(uri.host) do |http|
   	http.request(req)
	end
	return res
end

def postForm(dealGroupId,uri,headers)
	req = Net::HTTP::Post.new(uri,$headers)
	req.set_form_data(:statusId=>0,:isValid=>false,:dealGroupId=>dealGroupId) 
	res = Net::HTTP.start(uri.host) do |http|
    	http.request(req)
  	end
	return res;
end

def publish(dealGroupId)
	uri = URI::parse("http://tgplatform.sys.www.dianping.com/publish/fullPublish? dealGroupId=#{dealGroupId}")  
	res = getFromUri(dealGroupId,uri,$headers)
	puts "#{dealGroupId}"+res.body
end

def changeStatus(dealGroupId)
	uri = URI::parse("http://tgplatform.sys.www.dianping.com/operation/setStatusId")  
	res = postForm(dealGroupId,uri,$headers)
	puts "#{dealGroupId}"+"--status--"+res.body
end

def changeIsValid(dealGroupId)
 uri = URI::parse("http://tgplatform.sys.www.dianping.com/operation/setIsValid") 
	res = postForm(dealGroupId,uri,$headers)
	puts "#{dealGroupId}"+"--valid--"+res.body
end

# [0].each do |dealGroupId|
#   publish(dealGroupId)
# end

[2100131]
.each do |dealGroupId|
	changeStatus(dealGroupId)
	changeIsValid(dealGroupId)
end
{% endhighlight %}

Cookie使用自己的

\[2100131\]表示数组，把要批量处理的一堆ID放进来就可以了。



**ps:更新后版本**
{% highlight ruby %}  
require "open-uri"  
require "net/https"
require "uri"

#返回的cookie  
cookie =  'dpadmin=360cc4800098092534fa9aedb4a78bf0b33f67e84c35660076ba6c9eab84847e0d3614348edfa4d4a8bf630529b40a28322230194c2ac52ef51c2ba4f310b9b1; Domain=dper.com; Expires=Mon, 30-Dec-2013 22:38:45 GMT; JSESSIONID=EA9BE36A86DCE564D7ED47571E79D82C; '  
$headers = {"cookie"=>cookie}

def getFromUri(dealGroupId,uri)
	req = Net::HTTP::Get.new(uri,$headers) 
	res = Net::HTTP.start(uri.host) do |http|
    	http.request(req)
	end
end

def publish(dealGroupId)
	uri = URI::parse("http://tgplatform.sys.www.dianping.com/publish/fullPublish?dealGroupId=#{dealGroupId}")  
	puts "#{dealGroupId}"+getFromUri(dealGroupId,uri,$headers).body
end

def postForm(uri,form_data)
	req = Net::HTTP::Post.new(uri,$headers)
	req.set_form_data(form_data) 
	res = Net::HTTP.start(uri.host) do |http|
    	http.request(req)
  	end
end

$method_name = {:Status=>"operation/setStatusId",:Valid=>"operation/setIsValid"}
class <<self
	$method_name.each do |name,value|
  	define_method "change"+name.to_s do |dealGroupId,form_data|
    	uri = URI::parse("http://tgplatform.sys.www.dianping.com/"+value) 
    	puts "#{dealGroupId}"+"--"+name.to_s+"--"+postForm(uri,form_data).body
  	end
	end
end

[2079479].each do |dealGroupId|
	form_data = {:statusId=>0,:isValid=>false,:dealGroupId=>dealGroupId}
	changeStatus(dealGroupId,form_data)
	changeValid(dealGroupId,form_data)
end
{% endhighlight %}
