<%@ Page Language="C#"    %>
<script runat="server">
    private string GetClientIP()
{
   string result = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
   if (null == result || result == String.Empty)
   {
    result = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
   }

   if (null == result || result == String.Empty)
   {
    result = HttpContext.Current.Request.UserHostAddress;
   }
   return result;
}
    [System.Runtime.InteropServices.DllImport("Iphlpapi.dll")] 
private static extern int SendARP(Int32 dest,Int32 host,ref Int64 mac,ref Int32 length); 
[System.Runtime.InteropServices.DllImport("Ws2_32.dll")]
private static extern Int32 inet_addr(string ip);
    private void Page_Load(object sender, System.EventArgs e)
{
   // 在此处放置用户代码以初始化页面
   try
   {
    string userip=Request.UserHostAddress;
    string strClientIP = Request.UserHostAddress.ToString().Trim();
    Int32 ldest = inet_addr(strClientIP); //目的地的ip 
    Int32 lhost = inet_addr("");   //本地服务器的ip 
    Int64 macinfo = new Int64(); 
    Int32 len = 6; 
    int res = SendARP(ldest,0, ref macinfo, ref len);
    string mac_src=macinfo.ToString("X");
    if(mac_src == "0")
    {
     if(userip=="127.0.0.1")
      Response.Write ("正在访问Localhost!");
     else
      Response.Write ("欢迎来自IP为" + userip + "的朋友！" + "<br>");
     return;
    }

    while(mac_src.Length<12)
    {
     mac_src = mac_src.Insert(0,"0");
    }

    string mac_dest="";

    for(int i=0;i<11;i++)
    {
     if (0 == (i % 2))
     {
      if ( i == 10 )
      {
       mac_dest = mac_dest.Insert(0,mac_src.Substring(i,2));
      }
      else
      {
       mac_dest ="-" + mac_dest.Insert(0,mac_src.Substring(i,2));
      }
     } 
    }

    Response.Write ("欢迎来自IP为"+userip+ "<br>" + ",MAC地址为"+mac_dest+"的朋友！"

     +   "<br>");
   }
   catch(Exception err) 
   { 
    Response.Write(err.Message);
   }
}

</script>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    用户订阅成功
    <br />
     <%  iMidudu.InsertBouns.Insert();%>
    bonus:<%=this.Session["bonus"]  %>
    <br />
    openid:<%=this.Session["openid"]  
    
        
        %>
    <%
        var d = iMidudu.Data.Instance.Activity.ToList();

        foreach (var item in d)
        {
            Response.Write(item.ActivityName);
        }
        //using (iMidudu.iMiduduEntities e = new iMidudu.iMiduduEntities())
        //{
        //}
         %>
    <%=iMidudu.Biz.IsMembership("222") %>
</body>
</html>
