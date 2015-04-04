<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="iMidudu.Admin.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
    <section id="secondary_bar">

            <div class="breadcrumbs_container">
                <article class="breadcrumbs">
                    <a class="current">红包历史查看</a>
                    <div class="breadcrumb_divider"></div>
                    <a class="current2">红包统计</a>
                </article>
            </div>
        </section>
  <article class="module width_full">
			<header><h3>汇总</h3></header>
			<div class="module_content"> 
				 
				<article class="stats_overview" style="width:100%"  >
					<div class="overview_today">
						<p class="overview_day">后台二维码</p>
						<p class="overview_count"><%=iMidudu.AdminTool.TotalBonus %></p> 
						<p class="overview_day">可领取数量</p>
						<p class="overview_count"><%=iMidudu.AdminTool.TotalBonus-iMidudu.AdminTool.TotalBonusUsed %></p> 
					</div>
					<div class="overview_previous">
						<p class="overview_day">已用二维码总数</p>
						<p class="overview_count"><%=iMidudu.AdminTool.TotalBonusUsed %>个</p>
						
						<p class="overview_day">总共领走</p>
                        
                        <p class="overview_count"><%=iMidudu.AdminTool.TotalBonusMoneyUsed %>元</p>

					</div>

                    <div class="overview_today">
						<p class="overview_day">2元剩余</p>
						<p class="overview_count"><%= 598758-iMidudu.AdminTool.BonusUsed2 %></p> 
                    </div>
                    <div class="overview_previous">
						<p class="overview_day">50元剩余</p>
						<p class="overview_count"><%= 6042-iMidudu.AdminTool.BonusUsed50 %></p> 
					</div>

					<div class="overview_today">
						<p class="overview_day">今天2元领取</p>
						<p class="overview_count"><%=iMidudu.AdminTool.CountBonusByDateAndAmount(DateTime.Today,2,1) %>次</p> 
						
					</div> 
					<div class="overview_previous">
						<p class="overview_day">今天50元领取</p>
						<p class="overview_count"><%=iMidudu.AdminTool.CountBonusByDateAndAmount(DateTime.Today,5,1) %>次</p> 
						
					</div>
					<div class="overview_today">
						<p class="overview_day">昨天2元领取</p>
						<p class="overview_count"><%=iMidudu.AdminTool.CountBonusByDateAndAmount(DateTime.Today.AddDays(-1),2,1) %>次</p> 
						
					</div> 
					<div class="overview_previous">
						<p class="overview_day">昨天50元领取</p>
						<p class="overview_count"><%=iMidudu.AdminTool.CountBonusByDateAndAmount(DateTime.Today.AddDays(-1),5,1) %>次</p> 
						
					</div>
                    
					<div class="overview_today">
						<p class="overview_day">最近一周2元领取</p>
						<p class="overview_count"><%=iMidudu.AdminTool.CountBonusByDateAndAmount(DateTime.Today.AddDays(-7),2,7) %>次</p> 
						
					</div> 
					<div class="overview_previous">
						<p class="overview_day">最近一周50元领取</p>
						<p class="overview_count"><%=iMidudu.AdminTool.CountBonusByDateAndAmount(DateTime.Today.AddDays(-7),5,7) %>次</p> 
						
					</div>
                    
					<div class="overview_today">
						<p class="overview_day">最近30天2元领取</p>
						<p class="overview_count"><%=iMidudu.AdminTool.CountBonusByDateAndAmount(DateTime.Today.AddDays(-30),2,30) %>次</p> 
						
					</div> 
					<div class="overview_previous">
						<p class="overview_day">最近30天50元领取</p>
						<p class="overview_count"><%=iMidudu.AdminTool.CountBonusByDateAndAmount(DateTime.Today.AddDays(-30),5,30) %>次</p> 
					
					</div>
				</article> 
				<div class="clear"></div>
			</div>
		</article>
</asp:Content>
