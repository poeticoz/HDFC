<%@ Page Title="HDFC Payments" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="HDFCPayments._Default" %>


    <section class="featured">
        <div class="content-wrapper">
            <hgroup class="title">
                <h1>HDFC Payments</h1>
                <h2></h2>
            </hgroup>
            <p>
            </p>
        </div>
    </section>


    <form ID="form" name="form" action="SendPerformREQuest.aspx" method="post">
    <h3>Enter Parameters:</h3>
    <ol class="round">
        <li class="one">
            <h5>Transaction Amount</h5>
            <input type="text" name="MAmount" size="25" value="1.00" />
        </li>
        <li class="two">
            <h5>Merchant Reference No.</h5>
            <input type="text" name="MTrackid" size="25" >
            *Enter Only NUMERIC Merchant TrackID*
        </li>        
    </ol>

        <input type="submit" value="SUBMIT">
    </form>

