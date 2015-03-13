﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Web;
using System.Web.Caching;

public class WX
{
	public WX()
	{
	}

    public static long    timestamp 
    {
        get
        {
            
            return  (DateTime.Now.Ticks/100000000) ;
        }
    }
    public static string nonceStr
    {
        get
        {
            return Guid.NewGuid().ToString().ToLower().Replace("-","");
        }
    }

    public static bool isIOs()
    {
        string agent = HttpContext.Current.Request.UserAgent;
        string[] keywords = {  "iPhone", "iPod", "iPad" };
        foreach (var item in keywords)
        {
            if (agent.Contains(item))
            {
                return true;
            }
        }
        return false;
    }
    public static string Token
    {
        get
        {
            var cachedToken = System.Web.HttpContext.Current.Cache.Get("token");
            //cachedToken = null;
            if (cachedToken == null)
            {
                CacheItemRemovedCallback("token", null, CacheItemRemovedReason.Expired);
                cachedToken = System.Web.HttpContext.Current.Cache.Get("token");
               
            }
            return cachedToken.ToString();
        }
    }
    private static  void CacheItemRemovedCallback(string key, object value, CacheItemRemovedReason reason)
    {
        if (key == "token")
        {
            var tokenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx8cabe7121f5369a3&secret=6066d7e2e03fbb351a9a4602f07a3a94";

            var response = System.Net.WebRequest.Create(tokenUrl).GetResponse() ;
            Stream dataStream = response.GetResponseStream();
            // Open the stream using a StreamReader for easy access.
            StreamReader reader = new StreamReader(dataStream);
            // Read the content.
            string responseFromServer = reader.ReadToEnd();
          var newToken =  Newtonsoft.Json.JsonConvert.DeserializeObject<TokenResponse>(responseFromServer);
            System.Web.HttpContext.Current.Cache.Add("token", newToken.access_token, null, DateTime.Now.AddSeconds(newToken.expires_in-5), TimeSpan.Zero, System.Web.Caching.CacheItemPriority.High, CacheItemRemovedCallback);
        }
    }
     

    public static string Ticket
    {
        get
        {
            var cachedTicket = System.Web.HttpContext.Current.Cache.Get("ticket");
            if (cachedTicket == null)
            {
                TicketItemRemovedCallback("ticket", null, CacheItemRemovedReason.Expired);
                cachedTicket = System.Web.HttpContext.Current.Cache.Get("ticket");

            }
            return cachedTicket.ToString();
        }
    }
    private static  void TicketItemRemovedCallback(string key, object value, CacheItemRemovedReason reason)
    {
        if (key == "ticket")
        {
            var tokenUrl = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+ Token + "&type=jsapi";

            var response = System.Net.WebRequest.Create(tokenUrl).GetResponse() ;
            Stream dataStream = response.GetResponseStream();
            // Open the stream using a StreamReader for easy access.
            StreamReader reader = new StreamReader(dataStream);
            // Read the content.
            string responseFromServer = reader.ReadToEnd();
          var newTicket =  Newtonsoft.Json.JsonConvert.DeserializeObject<TicketResponse>(responseFromServer);
            if (newTicket.errcode!=0)
            {
                throw new Exception(newTicket.errmsg);
            }
            System.Web.HttpContext.Current.Cache.Add("ticket", newTicket.ticket, null, DateTime.Now.AddSeconds(newTicket.expires_in-5), TimeSpan.Zero, System.Web.Caching.CacheItemPriority.High, TicketItemRemovedCallback);
        }
    }

    public static OpenIdResponse getOpenId()
    {

        var url = string.Format("https://api.weixin.qq.com/sns/oauth2/access_token?appid={0}&secret={1}&code={2}&grant_type=authorization_code",
            System.Web.Configuration.WebConfigurationManager.AppSettings["AppID"],
            System.Web.Configuration.WebConfigurationManager.AppSettings["AppSecret"],
            System.Web.HttpContext.Current.Request["code"] );

      //  Adinnet.SEQ.interfaces.Log.Add(url);
        var response = System.Net.WebRequest.Create(url).GetResponse();
        Stream dataStream = response.GetResponseStream();
        // Open the stream using a StreamReader for easy access.
        StreamReader reader = new StreamReader(dataStream);
        // Read the content.
        string responseFromServer = reader.ReadToEnd();
        var result = Newtonsoft.Json.JsonConvert.DeserializeObject<OpenIdResponse>(responseFromServer);
      //  Adinnet.SEQ.interfaces.Log.Add(responseFromServer);
      //  Adinnet.SEQ.interfaces.Log.Add("CODE:" +System.Web.HttpContext.Current.Request["code"]);
        return result;
    }

