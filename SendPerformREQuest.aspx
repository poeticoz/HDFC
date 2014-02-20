<%@ Page Language="C#" Debug="true" %>

<script language="C#" runat="server">

/******************************************************************
			* COMPANY    - FSS Pvt. Ltd.
********************************************************************

Name of the Program : Hosted UMI Sample Pages
Page Description    : Allows Merchant to connect Payment Gateway and send request
Request parameters  : TranporatID,TranportalPassword,Action,Amount,Currency,Merchant 
                      Response/Error URL & TrackID,Language,UDF1-UDF5
Response parameters : Payment Id, Pay Page URL, Error
Values from Session : No 
Values to Session   : No
Created by          : FSS Payment Gateway Team
Created On          : 30-04-2012
Version             : Version 3.0
					
*****************************************************************
NOTE - 
This sample pages are developed and tested on below platform

Visual Studio    : 2008
Application      - IIS 5.1
Operating System - Windows Server 2003
*****************************************************************

Disclaimer:- Important Note in Sample Pages
- This is a sample demonstration page only ment for demonstration, this page 
should not be used in production
- Transaction data should only be accepted once from a browser at the point 
of input, and then kept in a way that does not allow others to modify it 
(example server session, database  etc.)
- Any transaction information displayed to a customer, such as amount, should 
be passed only as display information and the actual transactional data should 
be retrieved from the secure source last thing at the point of processing the transaction.
- Any information passed through the customer's browser can potentially be 
modified/edited/changed/deleted by the customer, or even by third parties to 
fraudulently alter the transaction data/information. Therefore, all transaction 
information should not be passed through the browser to Payment Gateway in a way
that could potentially be modified (example hidden form fields). 
*****************************************************************
*/

/* 
IMPORTANT INFORMATION
This document is provided by Financial Software and System Pvt Ltd on the basis 
that you will treat it as private and confidential.

Data used in examples and sample data files are intended to be fictional and any 
resemblance to real persons or entities is entirely coincidental.

This example assumes that a form has been sent to this example with the required 
fields. The example then processes the command and displays the receipt or error 
to a HTML page in the users web browser.
*/

/*  sign "&" is mandatory to mention with in the end of passed value, in below section this 
to make the string  Merchant can use their on logic of creating the string with required 
inputs, below is just a basic method on how to create a request string and pass the values 
to Payment Gateway */

