<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">

    <script type="text/javascript">
        $(function () {
            $('.column').equalHeight();
        });



        $("#createactivity").click(
           function () {
               var AcitvityId = $("#AcitvityId").val();
               var BonusGroupId = $("#BonusGroupId").val();
               var BonusLimit = $("#BonusLimit").val();
               var ActivityName = $("#ActivityName").val();
               var BeginDate = $("#BeginDate").val();
               var EndDate = $("#EndDate").val();
               if (UserName == "") {
                   alert("请输入活动id"); return;
               }
               if (PassWord == "") {
                   alert("请输入红包分组"); return;
               }
               if (UserName == "") {
                   alert("请输入活动名称"); return;
               }
               if (PassWord == "") {
                   alert("请输入限令次数"); return;
               }
               if (UserName == "") {
                   alert("请输入开始时间"); return;
               }
               if (PassWord == "") {
                   alert("请输入结束时间"); return;
               }
               $.post("/WebService.asmx/UpdateActivity",
                   {
                       AcitvityId: AcitvityId,
                       BonusGroupId: BonusGroupId,
                       BonusLimit: BonusLimit,
                       ActivityName: ActivityName,
                       BeginDate: BeginDate,
                       EndDate: EndDate,
                   }, function (data) {

                   });
               var r = $(data).text();
               if (r == "OK") {
                   window.location = "/ActivityManage.aspx";
               }
               else {
                   alert(r);
               }

           });
</script>


		<article class="module width_full">
		<header>
		<ul class="tabs">
   			<li><a href="#tab1">Show</a></li>
    		<li><a href="#tab2">Create</a></li>
		</ul>

            
		</header>

		<div class="tab_container">
			<div id="tab1" class="tab_content">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:iMiduduConnectionString %>" SelectCommand="SELECT [AcitvityId], [BonusGroupId], [BonusLimit], [ActivityName], [BeginDate], [EndDate] FROM [Activity]"></asp:SqlDataSource>
		    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <HeaderTemplate>			
                <table class="tablesorter" cellspacing="0"> 
			<thead> 
				<tr> 
    				<th>活动ID</th> 
    				<th>红包分组</th> 
    				<th>活动名称</th> 
                    <th>限令次数</th>
                    <th>开始时间</th>
                    <th>结束时间</th>
				</tr> 
			</thead> 
                        </HeaderTemplate>
                        <ItemTemplate>
			<tbody> 
				<tr> 
    				<td><%#Eval("AcitvityId") %></td> 
    				<td><%#Eval("BonusGroupId") %></td> 
    				<td><%#Eval("BonusLimit") %></td> 
                    <td><%#Eval("ActivityName") %></td> 
                    <td><%#Eval("BeginDate") %></td>
                    <td><%#Eval("EndDate") %></td> 
    			
				</tr> 
                        </ItemTemplate>
                        <FooterTemplate>


                        </tbody>
                    </table>
                        </FooterTemplate>
                                    </asp:Repeater>
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
		



</asp:Content>
