<%@ Page Language="C#"  %>  
  <%

      var rr = WX.getOpenId(this.Request["code"]);
      var r = WX.getUserInfo(rr);// WX.getOpenId();

      var sql2 = string.Format("update MembershipInfo set Country=N'{0}',Province=N'{1}',City=N'{2}',NickName=N'{3}',Pic=N'{4}' where OpenId='{5}'",
           r.country,r.province,r.city,r.nickname,    r .headimgurl, r.openid

          );
      var cn = new System.Data.SqlClient.SqlConnection();
      cn.ConnectionString = System.Web.Configuration.WebConfigurationManager.AppSettings["con"];

      var cmd = new System.Data.SqlClient.SqlCommand(sql2, cn);
      cn.Open();
       cmd.ExecuteNonQuery();
      cn.Close();

      var state = this.Request["state"];
      //var acitvity = this.Request["acitvity"];
      var obj = Newtonsoft.Json.JsonConvert.DeserializeObject<Param>(state);
      var param = "?bouns=" + obj.b + "&acitvity=" + obj.a + "&openid=" + rr.openid + "&code=" + this.Request["code"]  ;

      
      Response.Write(obj.b);
      Response.Write(obj.a);

      Response.Redirect("/UseBouns.aspx"+param);


%>
     