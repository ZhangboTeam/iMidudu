<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
<script>
        $(function () {
            $("#doLottery").click(
             function () {
                 $("#doLottery").hide();
                 $.post("/WebService.asmx/Lottery",
                      function (data) {
                          var OpenId = data.OpenId;
                          var UserName = data.UserName;
                          var Sex = data.Sex;
                          var Mobile = data.Mobile;
                          var RegDate = data.RegDate;
                          var Country = data.Country;
                          var Province = data.Province;
                          var City = data.City;
                          var Nickname = data.Nickname;
                          var Pic = data.Pic;
                          var RecentLoginDate = data.RecentLoginDate;
                          $("#u").html("OpenId:" + OpenId + "验证用户名:" + UserName + "微信昵称:" + Nickname + "性别:" + Sex + "手机" + Mobile + "国家" + Country + "省" + Province + "市（区）" + City + "注册时间" + RegDate + "最近登录时间" + RecentLoginDate);
                          window.location.reload();
                      });
             });
        })
</script>
    <input type="submit" value="抽奖" id="doLottery"  class="alt_btn"/>


<div id="u">
</div>
</asp:Content>
