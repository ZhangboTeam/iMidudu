<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">


    <script type="text/javascript">
        $(function () {
            $('.column').equalHeight();
        });


        $("#delete").click(
           function () {
               var UserName = $("#userid").val();
               $.post("/WebService.asmx/DeleteUser",
                   {
                       OpenId: userid,
                   }, function (data) {

                   });
               var r = $(data).text();
               if (r == "OK") {
                   window.location = "/UserManage.aspx";
               }
               else {
                   alert(r);
               }

           });




</script>

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

                                <th>用户ID</th>
                                <th>用户名</th>
                                <th>性别</th>
                                <th>电话</th>
                                <th>注册时间</th>
                                <th>国家</th>
                                <th>省</th>
                                <th>区</th>
                                <th>昵称</th>
                                <th>最近登录时间</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>

                                <td id="userid">XXXXX</td>
                                <td>杨继孟</td>
                                <td>未知</td>
                                <td>XXXXXXXXXXX</td>
                                <td>XXXX-XX-XX</td>
                                <td>XXXXX</td>
                                <td>XXX</td>
                                <td>XXX</td>
                                <td>XXXXXXXXXXX</td>
                                <td>XXXX-XX-XX</td>
                                <td><input type="image" src="images/icn_trash.png" id="delete" title="Trash"></td>
                            </tr>
                           
                        </tbody>
                    </table>
                </div><!-- end of #tab1 -->

                

            </div><!-- end of .tab_container -->

        </article>
		
	</section>
</asp:Content>
