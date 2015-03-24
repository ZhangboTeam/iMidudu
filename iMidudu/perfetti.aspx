<%@ Page Language="C#"   %> 
<%
  
    var sql = string.Format("select count(*) from BonusHistory where BonusCode='{0}'", this.Request["bonus"]);
    //Response.Write(sql);
    //Response.End();
    var exists = iMidudu.SystemDAO.SqlHelper.Exists(sql);
   
    if (exists)
    {
        //insert bad.....
        // iMidudu.SystemDAO.SqlHelper.ExecteNonQueryText("insert into BadBonusHistory(HistoryId,OpenId,BonusCode,AcitvityId,ReceiptDate) values (newid(),@OpenId,@BounsCode,@ActivityId,getdate())",
        //    new System.Data.SqlClient.SqlParameter("@OpenId", openid),
        //     new System.Data.SqlClient.SqlParameter("@BounsCode", bounscode),
        //    new System.Data.SqlClient.SqlParameter("@ActivityId", activityid));
        Response.Redirect("/BounsUsed.aspx");
        //   Response.Write(bounscode + "红包码非法！");
         Response.End();

    } 

    var now = DateTime.Now;
    if (now.Hour>=0 && now.Hour<8)
    {
        Response.Write("0点到8点之间不能领取红包,请先休息一下");
        Response.End();
    }
    Response.Write("活动未开始");
    Response.End();
    //this.Response.Write("未开启活动");
    //this.Response.End();
    var url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx8cabe7121f5369a3&redirect_uri=" + System.Web.Configuration.WebConfigurationManager.AppSettings["Domain"] +"/demo.aspx&response_type=code&scope=snsapi_base&state=" + Request["bonus"];
    this.Response.Redirect(url);

    //FocusedUserResponse users = null;
    //WX.FocusedUser(ref users);

    //Response.Write(users.total);
     %>
<!DOCTYPE html>

<html>
<head runat="server">
  <meta charset="utf-8">
  <title> </title>
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
</head>
<body>
  accessToken:<%=WX.Token %>
      
    <h1>
        <a href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx8cabe7121f5369a3&redirect_uri=<%=System.Web.Configuration.WebConfigurationManager.AppSettings["Domain"] %>/demo.aspx&response_type=code&scope=snsapi_base&state=<%=this.Request["bonus"] %>#wechat_redirect"> 
            直接跳转
        </a>
        <br />
        <a href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx8cabe7121f5369a3&redirect_uri=<%=System.Web.Configuration.WebConfigurationManager.AppSettings["Domain"] %>/demo.aspx&response_type=code&scope=snsapi_userinfo&state=<%=this.Request["bonus"] %>#wechat_redirect">点击授权</a>
    </h1>
    
