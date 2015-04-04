<%@ Page Language="C#"  %>


<%
    var url = this.Request["state"];
    var wxcode = this.Request["code"];
    url = url + "&wxcode=" + wxcode;
    this.Response.Write(url);

    this.Response.Redirect(url);


         %>
code:
<%=this.Request["code"] %>,state:
<%=this.Request["state"] %>