<meta charset="utf-8"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<title>ClaimSync EMR</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" type="image/x-icon" href="images/icons/favicon.ico">

<!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
<!--[if lt IE 9]>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->

<!-- Le styles -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link type="text/css" href="css/custom-theme/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
<link href="css/docs.css" rel="stylesheet">
<link rel="stylesheet" href="css/styles.css">
<link rel="stylesheet" href="css/switch.css">
<style type="text/css" title="currentStyle">
    @import "css/jquery.dataTables_themeroller.css";

</style>

<style type="text/css" title="currentStyle">
    @import "css/demo_page.css";
    @import "css/demo_table_jui.css";
    @import "css/custom-theme/jquery-ui-1.8.16.custom.css";
    @import "media/css/TableTools_JUI.css";
</style>

<link href="third-party/jQuery-UI-Date-Range-Picker/css/ui.daterangepicker.css" media="screen" rel="Stylesheet" type="text/css" />
<style type="text/css">
    body{
        line-height: 25px;

    }
    .large_button {

        background-color: #3498DB;
        /*background-image: -moz-linear-gradient(center top , #3498DB, #3498DB); */
        /* box-shadow: 0 1px 0 0 #6AD2EF inset; */
        color: #FFFFFF;
        border-radius: 10px 10px 10px 10px;
        text-decoration: none;
        font-weight: lighter;
        font-family:  Helvetica, Arial, sans-serif;
        font-size: 20px;
        text-align: left;
        padding-left: 20px;
    }

    .large_button:hover {
        background-color: #FBFBFB;
        background-image: -moz-linear-gradient(center top , #FFFFFF, #F5F5F5);
        background-repeat: repeat-x;
        border: 1px solid #DDDDDD;
        border-radius: 10px 10px 10px 10px;
        box-shadow: 0 1px 0 #FFFFFF inset;
        list-style: none outside none;
        color: #777777;
        font-family:  Helvetica, Arial, sans-serif;
        /* padding: 7px 14px; */
    }
    .table th {
        border-top: 1px solid #DDDDDD;
        line-height: 10px;
        text-align: center;
        vertical-align: top;
        color: #000000;
        font-size: 11px;
    }


    body{
        overflow-x: hidden;

    }


    .table th {
        border-top: 1px solid #DDDDDD;
        line-height: 18px;
        padding: 8px;
        vertical-align: top;
    }

    .table td {
        border-top: 1px solid #DDDDDD;
        font-size: 13px;
        /*line-height: 10px;
        padding: 5px;
        padding-bottom: 0px;
        */
        vertical-align: middle; 
    }

    .ui-autocomplete {
        padding: 0;
        list-style: none;
        background-color: #fff;
        width: 218px;
        border: 1px solid #B0BECA;
        max-height: 350px;
        overflow-y: scroll;
    }
    .ui-autocomplete .ui-menu-item a {
        border-top: 1px solid #B0BECA;
        display: block;
        padding: 4px 6px;
        color: #353D44;
        cursor: pointer;
    }
    .ui-autocomplete .ui-menu-item:first-child a {
        border-top: none;
    }
    .ui-autocomplete .ui-menu-item a.ui-state-hover {
        background-color: #D5E5F4;
        color: #161A1C;
    }


    .badge_b{

        font-size: 0.8em;
        display: inline-block;
        position: relative;
        font-weight: bolder;
        background-color: #FFF;
        /* background-image: -moz-linear-gradient(center top , #45C7EB, #2698DB); */
        line-height: 1em;
        height: 1em;
        padding: .4em .6em;
        margin: -.8em 0 0 0;
        color: rgb(65, 131, 196);
        text-indent: 0;
        text-align: center;
        -webkit-border-radius: .769em;
        -moz-border-radius: .769em;
        border-radius: .769em;
        -webkit-box-shadow: inset 0px 1px 3px 0px rgba(0, 0, 0, .26), 0px 1px 0px 0px rgba(255, 255, 255, .15);
        -moz-box-shadow: inset 0px 1px 3px 0px rgba(0, 0, 0, .26), 0px 1px 0px 0px rgba(255, 255, 255, .15);
        box-shadow: inset 0px 1px 3px 0px rgba(0, 0, 0, .26), 0px 1px 0px 0px rgba(255, 255, 255, .15);
        text-shadow: 0px 1px 0px rgba(0,0,0,.5);

    }

    .ui-tabs-vertical { width: 100%; }
    .ui-tabs-vertical .ui-tabs-nav { padding: 2% 1% 2% 2%; float: left; width: 10%; }
    .ui-tabs-vertical .ui-tabs-nav li { clear: left; width: 100%; border-bottom-width: 1px !important; border-right-width: 0 !important; margin: 0 -1px .2em 0; }
    .ui-tabs-vertical .ui-tabs-nav li a { display:block; }
    .ui-tabs-vertical .ui-tabs-nav li.ui-tabs-active { padding-bottom: 0; padding-right: .1em; border-right-width: 1px; border-right-width: 1px; }
    .ui-tabs-vertical .ui-tabs-panel { padding: 1em; float: right; width: 80%;}

    .sortable { list-style-type: none; margin: 0; padding: 0; width: 100%; }
    .sortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; font-size: 1.4em; height: 18px; }
    .sortable li span { position: absolute; margin-left: -1.3em; }    


   
</style>





<link href="css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
<link href="css/chosen.css" rel="stylesheet" type="text/css" media="screen" />
<link rel="stylesheet" type="text/css" href="css/jquery.ui.combify.css" />
<style type="text/css">

    @media print { 
        .DTTT_Print {
            width: 100%
        }

        .content {
            width: 100%
        }
    }
</style>