<div class="wxapi_container" hidden>
    <div class="wxapi_index_container">
      <ul class="label_box lbox_close wxapi_index_list">
        <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-basic">基础接口</a></li>
        <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-share">分享接口</a></li>
        <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-image">图像接口</a></li>
        <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-voice">音频接口</a></li>
        <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-smart">智能接口</a></li>
        <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-device">设备信息接口</a></li>
        <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-location">地理位置接口</a></li>
        <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-webview">界面操作接口</a></li>
        <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-scan">微信扫一扫接口</a></li>
        <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-shopping">微信小店接口</a></li>
        <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-card">微信卡券接口</a></li>
        <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-pay">微信支付接口</a></li>
      </ul>
    </div>
    <div class="lbox_close wxapi_form">
      <h3 id="menu-basic">基础接口</h3>
      <span class="desc">判断当前客户端是否支持指定JS接口</span>
      <button class="btn btn_primary" id="checkJsApi">checkJsApi</button>

      <h3 id="menu-share">分享接口</h3>
      <span class="desc">获取“分享到朋友圈”按钮点击状态及自定义分享内容接口</span>
      <button class="btn btn_primary" id="onMenuShareTimeline">onMenuShareTimeline</button>
      <span class="desc">获取“分享给朋友”按钮点击状态及自定义分享内容接口</span>
      <button class="btn btn_primary" id="onMenuShareAppMessage">onMenuShareAppMessage</button>
      <span class="desc">获取“分享到QQ”按钮点击状态及自定义分享内容接口</span>
      <button class="btn btn_primary" id="onMenuShareQQ">onMenuShareQQ</button>
      <span class="desc">获取“分享到腾讯微博”按钮点击状态及自定义分享内容接口</span>
      <button class="btn btn_primary" id="onMenuShareWeibo">onMenuShareWeibo</button>

      <h3 id="menu-image">图像接口</h3>
      <span class="desc">拍照或从手机相册中选图接口</span>
      <button class="btn btn_primary" id="chooseImage">chooseImage</button>
      <span class="desc">预览图片接口</span>
      <button class="btn btn_primary" id="previewImage">previewImage</button>
      <span class="desc">上传图片接口</span>
      <button class="btn btn_primary" id="uploadImage">uploadImage</button>
      <span class="desc">下载图片接口</span>
      <button class="btn btn_primary" id="downloadImage">downloadImage</button>

      <h3 id="menu-voice">音频接口</h3>
      <span class="desc">开始录音接口</span>
      <button class="btn btn_primary" id="startRecord">startRecord</button>
      <span class="desc">停止录音接口</span>
      <button class="btn btn_primary" id="stopRecord">stopRecord</button>
      <span class="desc">播放语音接口</span>
      <button class="btn btn_primary" id="playVoice">playVoice</button>
      <span class="desc">暂停播放接口</span>
      <button class="btn btn_primary" id="pauseVoice">pauseVoice</button>
      <span class="desc">停止播放接口</span>
      <button class="btn btn_primary" id="stopVoice">stopVoice</button>
      <span class="desc">上传语音接口</span>
      <button class="btn btn_primary" id="uploadVoice">uploadVoice</button>
      <span class="desc">下载语音接口</span>
      <button class="btn btn_primary" id="downloadVoice">downloadVoice</button>

      <h3 id="menu-smart">智能接口</h3>
      <span class="desc">识别音频并返回识别结果接口</span>
      <button class="btn btn_primary" id="translateVoice">translateVoice</button>

      <h3 id="menu-device">设备信息接口</h3>
      <span class="desc">获取网络状态接口</span>
      <button class="btn btn_primary" id="getNetworkType">getNetworkType</button>

      <h3 id="menu-location">地理位置接口</h3>
      <span class="desc">使用微信内置地图查看位置接口</span>
      <button class="btn btn_primary" id="openLocation">openLocation</button>
      <span class="desc">获取地理位置接口</span>
      <button class="btn btn_primary" id="getLocation">getLocation</button>

      <h3 id="menu-webview">界面操作接口</h3>
      <span class="desc">隐藏右上角菜单接口</span>
      <button class="btn btn_primary" id="hideOptionMenu">hideOptionMenu</button>
      <span class="desc">显示右上角菜单接口</span>
      <button class="btn btn_primary" id="showOptionMenu">showOptionMenu</button>
      <span class="desc">关闭当前网页窗口接口</span>
      <button class="btn btn_primary" id="closeWindow">closeWindow</button>
      <span class="desc">批量隐藏功能按钮接口</span>
      <button class="btn btn_primary" id="hideMenuItems">hideMenuItems</button>
      <span class="desc">批量显示功能按钮接口</span>
      <button class="btn btn_primary" id="showMenuItems">showMenuItems</button>
      <span class="desc">隐藏所有非基础按钮接口</span>
      <button class="btn btn_primary" id="hideAllNonBaseMenuItem">hideAllNonBaseMenuItem</button>
      <span class="desc">显示所有功能按钮接口</span>
      <button class="btn btn_primary" id="showAllNonBaseMenuItem">showAllNonBaseMenuItem</button>

      <h3 id="menu-scan">微信扫一扫</h3>
      <span class="desc">调起微信扫一扫接口</span>
      <button class="btn btn_primary" id="scanQRCode0">scanQRCode(微信处理结果)</button>
      <button class="btn btn_primary" id="scanQRCode1">scanQRCode(直接返回结果)</button>

      <h3 id="menu-shopping">微信小店接口</h3>
      <span class="desc">跳转微信商品页接口</span>
      <button class="btn btn_primary" id="openProductSpecificView">openProductSpecificView</button>

      <h3 id="menu-card">微信卡券接口</h3>
      <span class="desc">批量添加卡券接口</span>
      <button class="btn btn_primary" id="addCard">addCard</button>
      <span class="desc">调起适用于门店的卡券列表并获取用户选择列表</span>
      <button class="btn btn_primary" id="chooseCard">chooseCard</button>
      <span class="desc">查看微信卡包中的卡券接口</span>
      <button class="btn btn_primary" id="openCard">openCard</button>

      <h3 id="menu-pay">微信支付接口</h3>
      <span class="desc">发起一个微信支付请求</span>
      <button class="btn btn_primary" id="chooseWXPay">chooseWXPay</button>
    </div>
  </div>
    <%--<form id="form1" runat="server">
        <input type ="button" id="b" value="share"  />
     <h3>
         <%=WX.Token %>
         <br />
         <%=WX.Ticket %>
         <%
             var s = "jsapi_ticket=sM4AOVdWfPE4DxkXGEs8VMCPGGVi4C3VM0P37wVUCFvkVAy_90u5h9nbSlYy3-Sl-HhTdfl2fzFy1AOcHKP7qg&noncestr=Wm3WZYTPz0wzccnW&timestamp=1414587457&url=http://mp.weixin.qq.com?params=value";%>
           <%//  =WX.Sha1(s) %>
     </h3>--%>
