﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RedBagTotal.aspx.cs" Inherits="iMidudu.Admin.RedBagTotal" %>

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
			<h1 class="site_title"><a href="/Admin/RedBagTotal.aspx">iMidudu</a></h1>
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
                <a class="current2">红包统计</a>
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
		<article class="module width_full">
			<header><h3>Show</h3></header>
				<div class="module_content">
					<label>后台二位码总数:</label><asp:Label ID="Label1" runat="server" Text="Label" Font-Size="X-Large" Font-Bold="true"></asp:Label><br /><br />
                    <label>已用二位码总数:</label><asp:Label ID="Label2" runat="server" Text="Label" Font-Size="X-Large" Font-Bold="true"></asp:Label><br /><br />
                    <label>还有二位码可领总数:</label><asp:Label ID="Label3" runat="server" Text="Label" Font-Size="X-Large" Font-Bold="true"></asp:Label><br /><br />
                    <label>剩2元二位码总数:</label><asp:Label ID="Label4" runat="server" Text="Label" Font-Size="X-Large" Font-Bold="true"></asp:Label><br /><br />
                    <label>剩50元二位码总数:</label><asp:Label ID="Label5" runat="server" Text="Label" Font-Size="X-Large" Font-Bold="true"></asp:Label><br /><br />
                    <label>今天2元领取次数:</label><asp:Label ID="Label6" runat="server" Text="Label" Font-Size="X-Large" Font-Bold="true"></asp:Label><br /><br />
                    <label>今天5元领取次数:</label><asp:Label ID="Label7" runat="server" Text="Label" Font-Size="X-Large" Font-Bold="true"></asp:Label><br /><br />

					
				</div>
		</article><!-- end of styles article -->
		
	</section>
</body>
</html>