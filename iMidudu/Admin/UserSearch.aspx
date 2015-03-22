<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="UserSearch.aspx.cs" Inherits="iMidudu.Admin.UserSearch" %>
<script runat="server"> 

    private string ky = "";
    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
        ky = this.Request["key"];
    }

</script>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
    
		<div class="quick_search width_half_search">
			<input type="text" value="<%=ky ==null?"按用户名查找" :ky %>" onfocus="if(!this._haschanged){this.value=''};this._haschanged=true;" name="key">
		</div>
        

        <article class="module width_full">
            <header>
                <h3 class="tabs_involved">查询条件<%=ky ==null?"无" :ky %></h3>

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
                                <th>国家</th>
                                <th>省</th>
                                <th>区</th>
                                <th>活动名称</th>
                                <th>领取金额</th>
                                <th>领取时间</th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr>

                                <td>XXXXX</td>
                                <td>XXXXX</td>
                                <td>XXXXX</td>
                                <td>XXXXX</td>                                    <td>XXXXX</td>
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
		
	
</asp:Content>