    public static UserInfo getUserInfo(OpenIdResponse openid )
    {
       // var openid = getOpenId();
        //https://api.weixin.qq.com/sns/userinfo?access_token=OezXcEiiBSKSxW0eoylIeKnhyo09fwXSJHCEJ1LNgisTLHUblD2OzRxOO0bdFyWf0cHcGYAEHp6SgtjStmnUQ4IYzA6Ht2IQzJBg9bGYKReodSh682YH6tSSy-0sj0AgiyCrLtHwXhR2XRmdt9IDcQ&openid=oo-nWs3meUO4Bu_zEWKoZYvpcr2g&lang=zh_CN
        //var url = string.Format("https://api.weixin.qq.com/cgi-bin/user/info?access_token={0}&openid={1}&lang=zh_CN", openid.access_token, openid.openid);
        var url = string.Format("https://api.weixin.qq.com/sns/userinfo?access_token={0}&openid={1}&lang=zh_CN", openid.access_token, openid.openid);
      //  Adinnet.SEQ.interfaces.Log.Add(url);

        var response = System.Net.WebRequest.Create(url).GetResponse();
        Stream dataStream = response.GetResponseStream();
        // Open the stream using a StreamReader for easy access.
        StreamReader reader = new StreamReader(dataStream);
        // Read the content.
        string responseFromServer = reader.ReadToEnd();
        var result = Newtonsoft.Json.JsonConvert.DeserializeObject<UserInfo>(responseFromServer);

       // Adinnet.SEQ.interfaces.Log.Add(responseFromServer);
        return result;
        //return getResponse<UserInfo>(url);
    }

    public static T getResponse<T>(string url)
    {

        var response = System.Net.WebRequest.Create(url).GetResponse();
        Stream dataStream = response.GetResponseStream();
        // Open the stream using a StreamReader for easy access.
        StreamReader reader = new StreamReader(dataStream);
        // Read the content.
        string responseFromServer = reader.ReadToEnd();
      //  Adinnet.SEQ.interfaces.Log.Add(responseFromServer);
        T result = Newtonsoft.Json.JsonConvert.DeserializeObject<T>(responseFromServer);
        return result;
    }

    public static string SendBounsToOpenId(string OpenId,int Money,string BounsCode,Guid AcitvityId,out string paramstr)
    {
        //var actName = iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select ActivityName from Activity where AcitvityId = @AcitvityId", new System.Data.SqlClient.SqlParameter("@AcitvityId", AcitvityId));
        //if (actName==null)
        //{
        //    throw new Exception("活动不存在");
        //}
        var actName = "test";
        Money *= 1000;
        var sb = new StringBuilder();
        sb.AppendFormat("act_name={0}", actName);
        sb.AppendFormat("&client_ip={0}", System.Web.HttpContext.Current.Request.UserHostAddress);
       // sb.AppendFormat("&logo_imgurl={0}",  );
        sb.AppendFormat("&max_value={0}", Money);
        sb.AppendFormat("&mch_billno={0}", BounsCode);
        sb.AppendFormat("&mch_id={0}", System.Web.Configuration.WebConfigurationManager.AppSettings["mch_id"]);
        sb.AppendFormat("&min_value={0}", Money);
        sb.AppendFormat("&nick_name={0}", "米嘟嘟");
        sb.AppendFormat("&nonce_str={0}", nonceStr);
        sb.AppendFormat("&re_openid={0}", OpenId);
        sb.AppendFormat("&remark={0}", "米嘟嘟备注");
        sb.AppendFormat("&send_name={0}", "米嘟嘟");
        //sb.AppendFormat("&share_content={0}",  );
        //sb.AppendFormat("&share_imgurl={0}",  );
        //sb.AppendFormat("&share_url={0}",  );
       // sb.AppendFormat("&sub_mch_id={0}",  );
        sb.AppendFormat("&total_amount={0}", Money);
        sb.AppendFormat("&total_num={0}", 1);
        sb.AppendFormat("&wishing={0}", "米嘟嘟备注");
        sb.AppendFormat("&wxappid={0}", System.Web.Configuration.WebConfigurationManager.AppSettings["AppID"]);

        var param = sb.ToString() + "&key=" + System.Web.Configuration.WebConfigurationManager.AppSettings["AppID"];
        paramstr = param;
        var md5 =  System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(param, "MD5");
        // return md5;
        paramstr += "&sign=" + md5;
        var url = "https://api.mch.weixin.qq.com/mmpaymkttransfers/sendredpack";
       

        string responseString;
        getResponseCert<PayResult>(url,paramstr, out responseString);
        return responseString;
    }


