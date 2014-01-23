---
layout: post
title: "rails 初探"
description: ""
category: "rails"
tags: [rails]
---
{% include JB/setup %}

#Rails 初探

**首次系统的接触WEB+前端内容，好好学习一下，做一下问题的记录。**

##依赖
###assetPipeLine

* js，css等文件，同时依赖多次会存在问题。具体原因还没有搞清。js的依赖全部写在了application.js中，css的依赖一样。无须在html人工导入
* font文件的依赖，config/application.rb中添加如下代码:

{% highlight js %}
config.assets.paths << Rails.root.join("app", "assets", "fonts")
config.assets.precompile << Proc.new { |path|
  if path =~ /\.(eot|svg|ttf|woff)\z/
    true
  end
}
{% endhighlight %}

scss中通过font-url使用即可。

{% highlight js %}
font-url('glyphicons-halflings-regular.eot');	
{% endhighlight %}
    
* coffeeScript与scss的语法首次接触，对js，css本身的了解也不够，上手起来很是痛苦

###View
**BootStrap**果然超级好用。暂时还没有什么研究，不过拷贝过来立刻可以见到成效，感觉很好。

###Route
工程的路由规则完全由config/Route.rb中内容觉得。当前只是配置了映射关系，和struts的action配置感觉没什么区别。

返回的信息类别可由调用时决定，比如welcome/index.json，即表明要获取json类型的数据。

##AJAX
之所以拿出来单独说，是这个让我搞的的确很痛苦。

当然可以直接使用js(jQuery)来从页面到回调什么的完全搞定，不过有违我学习Rails的初衷，就还是按部就班的按照Rails的help上一步步尝试，各种问题。

###TAG
在html.erb文件中，rails推荐的写法是使用helper提供的各种tag来进行描述。

想要触发ajax请求很容易，只需要正确的用对tag就可以了。比如：

	<%= form_tag("/welcome/test.json",:id => "viper", remote: true)  do%>
	<%= text_area_tag 'str', @res%>
	<%= submit_tag 'Save' %>
	<% end %>
	
现在的发现是，各种输入，在rails中都有对应的tgp来使用。在手写input的情况下，表单提交会带入不了数据，暂时还不知道是为什么。

###CoffeeScript
Ajax回调的触发如下，在controller对应的js.coffee文件内，写下

	$(document).ready ->
	$("#viper").on "ajax:success", (e, data, status, xhr) ->
	console.log($("#users").toArray());
	console.log(data);
类似的代码即可。我的悲剧在于html.erb文件的底部由于拷贝Bootstrap的模板还引用了JQuery，结果这个回调一直没有调通。在某次网不好的情况下，突然成功的打出了log。于是才发现是这个问题，删除之后就OK了。

一共花费了大约4+个小时来调通ajax，其中大部分都是不了解吃的亏，好疼。

##TODO
1. 将AJAX的机制再好好了解一下，用Ajax在Rails上做出一个完整的Game Of Life 网页小动画处来。
2. 学习Bootstrap做一个漂亮的首页讨好一下老婆
3. 多了解Rails的convention，学习其中的精华，比如看到的remote:true的配置(Unobtrusive JavaScript)的理念，完全可以在日常中想办法借鉴一下使用的。
4. 业余多了解js，css等前端相关技术