<%--<div class="wxapi_container">
    <div class="wxapi_index_container">
        <ul class="label_box lbox_close wxapi_index_list">
            <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-basic">基础接口</a></li>
            <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-share">分享接口</a></li>
            <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-image">图像接口</a></li>
            <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-voice">音频接口</a></li>
            <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-smart">智能接口</a></li>
            <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-device">设备信息接口</a></li>
            <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-location">
                地理位置接口</a></li>
            <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-webview">
                界面操作接口</a></li>
            <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-scan">微信扫一扫接口</a></li>
            <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-shopping">
                微信小店接口</a></li>
            <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-card">微信卡券接口</a></li>
            <li class="label_item wxapi_index_item"><a class="label_inner" href="#menu-pay">微信支付接口</a></li>
        </ul>
    </div>
    <div class="lbox_close wxapi_form">
        <h3 id="menu-basic">
            基础接口</h3>
        <span class="desc">判断当前客户端是否支持指定JS接口</span>
        <button class="btn btn_primary" id="checkJsApi">
            checkJsApi</button>
        <h3 id="menu-share">
            分享接口</h3>
        <span class="desc">获取“分享到朋友圈”按钮点击状态及自定义分享内容接口</span>
        <button class="btn btn_primary" id="onMenuShareTimeline">
            onMenuShareTimeline</button>
        <span class="desc">获取“分享给朋友”按钮点击状态及自定义分享内容接口</span>
        <button class="btn btn_primary" id="onMenuShareAppMessage">
            onMenuShareAppMessage</button>
        <span class="desc">获取“分享到QQ”按钮点击状态及自定义分享内容接口</span>
        <button class="btn btn_primary" id="onMenuShareQQ">
            onMenuShareQQ</button>
        <span class="desc">获取“分享到腾讯微博”按钮点击状态及自定义分享内容接口</span>
        <button class="btn btn_primary" id="onMenuShareWeibo">
            onMenuShareWeibo</button>
        <h3 id="menu-image">
            图像接口</h3>
        <span class="desc">拍照或从手机相册中选图接口</span>
        <button class="btn btn_primary" id="chooseImage">
            chooseImage</button>
        <span class="desc">预览图片接口</span>
        <button class="btn btn_primary" id="previewImage">
            previewImage</button>
        <span class="desc">上传图片接口</span>
        <button class="btn btn_primary" id="uploadImage">
            uploadImage</button>
        <span class="desc">下载图片接口</span>
        <button class="btn btn_primary" id="downloadImage">
            downloadImage</button>
        <h3 id="menu-voice">
            音频接口</h3>
        <span class="desc">开始录音接口</span>
        <button class="btn btn_primary" id="startRecord">
            startRecord</button>
        <span class="desc">停止录音接口</span>
        <button class="btn btn_primary" id="stopRecord">
            stopRecord</button>
        <span class="desc">播放语音接口</span>
        <button class="btn btn_primary" id="playVoice">
            playVoice</button>
        <span class="desc">暂停播放接口</span>
        <button class="btn btn_primary" id="pauseVoice">
            pauseVoice</button>
        <span class="desc">停止播放接口</span>
        <button class="btn btn_primary" id="stopVoice">
            stopVoice</button>
        <span class="desc">上传语音接口</span>
        <button class="btn btn_primary" id="uploadVoice">
            uploadVoice</button>
        <span class="desc">下载语音接口</span>
        <button class="btn btn_primary" id="downloadVoice">
            downloadVoice</button>
        <h3 id="menu-smart">
            智能接口</h3>
        <span class="desc">识别音频并返回识别结果接口</span>
        <button class="btn btn_primary" id="translateVoice">
            translateVoice</button>
        <h3 id="menu-device">
            设备信息接口</h3>
        <span class="desc">获取网络状态接口</span>
        <button class="btn btn_primary" id="getNetworkType">
            getNetworkType</button>
        <h3 id="menu-location">
            地理位置接口</h3>
        <span class="desc">使用微信内置地图查看位置接口</span>
        <button class="btn btn_primary" id="openLocation">
            openLocation</button>
        <span class="desc">获取地理位置接口</span>
        <button class="btn btn_primary" id="getLocation">
            getLocation</button>
        <h3 id="menu-webview">
            界面操作接口</h3>
        <span class="desc">隐藏右上角菜单接口</span>
        <button class="btn btn_primary" id="hideOptionMenu">
            hideOptionMenu</button>
        <span class="desc">显示右上角菜单接口</span>
        <button class="btn btn_primary" id="showOptionMenu">
            showOptionMenu</button>
        <span class="desc">关闭当前网页窗口接口</span>
        <button class="btn btn_primary" id="closeWindow">
            closeWindow</button>
        <span class="desc">批量隐藏功能按钮接口</span>
        <button class="btn btn_primary" id="hideMenuItems">
            hideMenuItems</button>
        <span class="desc">批量显示功能按钮接口</span>
        <button class="btn btn_primary" id="showMenuItems">
            showMenuItems</button>
        <span class="desc">隐藏所有非基础按钮接口</span>
        <button class="btn btn_primary" id="hideAllNonBaseMenuItem">
            hideAllNonBaseMenuItem</button>
        <span class="desc">显示所有功能按钮接口</span>
        <button class="btn btn_primary" id="showAllNonBaseMenuItem">
            showAllNonBaseMenuItem</button>
        <h3 id="menu-scan">
            微信扫一扫</h3>
        <span class="desc">调起微信扫一扫接口</span>
        <button class="btn btn_primary" id="scanQRCode0">
            scanQRCode(微信处理结果)</button>
        <button class="btn btn_primary" id="scanQRCode1">
            scanQRCode(直接返回结果)</button>
        <h3 id="menu-shopping">
            微信小店接口</h3>
        <span class="desc">跳转微信商品页接口</span>
        <button class="btn btn_primary" id="openProductSpecificView">
            openProductSpecificView</button>
        <h3 id="menu-card">
            微信卡券接口</h3>
        <span class="desc">批量添加卡券接口</span>
        <button class="btn btn_primary" id="addCard">
            addCard</button>
        <span class="desc">调起适用于门店的卡券列表并获取用户选择列表</span>
        <button class="btn btn_primary" id="chooseCard">
            chooseCard</button>
        <span class="desc">查看微信卡包中的卡券接口</span>
        <button class="btn btn_primary" id="openCard">
            openCard</button>
        <h3 id="menu-pay">
            微信支付接口</h3>
        <span class="desc">发起一个微信支付请求</span>
        <a class="btn btn_primary" href="/jssdk/pay?showwxpaytitle=1">
            chooseWXPay</a>
    </div>