    private static T getResponseCert<T>(string url,string postData,out string responseString) where T :new()
    {
        X509Certificate Cert = X509Certificate.CreateFromCertFile("C:\\网站证书\\iMidudu.cer"); //证书存放的绝对路径
       // ServicePointManager.CertificatePolicy = new CertPolicy(); //处理来自证书服务器的错误信息
        HttpWebRequest Request = (HttpWebRequest)WebRequest.Create(url);  
        Request.ClientCertificates.Add(Cert);
        Request.UserAgent = "Mitchell Chu robot test"; // 使用的客户端，如果服务端没有要求可以随便填写
        Request.Method = "POST"; // 请求的方式：POST/GET 
        byte[] byteArray = Encoding.UTF8.GetBytes(postData);
        // Set the ContentType property of the WebRequest.
        Request.ContentType = "application/x-www-form-urlencoded";
        // Set the ContentLength property of the WebRequest.
        Request.ContentLength = byteArray.Length;
        // Get the request stream.
        Stream dataStream = Request.GetRequestStream();
        // Write the data to the request stream.
        dataStream.Write(byteArray, 0, byteArray.Length);
        // Close the Stream object.
        dataStream.Close();
        var response = Request.GetResponse();
        Stream dataStreamres = response.GetResponseStream();
        // Open the stream using a StreamReader for easy access.
        StreamReader reader = new StreamReader(dataStreamres);
        // Read the content.
        string responseFromServer = reader.ReadToEnd();
        //  Adinnet.SEQ.interfaces.Log.Add(responseFromServer);
        try
        {

            T result = Newtonsoft.Json.JsonConvert.DeserializeObject<T>(responseFromServer);
            responseString = responseFromServer;
            return result;
        }
        catch (Exception ex )
        {
            responseString = responseFromServer;
            return new T();
        }
    }

    public class PayResult
    {
        public string return_code { get; set; }
        public string return_msg { get; set; }
    }
    public static bool isUserFocused(string openid)
    {
        FocusedUserResponse users = null;
        WX.FocusedUser(ref users);
        return users.data.openid.Contains(openid); 

    }

