<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TimeSearch.aspx.cs" Inherits="iMidudu.Admin.TimeSearch" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta charset="utf-8"/>
	<title>Dashboard I Admin Panel</title>
	
	<link rel="stylesheet" href="css/layout.css" type="text/css" media="screen" />
	<!--[if lt IE 9]>
	<link rel="stylesheet" href="css/ie.css" type="text/css" media="screen" />
	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	<script src="js/jquery-1.5.2.min.js" type="text/javascript"></script>
	<script src="js/hideshow.js" type="text/javascript"></script>
	<script src="js/jquery.tablesorter.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="js/jquery.equalHeight.js"></script>
	<script type="text/javascript">
	$(document).ready(function() 
    	{ 
      	  $(".tablesorter").tablesorter(); 
   	 } 
	);
	$(document).ready(function() {

	//When page loads...
	$(".tab_content").hide(); //Hide all content
	$("ul.tabs li:first").addClass("active").show(); //Activate first tab
	$(".tab_content:first").show(); //Show first tab content

	//On Click Event
	$("ul.tabs li").click(function() {

		$("ul.tabs li").removeClass("active"); //Remove any "active" class
		$(this).addClass("active"); //Add "active" class to selected tab
		$(".tab_content").hide(); //Hide all tab content

		var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
		$(activeTab).fadeIn(); //Fade in the active ID content
		return false;
	});

});
    </script>
    <script type="text/javascript">
    $(function(){
        $('.column').equalHeight();
    });
</script>
</head>
<body>
    <header id="header">
		<hgroup>
			<h1 class="site_title"><a href="/Admin/RedBagTotal.aspx" class="logo"><img  src="images/iMidudu.png"/></a></h1>
			<h2 class="section_title">后台数据管理平台</h2>
		</hgroup>
	</header> <!-- end of header bar -->
	
    <section id="secondary_bar">
        <div class="user">
            
        </div>
        <div class="breadcrumbs_container">
            <article class="breadcrumbs">
                <a class="current">红包历史查询</a> 
            <div class="breadcrumb_divider"></div> 
                <a class="current2">按时间段查询</a>
            </article>
        </div>
    </section><!-- end of secondary bar -->
	
	<aside id="sidebar" class="column">
		<hr/>
		<h3>数据管理</h3>
		<ul class="toggle">
            <li class="icn_profile"><a href="/Admin/AdminManage.aspx">管理员管理</a></li>
            <li class="icn_view_users"><a href="/Admin/UserManage.aspx">用户员管理</a></li>
            <li class="icn_tags"><a href="/Admin/ActivityManage.aspx">活动管理</a></li>
            <li class="icn_tags"><a href="/Admin/ActivityDividedManage.aspx">活动分组查看</a></li>
		</ul>
		<h3>红包历史查看</h3>
		<ul class="toggle">
            <li class="icn_settings"><a href="/Admin/TimeSearch.aspx">按时段查询</a></li>
            <li class="icn_settings"><a href="/Admin/UserNameSearch.aspx">按用户名查询</a></li>
            <li class="icn_categories"><a href="/Admin/MoneyTop10.aspx">领取金额top10</a></li>
            <li class="icn_categories"><a href="/Admin/NumberTop10.aspx">领取次数top10</a></li>
            <li class="icn_settings"><a href="/Admin/AllActivityUserSearch.aspx">查看所有参加活动用户</a></li>
            <li class="icn_categories"><a href="/Admin/RedBagTotal.aspx">红包统计</a></li>
            <li class="icn_settings"><a href="/Admin/IllegalInformation.aspx">非法领取人的信息</a></li>

		</ul>
		
		<footer>
			<hr />
			<p><strong>Copyright &copy; 2011 Website Admin</strong></p>
			<p>Theme by <a href="http://www.medialoot.com">MediaLoot</a></p>
		</footer>
	</aside><!-- end of sidebar -->
	
	<section id="main" class="column">
		<form class="quick_search width_half_search">
			<input type="text" value="按用户名查找" onfocus="if(!this._haschanged){this.value=''};this._haschanged=true;">
		</form><br /><br /><br /><br />
        <form class="quick_search width_half_search">
			<input type="text" value="按电话查找" onfocus="if(!this._haschanged){this.value=''};this._haschanged=true;">
		</form>

        <article class="module width_full">
            <header>
                <h3 class="tabs_involved">Show</h3>

            </header>
            <div class="tab_container">
                <div id="tab1" class="tab_content">
                    <table class="tablesorter" cellspacing="0">
                        <thead>
                            <tr>

                                <th>红包码</th>
                                <th>用户ID</th>
                                <th>用户名</th>
                                <th>手机</th>
                                <th>城市地址</th>
                                <th>活动地址</th>
                                <th>领取金额</th>
                                <th>领取时间</th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr>

                                <td>XXXXX</td>
                                <td>XXXXX</td>
                                <td>XXXXX</td>
                                <td>XXXXX</td>
                                <td>XXXXX</td>
                                <td>XXXXX</td>
                                <td>XXXXX</td>
                                <td>XXXX-XX-XX</td>

                            </tr>
                           
                        </tbody>
                    </table>
                </div><!-- end of #tab1 -->

                

            </div><!-- end of .tab_container -->
            <footer>
				<div class="post_message">
					<label>汇总：&nbsp&nbsp&nbsp&nbsp 有</label>
                    <label>1</label>
                    <label>人领取红包&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 共领取</label>
                    <label>2</label>
                    <label>元&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 2元的</label>
                    <label>5</label>
                    <label>份&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 50元的 </label>
                    <label>2</label>
                    <label>份</label>
                    
				</div>
                <div class="submit_link">
                                    <input type="submit" value="导出表格" class="alt_btn">

                                </div>
			</footer>
        </article>
		
	</section>
</body>
</html>