<%@ Page Title="黑名单" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
<section id="main" class="column">
		<article class="module width_full">
		<header>
		<ul class="tabs">
   			<li><a href="#tab1">Show</a></li>
    		<li><a href="#tab2">Create</a></li>
		</ul>
<%--		    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
            </asp:Repeater>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:iMiduduConnectionString %>" SelectCommand="SELECT [AcitvityId], [BonusGroupId], [BonusLimit], [ActivityName], [BeginDate], [EndDate] FROM [Activity]"></asp:SqlDataSource>--%>
		</header>

		<div class="tab_container">
			<div id="tab1" class="tab_content">
			<table class="tablesorter" cellspacing="0"> 
			<thead> 
				<tr> 
    				<th>OpenID</th> 
    				<th>用户名</th> 
    				<th>微信名</th> 
                    <th>电话</th>
                    <th>最近登录时间</th>
                    <th>结束时间</th>
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
    			
				</tr> 
		
			</tbody> 
			</table>
			</div><!-- end of #tab1 -->
			
			<div id="tab2" class="tab_content">
			<table class="tablesorter2" cellspacing="0"> 
			    
                <fieldset>
                                <label>活动ID</label>
                                <input type="text" id="AcitvityId"style="width:30%"/><br /><br />
                                <p></p>
                                <p></p>
                                <label>红包分组</label>
                                <input type="text"id="BonusGroupId" style="width:30%"/><br /><br />
                                <p></p>
                                <p></p>
                                <label>活动名称</label>
                                <input type="text"id="BonusLimit" style="width:30%"/><br /><br />
                                 <p></p>
                                <p></p>
                                <label>限令次数</label>
                                <input type="text"id="ActivityName" style="width:30%"/><br /><br />
                                 <p></p>
                                <p></p>
                                <label>开始时间</label>
                                <input type="text"id="BeginDate" style="width:30%"/><br /><br />
                                 <p></p>
                                <p></p>
                                <label>结束时间</label>
                                <input type="text"id="EndDate" style="width:30%"/><br /><br />
                            </fieldset>


                            <footer>
                                <div class="submit_link">
                                    <input type="submit" value="确定" id="createactivity" class="alt_btn"/>
                                </div>
                            </footer>
			</table>

			</div><!-- end of #tab2 -->
			
		</div><!-- end of .tab_container -->
		
		</article><!-- end of content manager article -->
		
	</section>
</asp:Content>
