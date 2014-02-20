<%@ Page Language="C#" Debug="true" %>
<html>
<head id="Head1" runat="server">
    <title></title>
    <table border="1" align="center"  width="100%" >
	<tr>
	<td align="left" width="90%"><font  size = 5 color = darkblue face = verdana ><b>Sample Page</td>
	<td align="right"width="10%"><IMG SRC="images/fssnet.JPG" WIDTH="169" HEIGHT="37" BORDER="0" ALT=""></td>
	</tr>
</table>
</head>
<BODY bgcolor="white">
	<br><br><br><br><br><br>
     <script language="C#" runat="server">
     
     
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
               
       </script>      
           
     

<br><br>

	<table border="1" align="center">
	<tr>
		<th colspan="50" bgcolor="#9999FF" ><p style= "color:white">Transaction Response </th>
	</tr>
	
			<tr>
				<td colspan="35"> Transaction Status </td>
				<td> <%= Request["Message"] %> </td>
			</tr>
			<tr>
				<td colspan="35"> Merchant Reference No:[TRACK_ID] </td>
				<td> <%= Request["ResTrackId"] %> </td>
			</tr>
			<tr>
				<td colspan="35"> Transaction Amount </td>
				<td> <%= Request["ResAmount"] %> </td>
			</tr>
					
			<tr>
				<td colspan="35"> Error Description </td>
				<td><center><FONT color="red"><b> <%=Request["ResError"] %> </FONT></td>
			</tr>			

			</table>
		</td>
	</tr>
	</table>
	<br><br><br><br><br><br><br>
	<center><A href="Index.html"><p style="color:blue"><b>Click here to enter another  transaction</b></p></A></center>
	
	<table border="1" align="center"  width="100%" >
	<tr>
	<td align="Left" width="90%"><font  size = 5 color = darkblue face = verdana ><b>Sample Page</td>
	<td align="right"width="10%"><IMG SRC="images/fssnet.JPG" WIDTH="169" HEIGHT="37" BORDER="0" ALT=""></td>
	</tr>
	</table>
 <script language="C#" runat="server">         
                 
              }
             catch (Exception Ex)
             {
                 Response.Write(Ex.Message);
             }
         }

 </script>
</body>
</html>
<!-- Disclaimer:- Important Note in Sample Pages
- This is a sample demonstration page only ment for demonstration, this page should not be used in production
- Transaction data should only be accepted once from a browser at the point of input, and then kept in a way that does not allow others to modify it (example server session, database  etc.)
- Any transaction information displayed to a customer, such as amount, should be passed only as display information and the actual transactional data should be retrieved from the secure source last thing at the point of processing the transaction.
- Any information passed through the customer's browser can potentially be modified/edited/changed/deleted by the customer, or even by third parties to fraudulently alter the transaction data/information. Therefore, all transaction information should not be passed through the browser to Payment Gateway in a way that could potentially be modified (example hidden form fields). 
 -->

