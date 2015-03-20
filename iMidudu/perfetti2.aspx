<%@ Page Language="C#"  %>
<!DOCTYPE html>
<html>
<head>
	<!-- Basic Page Needs
	================================================== -->
	<meta charset="utf-8">
	<title>不凡帝红包--提取红包2元</title>
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
    <script type ="text/javascript">
        function closewindow(){
            window.close();
        }
        function guanzhu() {
            window.location.href = "http://mp.weixin.qq.com/s?__biz=MzAxNzIwNjE3OQ==&mid=208231695&idx=1&sn=53351b0f3592d82509d8bc8be170fae4#rd";
        }
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
                <i class="tips-bg"></i>
                <div class="bagCon"><img src="images/price-01.png" alt=""></div>
                <h3 class="tc">“幸运超级大礼-IPHONE 6”</h3>
                <p class="txt">每月超级大奖公布情况，敬请关注</p>
                <p class="txt">不凡帝官方微信号<span><input type="button" id="guanzhu" value="“PVM中国”" onclick="guanzhu()"/></span></p>
            </div>
          <%   //<input type="button" id="close" value="关闭" onclick="closewindow()"/>%>
        </div>
    </section>
    <footer>
        <img src="images/foot-bg.png" alt="">
    </footer>
</div>
<script src="js/jquery.min.js"></script>
</body>
</html>