    public static void FocusedUser(ref FocusedUserResponse init)
    { 
        var url = string.Format("https://api.weixin.qq.com/cgi-bin/user/get?access_token={0}&next_openid={1}",Token, init==null?null :init.next_openid);
        var r = getResponse<FocusedUserResponse>(url);
        if (init==null)
        {
            init = r;
        }
        else
        {
            init.next_openid = r.next_openid;
            if (r.data != null)
            {
                init.data.openid.AddRange(r.data.openid);
            }
        }
        if (!string.IsNullOrEmpty(init.next_openid))
        {
            FocusedUser(ref init);
        } 
    }
    public static WXconfig Config(string Url)
    {
        //debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
        //            appId: 'wx8cabe7121f5369a3', // 必填，公众号的唯一标识
        //            timestamp: <%= WX.timestamp %>, // 必填，生成签名的时间戳
        //    nonceStr: '<%=WX.nonceStr%>', // 必填，生成签名的随机串
        //    signature: '',// 必填，签名，见附录1
        //    jsApiList: [] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
        var config = new WXconfig()
        {
            appId =
            System.Web.Configuration.WebConfigurationManager.AppSettings["AppID"],
            timestamp = WX.timestamp,
            debug = true,
            nonceStr = WX.nonceStr,
             ticket= Ticket
        };

        config.jsApiList.Add("");



        String nonce_str = config.nonceStr;
        String timestamp = config.timestamp.ToString();
        String string1;
       
        //注意这里参数名必须全部小写，且必须有序
        string1 = "jsapi_ticket=" + config.ticket +
                  "&noncestr=" + nonce_str +
                  "&timestamp=" + timestamp +
                  "&url=" + Url;
        //string1 = string.Format("jsapi_ticket={0}&noncestr={1}&timestamp={2}&url={3}",config.ticket,);
        ////建立SHA1对象
        //SHA1 sha = new SHA1CryptoServiceProvider();

        ////将mystr转换成byte[]
        //ASCIIEncoding enc = new ASCIIEncoding();
        //byte[] dataToHash = enc.GetBytes(string1);

        ////Hash运算
        //byte[] dataHashed = SHA1.Create().ComputeHash(dataToHash);

        ////将运算结果转换成string
        //string hash = BitConverter.ToString(dataHashed).Replace("-", "");
        config.signature = Sha1(string1);
        return config;
    }
    public static string Sha1(string orgStr, string encode = "UTF-8")
    {
        var sha1 = new SHA1Managed();
        var sha1bytes = System.Text.Encoding.GetEncoding(encode).GetBytes(orgStr);
        byte[] resultHash = sha1.ComputeHash(sha1bytes);
        string sha1String = BitConverter.ToString(resultHash).ToLower();
        sha1String = sha1String.Replace("-", "");
        return sha1String;
    }
    //public  static string Sign(string nonceStr,string Url)
    //{

    //}

    //private static string Encrypted(string targetPassword)
    //{
    //    byte[] pwBytes = Encoding.UTF8.GetBytes(targetPassword);
    //    byte[] hash = SHA1.Create().ComputeHash(pwBytes);
    //    StringBuilder hex = new StringBuilder();
    //    for (int i = 0; i < hash.Length; i++) hex.Append(hash[i].ToString("X2"));

    //    return hex.ToString();
    //}
}

public class BounsPostParams
{
    public string nonce_str { get; set; }
    public string sign { get; set; }
    public string mch_billno { get; set; }
    public string mch_id { get; set; }
    public string sub_mch_id { get; set; }
    public string wxappid { get; set; }
    public string nick_name { get; set; }
    public string send_name { get; set; }
    public string re_openid { get; set; }
    public int total_amount { get; set; }
    public int min_value { get; set; }
    public int max_value { get; set; }  
    public int total_num { get; set; }   
    public string wishing { get; set; }   
    public string client_ip { get; set; }
    public string act_name { get; set; }

    public string remark { get; set; }

    public string logo_imgurl { get; set; }

    public string share_content { get; set; }

    public string share_url { get; set; }

    public string share_imgurl { get; set; }
}

public class WXconfig
{

    public WXconfig()
    {
        this.jsApiList = new List<string>();
    }
    public string appId { get; set; }
    public long timestamp
    {
        get; set;
    }
    public string nonceStr { get; set; }

    public string signature { get; set; }
    public List<string> jsApiList { get; set; }
    public bool debug { get; set; }
    public string ticket { get; set; }

}

public class UserInfo
{
   // public int subscribe { get; set; }
    public string openid { get; set; }
    public string nickname { get; set; }
    public int sex { get; set; }
    public string language { get; set; }
    public string city { get; set; }
    public string province { get; set; }
    public string country { get; set; }
    public string headimgurl { get; set; }
   // public int subscribe_time { get; set; }
    public string unionid { get; set; }
    public List<string> privilege { get; set; }
}

public class TokenResponse
{
    public string access_token { get; set; }
    public int expires_in { get; set; }
}

public class TicketResponse
{
    public int errcode { get; set; }
    public string errmsg { get; set; }
    public string ticket { get; set; }
    public int expires_in { get; set; }
}


public class OpenIdResponse
{
    public string access_token { get; set; }
    public int expires_in { get; set; }
    public string refresh_token { get; set; }
    public string openid { get; set; }
    public string scope { get; set; }
}


public class FocusedUserResponse
{
    public int total { get; set; }
    public int count { get; set; }

    public FocuedUserData data { get; set; }
    public string next_openid { get; set; }
    public class FocuedUserData
    {
        public FocuedUserData()
        {
            this.openid = new List<string>();
        }
        public List<string> openid { get; set; }
    }
}