protected void Page_Load(object sender, EventArgs e)        
{   
		try
		{
						
			/*Getting Transaction Amount and Merchant TrackID from Initial HTML page
			Since this sample page for demonstration, values from HTML page are directly
			taken from browser and used for transaction processing. Merchants SHOULD NOT
			follow this practice in production environment. */
			string TranTrackid=Request["MTrackid"];
			string TranAmount=Request["MAmount"];	

			/* to pass Tranportal ID provided by the bank to merchant. Tranportal ID is sensitive information
			of merchant from the bank, merchant MUST ensure that Tranportal ID is never passed to customer 
			browser by any means. Merchant MUST ensure that Tranportal ID is stored in secure environment & 
			securely at merchant end. Tranportal Id is referred as id. Tranportal ID for test and production will be 
			different, please contact bank for test and production Tranportal ID*/
            string ReqTranportalId = "id=" + "90003360" + "&";

			/* to pass Tranportal password provided by the bank to merchant. Tranportal password is sensitive 
			information of merchant from the bank, merchant MUST ensure that Tranportal password is never passed 
			to customer browser by any means. Merchant MUST ensure that Tranportal password is stored in secure 
			environment & securely at merchant end. Tranportal password is referred as password. Tranportal 
			password for test and production will be different, please contact bank for test and production
			Tranportal password */
			string ReqTranportalPassword = "password="+"password1"+"&";

			/* Action Code of the transaction, this refers to type of transaction. Action Code 1 stands of 
			Purchase transaction and action code 4 stands for Authorization (pre-auth). Merchant should 
			confirm from Bank action code enabled for the merchant by the bank*/ 
			string ReqAction = "action="+"1"+"&";

			/* Transaction language, THIS MUST BE ALWAYS USA. */
			string ReqLangid = "langid="+"USA"+"&";

			/* Currency code of the transaction. By default INR i.e. 356 is configured. If merchant wishes 
			to do multiple currency code transaction, merchant needs to check with bank team on the available 
			currency code */
			string ReqCurrency = "currencycode="+"356"+"&";

			/* Transaction Amount that will be send to payment gateway by merchant for processing
			NOTE - Merchant MUST ensure amount is sent from merchant back-end system like database
			and not from customer browser. In below sample AMT is hard-coded, merchant to pass 
			trasnaction amount here. */
			string ReqAmount = "amt="+TranAmount+"&";

			/* Response URL where Payment gateway will send response once transaction processing is completed 
			Merchant MUST esure that below points in Response URL
			1- Response URL must start with http://
			2- the Response URL SHOULD NOT have any additional paramteres or query string */
            string ReqResponseUrl = "responseURL=" + "http://localhost:57027/GetHandleRESponse.aspx" + "&";

			/* Error URL where Payment gateway will send response in case any issues while processing the transaction 
			Merchant MUST esure that below points in ErrorURL 
			1- error url must start with http://
			2- the error url SHOULD NOT have any additional paramteres or query string
			*/
            string ReqErrorUrl = "errorURL=" + "http://localhost:57027/FailedTRAN.aspx" + "&";

			/* To pass the merchant track id, in below sample merchant track id is hard-coded. Merchant
			MUST pass his transaction ID (track ID) in this parameter. Track Id passed here should be 
			from merchant backend system like database and not from customer browser*/
			string ReqTrackId="trackid="+TranTrackid+"&";
           

			/* User Defined Fileds as per Merchant or bank requirment. Merchant MUST ensure merchant 
			merchant is not passing junk values OR CRLF in any of the UDF. In below sample UDF values 
			are not utilized */
			string ReqUdf1 = "udf1="+"Test1"+"&";		// UDF1 values                                                                
			string ReqUdf2 = "udf2="+"Test2"+"&";		// UDF2 values 	                                                               
			string ReqUdf3 = "udf3="+"Test3"+"&";	 	// UDF3 values                                                             
			string ReqUdf4 = "udf4="+"Test4"+"&";	 	// UDF4 values                                                                
			string ReqUdf5 = "udf5="+"Test5"+"&";
            // UDF5 values 

			string TranResponse = "";//Declaration of variable 
            
            
			//=================================================================================================================================	

			/*
			ME should now do the validations on the amount value set like - 
			a) Transaction Amount should not be blank and should be only numeric
			b) Language should always be USA
			c) Action Code should not be blank
			d) UDF values should not have junk values and CRLF (line terminating parameters)Like--> [ !#$%^&*()+[]\\\';,{}|\":<>?~` ]
			*/
	  

			/* Now merchant sets all the inputs in one string for passing to the Payment Gateway URL */
            string TranRequest = ReqTranportalId + ReqTranportalPassword + ReqAction + ReqLangid + ReqCurrency + ReqAmount + ReqResponseUrl + ReqErrorUrl + ReqTrackId + ReqUdf1 + ReqUdf2 + ReqUdf3 + ReqUdf4 + ReqUdf5;

			//====================================================================================
  

			/* This is Payment Gateway Test URL where merchant sends request. This is test enviornment URL, 
			production URL will be different and will be shared by Bank during production movement */
			string TranUrl = "https://securepgtest.fssnet.co.in/pgway/servlet/PaymentInitHTTPServlet";

			/* 
			Log the complete request in the log file for future reference
			Now creating a connection and sending request
			*/

			//create a SSL connection xmlhttp formated object server-to-server
		   System.IO.StreamWriter myWriter = null;
			// it will open a http connection with provided url
		   System.Net.HttpWebRequest objRequest = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(TranUrl);//send data using objxmlhttp object
           objRequest.Method = "POST";
           objRequest.ContentLength = TranRequest.Length;
           objRequest.ContentType = "application/x-www-form-urlencoded";//to set content type
           myWriter = new System.IO.StreamWriter(objRequest.GetRequestStream());
           myWriter.Write(TranRequest);//send data
           myWriter.Close();//closed the myWriter object

           System.Net.HttpWebResponse objResponse = (System.Net.HttpWebResponse)objRequest.GetResponse();
			//receive the responce from objxmlhttp object 
           using (System.IO.StreamReader sr =new System.IO.StreamReader(objResponse.GetResponseStream()))
                {
					TranResponse = sr.ReadToEnd();

					string[] ErrorCheck = GetStringInBetween(TranResponse, "!", "!-", false, false);//This line will find Error Keyword in TranResponse	

					if (ErrorCheck[0]!= "ERROR")//This block will check for Error in TranResponce
					{
							// Merchant MUST map (update) the Payment ID received with the merchant Track Id in his database at this place.
							string payid=TranResponse.Substring(0,TranResponse.IndexOf(":http"));
							string payURL=TranResponse.Substring(TranResponse.IndexOf("http"));
							// here redirecting the customer browser from ME site to Payment Gateway Page with the Payment ID
							string TranRedirect=payURL+"?PaymentID="+payid;
							Response.Redirect(TranRedirect);
					}
					else
					{


                        string TranErrorUrl = "http://localhost:57027/FailedTRAN.aspx?Message=Transaction Failed&ResTrackId=" + TranTrackid + "&ResAmount=" + TranAmount + "&ResError=" + TranResponse;
																							
							// here redirecting the error page 
							Response.Redirect(TranErrorUrl);
					}			
				
                }
		}
		catch (Exception ex)// any excpetion occurred for above code exception throws here
		{
		  Response.Write(ex);// exception message
		}

}//page load event ends here

//GetStringInBetween function to find string between two string
public static string[] GetStringInBetween(string strSource, string strBegin, string strEnd, bool includeBegin, bool includeEnd)
        {
            string[] result = { "", "" };
            int iIndexOfBegin = strSource.IndexOf(strBegin);
            if (iIndexOfBegin != -1)
            {
                // include the Begin string if desired

                if (includeBegin)
                {
                    iIndexOfBegin -= strBegin.Length;
                }
                strSource = strSource.Substring(iIndexOfBegin + strBegin.Length);
                int iEnd = strSource.IndexOf(strEnd);
                if (iEnd != -1)
                {  // include the End string if desired
                    if (includeEnd)
                    { iEnd += strEnd.Length; }
                    result[0] = strSource.Substring(0, iEnd);
                    // advance beyond this segment
                    if (iEnd + strEnd.Length < strSource.Length)
                    { result[1] = strSource.Substring(iEnd + strEnd.Length); }
                }
            }
            else
            // stay where we are
            { result[1] = strSource; }
            return result;
        }//String function end
</script>

