<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="iMidudu.Admin.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
  <article class="module width_full">
			<header><h3>汇总</h3></header>
			<div class="module_content"> 
				 
				<article class="stats_overview"  >
					<div class="overview_today">
						<p class="overview_day">后台二位码</p>
						<p class="overview_count"><%=iMidudu.AdminTool.TotalBonus %></p> 
						<p class="overview_day">可领取数量</p>
						<p class="overview_count"><%=iMidudu.AdminTool.TotalBonus-iMidudu.AdminTool.TotalBonusUsed %></p> 
					</div>
					<div class="overview_previous">
						<p class="overview_day">已用二位码总数</p>
						<p class="overview_count"><%=iMidudu.AdminTool.TotalBonusUsed %></p>
						<p class="overview_type">个</p>
						<p class="overview_count"><%=iMidudu.AdminTool.TotalBonusMoneyUsed %></p>
						<p class="overview_type">元</p>
					</div>
				</article> 
				<div class="clear"></div>
			</div>
		</article>
</asp:Content>