</div>--%>
<hr />
<%--    </form>--%>
</body>
    
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script> 
    <script> 
            <%var c = WX.Config(Request.Url.AbsoluteUri);%>
            wx.config({
                debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                appId: '<%=c.appId %>', // 必填，公众号的唯一标识
                timestamp: <%=c.timestamp %>, // 必填，生成签名的时间戳
                nonceStr: '<%=c.nonceStr %>', // 必填，生成签名的随机串
                signature: '<%=c.signature %>',// 必填，签名，见附录1
                jsApiList: [
        'checkJsApi',
        'onMenuShareTimeline',
        'onMenuShareAppMessage',
        'onMenuShareQQ',
        'onMenuShareWeibo',
        'hideMenuItems',
        'showMenuItems',
        'hideAllNonBaseMenuItem',
        'showAllNonBaseMenuItem',
        'translateVoice',
        'startRecord',
        'stopRecord',
        'onRecordEnd',
        'playVoice',
        'pauseVoice',
        'stopVoice',
        'uploadVoice',
        'downloadVoice',
        'chooseImage',
        'previewImage',
        'uploadImage',
        'downloadImage',
        'getNetworkType',
        'openLocation',
        'getLocation',
        'hideOptionMenu',
        'showOptionMenu',
        'closeWindow',
        'scanQRCode',
        'chooseWXPay',
        'openProductSpecificView',
        'addCard',
        'chooseCard',
        'openCard'
                ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
            });
    
      
        //wx.ready(function () {
        //     alert("ready done"); 
        //     document.querySelector("#b").onclick= function(){
        //         alert("gogogo");
        //         share222();
        //     }; 
        //    alert(2222);
        //});
        function share222(){
            alert("begin share");
            var shareData = {
                title: '我的第一个微信应用', // 分享标题
                link: 'http://www.baidu.com', // 分享链接
                imgUrl: 'http://everysync.lenovo.com.cn/images/menuIco01.png', // 分享图标
                success: function () {
                    // 用户确认分享后执行的回调函数
                    alert("用户确认分享后执行ok");
                },
                cancel: function () {
                    // 用户取消分享后执行的回调函数
                    alert("用户取消分享 cancel");
                }
            };
            wx.onMenuShareAppMessage(shareData);
            wx.onMenuShareTimeline(shareData);
        }
    </script>
     
    <script src="Scripts/weixin.js"></script>

</html>
