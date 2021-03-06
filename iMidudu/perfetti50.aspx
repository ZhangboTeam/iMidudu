﻿<%@ Page Language="C#"  %> 
<!DOCTYPE html>
<html>
<head>
	<!-- Basic Page Needs
	================================================== -->
	<meta charset="utf-8">
	<title>不凡帝红包--提取红包50元</title>
	<meta name="description" content="">
	<meta name="author" content="PaulWang">
	<meta content="telephone=no" name="format-detection" />
	<!-- 让IE浏览器用最高级内核渲染页面 还有用 Chrome 框架的页面用webkit 内核
	================================================== -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<!-- IOS6全屏 Chrome高版本全屏
	================================================== -->
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="mobile-web-app-capable" content="yes"> 
	<!-- 让360双核浏览器用webkit内核渲染页面
	================================================== -->
	<meta name="renderer" content="webkit">
	<!-- Mobile Specific Metas
	================================================== -->
	<!-- !!!注意 minimal-ui 是IOS7.1的新属性，最小化浏览器UI，但是在iOS8.1突然被取消 -->
	<meta name="viewport" content="width=device-width,maximum-scale=1, maximum-scale=1">
	<meta content="telephone=no" name="format-detection" />
	<!-- CSS
	================================================== -->
	<link href="css/reset.css" rel="stylesheet" type="text/css">
	<link href="css/style.css" rel="stylesheet" type="text/css">
	<!-- Favicons
	================================================== -->
<!--	<link rel="shortcut icon" href="favicon.ico" >-->
	<!-- Android 主屏图标
	================================================== -->	
<!--	<link rel="icon" sizes="196x196" href="images/apple-touch-icon-114x114.png">-->
	<!-- IOS 主屏图标
	================================================== -->
<!--	<link rel="apple-touch-icon" sizes="57x57" href="images/apple-touch-icon-57x57.png">-->
<!--	<link rel="apple-touch-icon" sizes="72x72" href="images/apple-touch-icon-72x72.png">-->
<!--	<link rel="apple-touch-icon" sizes="114x114" href="images/apple-touch-icon-114x114.png">-->
        <script src="js/jquery.min.js"></script>
        <script type ="text/javascript">
            function closewindow() {
                window.close();
            }
            $(function () {
                $("body").click(function () {
                    window.location.href = "http://mp.weixin.qq.com/s?__biz=MjM5MDAwMzQ5OA==&mid=204358087&idx=1&sn=8a896c7665e658e9962969fd5949ab8a#rd";

                });
            });
    </script>
</head>
<body>
<div class="wrap">
    <header>
        <a href="#" class="logo logo01"><img src="images/logo-01.png" alt=""></a>
        <a href="#" class="logo logo02"><img src="images/logo-02.png" alt=""></a>
    </header>
    <section>
        <div class="mainWrap">
            <div class="bagWrap">
                <p class="tips tc">恭喜您获得不凡帝红包</p>
                <div class="bagCon bagCon2" style=""><img src="images/price-02.png" alt=""></div>
                <h3 class="tc">第二重“幸运超级大礼-IPHONE 6”</h3>
                <p class="txt">每月超级大奖公布情况，敬请关注</p>
                <p class="txt">不凡帝官方微信号<span>“PVM中国”</span></p>
            </div>
     <%    //  <input type="button" id="close" value="关闭" onclick="closewindow()"/> %> 
        </div>
    </section>
    <footer>
                <img src="images/foot-bg.png" alt="">
        <p class="txt_tips">点击钱包-微信红包-我的红包-收到的红包即可查询</p>
    </footer>
</div>
<script src="js/jquery.min.js"></script>
</body>
</html>
