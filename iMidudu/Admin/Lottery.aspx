﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
<script>
        //$(function () {
        //    $("#doLottery").click(
        //     function () {
        //         $("#doLottery").hide();
        //         $.post("/WebService.asmx/Lottery",
        //              function (data) {
        //                  data = $(data);
        //                  var OpenId = data.OpenId;
        //                  var UserName = data.UserName;
        //                  var Sex = data.Sex;
        //                  var Mobile = data.Mobile;
        //                  var RegDate = data.RegDate;
        //                  var Country = data.Country;
        //                  var Province = data.Province;
        //                  var City = data.City;
        //                  var Nickname = data.Nickname;
        //                  var Pic = data.Pic;
        //                  var RecentLoginDate = data.RecentLoginDate;
        //                  $("#u").html("OpenId:" + OpenId + "验证用户名:" + UserName + "微信昵称:" + Nickname + "性别:" + Sex + "手机" + Mobile + "国家" + Country + "省" + Province + "市（区）" + City + "注册时间" + RegDate + "最近登录时间" + RecentLoginDate);
        //                 // window.location.reload();
        //              });
        //     });
    //})
    $(function () {
        $("#doLottery1").click(function () {
            doLottery(function (success) {
                if (success) {
                        window.location.reload();
                }
            });
        });
    });


    function doLottery() {
        var data = {};
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "/Webservice.asmx/Lottery",
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                
                    var OpenId = result.d.OpenId;
                    var UserName = result.d.UserName;
                    var Sex = result.d.Sex;
                    var Mobile = result.d.Mobile;
                    var RegDate = result.d.RegDate;
                    var Country = result.d.Country;
                    var Province = result.d.Province;
                    var City = result.d.City;
                    var Nickname = result.d.Nickname;
                    var Pic = result.d.Pic;
                    var RecentLoginDate = result.d.RecentLoginDate;
                    $("#u").html("<center>" + "OpenId:" + OpenId + "<br/>" + "验证用户名:" + UserName + "<br/>" + "微信昵称:" + Nickname + "<br/>" + "手机:" + Mobile + "<br/>" + "国家:" + Country + "<br/>" + "省:" + Province + "<br/>" + "市（区）:" + City + "<br/>" + "注册时间:" + RegDate + "<br/>" + "最近登录时间:" + RecentLoginDate + "</center>");
            }
        });
    }
</script>
<center>
    <input type="submit" value="抽奖" id="doLottery1"  class="alt_btn"/>
</center>

<div id="u">
</div>
</asp:Content>
