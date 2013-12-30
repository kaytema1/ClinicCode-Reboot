<!DOCTYPE html>
<html lang="en">
    <head>
        <% Users user = (Users) session.getAttribute("staff");
    if (user == null) {
        session.setAttribute("lasterror", "Please Login");
        response.sendRedirect("index.jsp");
    }
    HMSHelper mgr = new HMSHelper();
%>
        <meta charset="utf-8">
        <title>ClaimSync Extended</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

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
        <style type="text/css" title="currentStyle">
            @import "css/jquery.dataTables_themeroller.css";
            @import "css/custom-theme/jquery-ui-1.8.16.custom.css";
        </style>
        <link href="css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="third-party/jQuery-UI-Date-Range-Picker/css/ui.daterangepicker.css" media="screen" rel="Stylesheet" type="text/css" />
        <script type="application/javascript" src="js/jquery-1.6.2.min.js"></script>
        <script type="text/javascript">
            $(function() {
                var chart;
                var chart1;
                var chart2;
                var chart3;
                $(document).ready(function() {
                    chart = new Highcharts.Chart({
                        chart : {
                            renderTo : 'chart_div',
                            type : 'line',
                            marginRight : 5,
                            height: 210
                        },
						
                        title : {
                            text : 'Total Patient Attendance',

                        },

                        xAxis : {
							
                            categories : ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],

                            labels : {
                                formatter : function() {
                                    return this.value;
                                    // clean, unformatted number for year
                                },
                                startOnTick : true

                            }
                        },
                        yAxis : {
                            min: 0,
                            title : {
                                text : 'Number of Patients'
                            }
                        },
                        tooltip : {
                            formatter : function() {
                                return Highcharts.numberFormat(this.y, 0) + ' Patients in ' + this.x;
                            }
                        },

                        series : [{
                                name : 'All Patients',
                                data : [<%=mgr.listVisitations("Jan", "2012").size()%>, 
            <%=mgr.listVisitations("Feb", "2012").size()%>, 
            <%=mgr.listVisitations("Mar", "2012").size()%>, 
            <%=mgr.listVisitations("Apr", "2012").size()%>, 
            <%=mgr.listVisitations("May", "2012").size()%>,
            <%=mgr.listVisitations("Jun", "2012").size()%>, 
            <%=mgr.listVisitations("Jul", "2012").size()%>,
            <%=mgr.listVisitations("Aug", "2012").size()%>, 
            <%=mgr.listVisitations("Sep", "2012").size()%>, 
            <%=mgr.listVisitations("Oct", "2012").size()%>,
            <%=mgr.listVisitations("Nov", "2012").size()%>, 
            <%=mgr.listVisitations("Dec", "2012").size()%>]
                                    }, {
                                        name : 'Inpatients',
                                        data : [<%=mgr.listVisitations("Jan", "2012", "In Patient").size()%>, 
            <%=mgr.listVisitations("Feb", "2012", "In Patient").size()%>, 
            <%=mgr.listVisitations("Mar", "2012", "In Patient").size()%>, 
            <%=mgr.listVisitations("Apr", "2012", "In Patient").size()%>, 
            <%=mgr.listVisitations("May", "2012", "In Patient").size()%>,
            <%=mgr.listVisitations("Jun", "2012", "In Patient").size()%>, 
            <%=mgr.listVisitations("Jul", "2012", "In Patient").size()%>,
            <%=mgr.listVisitations("Aug", "2012", "In Patient").size()%>, 
            <%=mgr.listVisitations("Sep", "2012", "In Patient").size()%>, 
            <%=mgr.listVisitations("Oct", "2012", "In Patient").size()%>,
            <%=mgr.listVisitations("Nov", "2012", "In Patient").size()%>, 
            <%=mgr.listVisitations("Dec", "2012", "In Patient").size()%>]
                                        },
                                        {
                                            name : 'Outpatients',
                                            data : [<%=mgr.listVisitations("Jan", "2012", "Out Patient").size()%>, 
            <%=mgr.listVisitations("Feb", "2012", "Out Patient").size()%>, 
            <%=mgr.listVisitations("Mar", "2012", "Out Patient").size()%>, 
            <%=mgr.listVisitations("Apr", "2012", "Out Patient").size()%>, 
            <%=mgr.listVisitations("May", "2012", "Out Patient").size()%>,
            <%=mgr.listVisitations("Jun", "2012", "Out Patient").size()%>, 
            <%=mgr.listVisitations("Jul", "2012", "Out Patient").size()%>,
            <%=mgr.listVisitations("Aug", "2012", "Out Patient").size()%>, 
            <%=mgr.listVisitations("Sep", "2012", "Out Patient").size()%>, 
            <%=mgr.listVisitations("Oct", "2012", "Out Patient").size()%>,
            <%=mgr.listVisitations("Nov", "2012", "Out Patient").size()%>, 
            <%=mgr.listVisitations("Dec", "2012", "Out Patient").size()%>]
                                            }]
                                    });
           	
                                    chart1 = new Highcharts.Chart({
                                        chart : {
                                            renderTo : 'chart_div1',
                                            type : 'line',
                                            marginRight : 5,
                                            height: 210
                                        },
                                        title : {
                                            text : 'Total CASH/ NHIS/ Private Patients Attendance',

                                        },

                                        xAxis : {
							
                                            categories : ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],

                                            labels : {
                                                formatter : function() {
                                                    return this.value;
                                                    // clean, unformatted number for year
                                                },
                                                startOnTick : true

                                            }
                                        },
                                        yAxis : {
                                            min: 0,
                                            title : {
                                                text : 'Number of Patients'
                                            }
                                        },
                                        tooltip : {
                                            formatter : function() {
                                                return Highcharts.numberFormat(this.y, 0) + ' Patients in ' + this.x;
                                            }
                                        },

                                        series : [{
                                                name : 'Private & Corperate',
                                                data : [<%=mgr.getMonthlyValues("Jan", "2012", "Private")%>, 
            <%=mgr.getMonthlyValues("Feb", "2012", "Private")%>,
            <%=mgr.getMonthlyValues("Mar", "2012", "Private")%>,
            <%=mgr.getMonthlyValues("Apr", "2012", "Private")%>,
            <%=mgr.getMonthlyValues("May", "2012", "Private")%>,
            <%=mgr.getMonthlyValues("Jun", "2012", "Private")%>,
            <%=mgr.getMonthlyValues("Jul", "2012", "Private")%>, 
            <%=mgr.getMonthlyValues("Aug", "2012", "Private")%>, 
            <%=mgr.getMonthlyValues("Sep", "2012", "Private")%>,
            <%=mgr.getMonthlyValues("Oct", "2012", "Private")%>,
            <%=mgr.getMonthlyValues("Nov", "2012", "Private")%>, 
            <%=mgr.getMonthlyValues("Dec", "2012", "Private")%>]
                                                }, {
                                                    name : 'NHIS',
                                                    data : [<%=mgr.getMonthlyValues("Jan", "2012", "Private")%>, 
            <%=mgr.getMonthlyValues("Feb", "2012", "NHIS")%>,
            <%=mgr.getMonthlyValues("Mar", "2012", "NHIS")%>,
            <%=mgr.getMonthlyValues("Apr", "2012", "NHIS")%>,
            <%=mgr.getMonthlyValues("May", "2012", "NHIS")%>,
            <%=mgr.getMonthlyValues("Jun", "2012", "NHIS")%>,
            <%=mgr.getMonthlyValues("Jul", "2012", "NHIS")%>, 
            <%=mgr.getMonthlyValues("Aug", "2012", "NHIS")%>, 
            <%=mgr.getMonthlyValues("Sep", "2012", "NHIS")%>,
            <%=mgr.getMonthlyValues("Oct", "2012", "NHIS")%>,
            <%=mgr.getMonthlyValues("Nov", "2012", "NHIS")%>, 
            <%=mgr.getMonthlyValues("Dec", "2012", "NHIS")%>]
                                                    },
                                                    {
                                                        name : 'CASH',
                                                        data : [<%=mgr.getMonthlyValues("Jan", "2012", "Private")%>, 
            <%=mgr.getMonthlyValues("Feb", "2012", "CASH")%>,
            <%=mgr.getMonthlyValues("Mar", "2012", "CASH")%>,
            <%=mgr.getMonthlyValues("Apr", "2012", "CASH")%>,
            <%=mgr.getMonthlyValues("May", "2012", "CASH")%>,
            <%=mgr.getMonthlyValues("Jun", "2012", "CASH")%>,
            <%=mgr.getMonthlyValues("Jul", "2012", "CASH")%>, 
            <%=mgr.getMonthlyValues("Aug", "2012", "CASH")%>, 
            <%=mgr.getMonthlyValues("Sep", "2012", "CASH")%>,
            <%=mgr.getMonthlyValues("Oct", "2012", "CASH")%>,
            <%=mgr.getMonthlyValues("Nov", "2012", "CASH")%>, 
            <%=mgr.getMonthlyValues("Dec", "2012", "CASH")%>]
                                                        }]
                                                });
					
					
					
                                                chart2 = new Highcharts.Chart({
                                                    chart : {
                                                        renderTo : 'chart_div2',
                                                        type : 'line',
                                                        marginRight : 5,
                                                        height: 210
                                                    },
                                                    title : {
                                                        text : 'Total Outpatient Vitals',

                                                    },

                                                    xAxis : {
							
                                                        categories : ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],

                                                        labels : {
                                                            formatter : function() {
                                                                return this.value;
                                                                // clean, unformatted number for year
                                                            },
                                                            startOnTick : true

                                                        }
                                                    },
                                                    yAxis : {
                                                        min: 0,
                                                        title : {
                                                            text : 'Number of Patients'
                                                        }
                                                    },
                                                    tooltip : {
                                                        formatter : function() {
                                                            return Highcharts.numberFormat(this.y, 0) + ' Patients in ' + this.x;
                                                        }
                                                    },

                                                    series : [{
                                                            name : 'Private & Corperate',
                                                            data : [<%=mgr.getMonthlyValues("Jan", "2012", "Out Patient", "Private")%>, 
            <%=mgr.getMonthlyValues("Feb", "2012", "Out Patient", "Private")%>,
            <%=mgr.getMonthlyValues("Mar", "2012", "Out Patient", "Private")%>,
            <%=mgr.getMonthlyValues("Apr", "2012", "Out Patient", "Private")%>,
            <%=mgr.getMonthlyValues("May", "2012", "Out Patient", "Private")%>,
            <%=mgr.getMonthlyValues("Jun", "2012", "Out Patient", "Private")%>,
            <%=mgr.getMonthlyValues("Jul", "2012", "Out Patient", "Private")%>,
            <%=mgr.getMonthlyValues("Aug", "2012", "Out Patient", "Private")%>,
            <%=mgr.getMonthlyValues("Sep", "2012", "Out Patient", "Private")%>,
            <%=mgr.getMonthlyValues("Oct", "2012", "Out Patient", "Private")%>,
            <%=mgr.getMonthlyValues("Nov", "2012", "Out Patient", "Private")%>,
            <%=mgr.getMonthlyValues("Dec", "2012", "Out Patient", "Private")%>]
                                                            }, {
                                                                name : 'NHIS',
                                                                data : [<%=mgr.getMonthlyValues("Jan", "2012", "Out Patient", "NHIS")%>, 
            <%=mgr.getMonthlyValues("Feb", "2012", "Out Patient", "NHIS")%>,
            <%=mgr.getMonthlyValues("Mar", "2012", "Out Patient", "NHIS")%>,
            <%=mgr.getMonthlyValues("Apr", "2012", "Out Patient", "NHIS")%>,
            <%=mgr.getMonthlyValues("May", "2012", "Out Patient", "NHIS")%>,
            <%=mgr.getMonthlyValues("Jun", "2012", "Out Patient", "NHIS")%>,
            <%=mgr.getMonthlyValues("Jul", "2012", "Out Patient", "NHIS")%>,
            <%=mgr.getMonthlyValues("Aug", "2012", "Out Patient", "NHIS")%>,
            <%=mgr.getMonthlyValues("Sep", "2012", "Out Patient", "NHIS")%>,
            <%=mgr.getMonthlyValues("Oct", "2012", "Out Patient", "NHIS")%>,
            <%=mgr.getMonthlyValues("Nov", "2012", "Out Patient", "NHIS")%>,
            <%=mgr.getMonthlyValues("Dec", "2012", "Out Patient", "NHIS")%>]
                                                                },
                                                                {
                                                                    name : 'Out of Pocket',
                                                                    data : [<%=mgr.getMonthlyValues("Jan", "2012", "Out Patient", "CASH")%>, 
            <%=mgr.getMonthlyValues("Feb", "2012", "Out Patient", "CASH")%>,
            <%=mgr.getMonthlyValues("Mar", "2012", "Out Patient", "CASH")%>,
            <%=mgr.getMonthlyValues("Apr", "2012", "Out Patient", "CASH")%>,
            <%=mgr.getMonthlyValues("May", "2012", "Out Patient", "CASH")%>,
            <%=mgr.getMonthlyValues("Jun", "2012", "Out Patient", "CASH")%>,
            <%=mgr.getMonthlyValues("Jul", "2012", "Out Patient", "CASH")%>,
            <%=mgr.getMonthlyValues("Aug", "2012", "Out Patient", "CASH")%>,
            <%=mgr.getMonthlyValues("Sep", "2012", "Out Patient", "CASH")%>,
            <%=mgr.getMonthlyValues("Oct", "2012", "Out Patient", "CASH")%>,
            <%=mgr.getMonthlyValues("Nov", "2012", "Out Patient", "CASH")%>,
            <%=mgr.getMonthlyValues("Dec", "2012", "Out Patient", "CASH")%>]
                                                                }]
                                                        });
					
					
					
                                                        chart3 = new Highcharts.Chart({
                                                            chart : {
                                                                renderTo : 'chart_div3',
                                                                type : 'line',
                                                                marginRight : 5,
                                                                height: 210
                                                            },
                                                            title : {
                                                                text : 'Total Inpatient Admissions',

                                                            },

                                                            xAxis : {
							
                                                                categories : ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],

                                                                labels : {
                                                                    formatter : function() {
                                                                        return this.value;
                                                                        // clean, unformatted number for year
                                                                    },
                                                                    startOnTick : true

                                                                }
                                                            },
                                                            yAxis : {
                                                                min: 0,
                                                                title : {
                                                                    text : 'Number of Patients'
                                                                }
                                                            },
                                                            tooltip : {
                                                                formatter : function() {
                                                                    return Highcharts.numberFormat(this.y, 0) + ' Patients in ' + this.x;
                                                                }
                                                            },

                                                            series : [{
                                                                    name : 'Private & Corperate',
                                                                    data : [<%=mgr.getMonthlyValues("Jan", "2012", "In Patient", "Private")%>, 
            <%=mgr.getMonthlyValues("Feb", "2012", "In Patient", "Private")%>,
            <%=mgr.getMonthlyValues("Mar", "2012", "In Patient", "Private")%>,
            <%=mgr.getMonthlyValues("Apr", "2012", "In Patient", "Private")%>,
            <%=mgr.getMonthlyValues("May", "2012", "In Patient", "Private")%>,
            <%=mgr.getMonthlyValues("Jun", "2012", "In Patient", "Private")%>,
            <%=mgr.getMonthlyValues("Jul", "2012", "In Patient", "Private")%>,
            <%=mgr.getMonthlyValues("Aug", "2012", "In Patient", "Private")%>,
            <%=mgr.getMonthlyValues("Sep", "2012", "In Patient", "Private")%>,
            <%=mgr.getMonthlyValues("Oct", "2012", "In Patient", "Private")%>,
            <%=mgr.getMonthlyValues("Nov", "2012", "In Patient", "Private")%>,
            <%=mgr.getMonthlyValues("Dec", "2012", "In Patient", "Private")%>]
                                                                }, {
                                                                    name : 'NHIS',
                                                                    data : [<%=mgr.getMonthlyValues("Jan", "2012", "In Patient", "NHIS")%>, 
            <%=mgr.getMonthlyValues("Feb", "2012", "In Patient", "NHIS")%>,
            <%=mgr.getMonthlyValues("Mar", "2012", "In Patient", "NHIS")%>,
            <%=mgr.getMonthlyValues("Apr", "2012", "In Patient", "NHIS")%>,
            <%=mgr.getMonthlyValues("May", "2012", "In Patient", "NHIS")%>,
            <%=mgr.getMonthlyValues("Jun", "2012", "In Patient", "NHIS")%>,
            <%=mgr.getMonthlyValues("Jul", "2012", "In Patient", "NHIS")%>,
            <%=mgr.getMonthlyValues("Aug", "2012", "In Patient", "NHIS")%>,
            <%=mgr.getMonthlyValues("Sep", "2012", "In Patient", "NHIS")%>,
            <%=mgr.getMonthlyValues("Oct", "2012", "In Patient", "NHIS")%>,
            <%=mgr.getMonthlyValues("Nov", "2012", "In Patient", "NHIS")%>,
            <%=mgr.getMonthlyValues("Dec", "2012", "In Patient", "NHIS")%>]
                                                                },
                                                                {
                                                                    name : 'Out of Pocket',
                                                                    data : [<%=mgr.getMonthlyValues("Jan", "2012", "In Patient", "CASH")%>, 
            <%=mgr.getMonthlyValues("Feb", "2012", "In Patient", "CASH")%>,
            <%=mgr.getMonthlyValues("Mar", "2012", "In Patient", "CASH")%>,
            <%=mgr.getMonthlyValues("Apr", "2012", "In Patient", "CASH")%>,
            <%=mgr.getMonthlyValues("May", "2012", "In Patient", "CASH")%>,
            <%=mgr.getMonthlyValues("Jun", "2012", "In Patient", "CASH")%>,
            <%=mgr.getMonthlyValues("Jul", "2012", "In Patient", "CASH")%>,
            <%=mgr.getMonthlyValues("Aug", "2012", "In Patient", "CASH")%>,
            <%=mgr.getMonthlyValues("Sep", "2012", "In Patient", "CASH")%>,
            <%=mgr.getMonthlyValues("Oct", "2012", "In Patient", "CASH")%>,
            <%=mgr.getMonthlyValues("Nov", "2012", "In Patient", "CASH")%>,
            <%=mgr.getMonthlyValues("Dec", "2012", "In Patient", "CASH")%>]
                                                                }]
                                                        });
					
					
                                                    });

                                                });
        </script>

        <script src="js/highcharts.js"></script>

        <style type="text/css" >
            body {
                overflow: hidden;
            }

            #chart_div {
                z-index: 100
            }
        </style>

    </head>

    <body data-spy="scroll" data-target=".subnav" data-offset="50">

        <!-- Navbar
        ================================================== -->
        <div style="display: none;" class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </a>
                    <a class="brand" href="../"><img src="images/logo.png" width="200px;" /></a>

                    <div style="margin-top: 10px;" class="nav-collapse">
                        <ul class="nav pull-right">

                             <li class="dropdown">
                                <a class="active" > Logged in as:  <%=mgr.getStafftableByid(user.getStaffid()).getLastname() %> <%=mgr.getStafftableByid(user.getStaffid()).getOthername() %></a>

                            </li>
                            <li class="divider-vertical"></li>

                            <li class="dropdown">
                                <a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="icon-user"></i> Account <b class="caret"></b></a>
                                <ul class="dropdown-menu">

                                    <li>
                                        <a target="_blank" href="bootstrap.min.css"><i class="icon-wrench"></i> Settings </a>
                                    </li>

                                    <li>
                                        <a target="_blank" href="bootstrap.css"><i class="icon-question-sign"></i> Help </a>
                                    </li>
                                    <li>
                                        <a target="_blank" href="bootstrap.css"><i class="icon-share"></i> Feedback </a>
                                    </li>
                                    <li class="divider"></li>

                                   <li>
                                        <a target="_blank" href="logout.jsp"><i class="icon-off"></i> Log Out</a>
                                    </li>

                                </ul>

                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="container-fluid">

            <!-- Masthead
            ================================================== -->
            <header  class="jumbotron subhead" id="overview">

                <div style="margin-top: 20px; margin-bottom: -50px;" class="subnav navbar-fixed-top hide">
                    <ul class="nav nav-pills">

                        <li>
                            <a href="#">Home <i class="icon-chevron-right"></i></a>
                        </li>
                        <li>
                            <a href="#">Statistics & Reports <i class="icon-chevron-right"></i></a>
                        </li>
                        <li>
                            <a href="#">Client Utilization </a>
                        </li>

                    </ul>
                </div>

            </header>

            <div style="position: absolute; left: 30%; top: 200px; text-align: center;" class="progress1">
                <img src="images/logoonly.png" width="136px;" style="margin-bottom: 20px;" />
                <a href="#"> <h3 class="segoe" style="text-align: center; font-weight: lighter;"> Your page is taken longer than expected to load.....
                        <br />
                        Please be patient!</h3>
                    <br />
                </a>
                <div  class="progress progress-striped active span5">

                    <div class="bar"
                         style="width: 100%;"></div>
                </div>
            </div>

            <section style="margin-top: -30px;" id="dashboard">

                <!-- Headings & Paragraph Copy -->
                <div class="row">

                    <%@include file="widgets/leftsidebar.jsp" %>

                    <div style="margin-top: 0px; "class="span12 offset3 content1 hide">
                        <ul class="breadcrumb span9 pull-right" style="padding-bottom: 0px; line-height: 27px;">
                            <li>
                                <h4><a href="#"> Patient Utilization</a></h4>
                            </li>
                            <li style="padding-left: 10px;" class="pull-right">
                                <input type="text" class="input-large" placeholder="Select Date Range" value="4/23/99" id="rangeA" />

                            </li>
                            <li style="padding-top: 5px;" class="active pull-right">
                                Select Date Range
                            </li>
                            <!--	<li  class="active pull-right">
                                            <select class="input-xlarge" id="selectError">
                                                    <option>Emmanuel Addo-Yirenkyi & Dependants</option>
                                                    <option>Emmanuel Addo-Yirenkyi Only </option>
                                                    <option>All Dependants Only </option>

                                                    <option>Adwoa Mansah (Dependant 1)</option>
                                                    <option>Kofi Manu (Dependant 2)</option>
                                                    <option>Ama Brako (Dependant 3)</option>
                                            </select>
                            </li>  -->

                        </ul>

                        <div style="height: 200px; overflow: hidden; margin-bottom: 20px; padding: 0px; width: 420px;" class="box span4 pull-left" id="myModal">

                            <div id="chart_div" style="height: 240px; margin-top: -5px; padding: 0px; z-index: 1000; overflow: hidden;" class="box-body">

                            </div>

                        </div>

                        <div style="height: 200px; overflow: hidden; margin-bottom: 20px; width: 420px;" class="box span4  pull-left" id="myModal">

                            <div id="chart_div1" style="height: 240px; margin-top: -5px; padding: 0px; z-index: 1000; overflow: hidden;" class="box-body">

                            </div>

                        </div>

                        <div style="height: 200px; overflow: hidden; width: 420px;" class="box span4 pull-left" id="myModal">

                            <div id="chart_div2" style="height: 240px; margin-top: -5px; padding: 0px; z-index: 1000; overflow: hidden;" class="box-body">

                            </div>

                        </div>

                        <div style="height: 200px; overflow: hidden; width: 420px;" class="box span4 pull-left" id="myModal">

                            <div id="chart_div3" style="height: 240px; margin-top: -5px; padding: 0px; z-index: 1000; overflow: hidden;" class="box-body">

                            </div>

                        </div>

                    </div>
                    <div class="clearfix"></div>

                </div>

            </section>

            <footer style="display: none;" class="footer">
                <p style="text-align: center" class="pull-right">
                    <img src="images/logo.png" width="100px;" />
                </p>
            </footer>

        </div><!-- /container -->

        <!--end static dialog-->

        <!-- Le javascript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap-dropdown.js"></script>
        <script src="js/bootstrap-scrollspy.js"></script>
        <script src="js/bootstrap-collapse.js"></script>
        <script src="js/bootstrap-tooltip.js"></script>
        <script src="js/bootstrap-popover.js"></script>
        <script src="js/application.js"></script>

        <script type="text/javascript" src="js/jquery-ui-1.8.16.custom.min.js"></script>

        <script type="text/javascript" src="third-party/jQuery-UI-Date-Range-Picker/js/date.js"></script>
        <script type="text/javascript" src="third-party/jQuery-UI-Date-Range-Picker/js/daterangepicker.jQuery.js"></script>

        <!--	<script src="third-party/wijmo/jquery.mousewheel.min.js" type="text/javascript"></script>
        <script src="third-party/wijmo/jquery.bgiframe-2.1.3-pre.js" type="text/javascript"></script>
        <script src="third-party/wijmo/jquery.wijmo-open.1.5.0.min.js" type="text/javascript"></script>

        <script src="third-party/jQuery-UI-FileInput/js/enhance.min.js" type="text/javascript"></script>
        <script src="third-party/jQuery-UI-FileInput/js/fileinput.jquery.js" type="text/javascript"></script>

        <script type="text/javascript" src="js/tablecloth.js"></script>  -->
        <script type="text/javascript" src="js/demo.js"></script>
        <!--initiate accordion-->
        <script type="text/javascript">
                                            $(function() {

                                                var menu_ul = $('.menu > li > ul'), menu_a = $('.menu > li > a');

                                                menu_ul.hide();

                                                $(".menu").fadeIn();
                                                $(".content1").fadeIn();
                                                $(".navbar").fadeIn();
                                                $(".footer").fadeIn();
                                                $(".subnav").fadeIn();
                                                $(".progress1").hide();

                                                menu_a.click(function(e) {
                                                    e.preventDefault();
                                                    if (!$(this).hasClass('active')) {
                                                        menu_a.removeClass('active');
                                                        menu_ul.filter(':visible').slideUp('normal');
                                                        $(this).addClass('active').next().stop(true, true).slideDown('normal');
                                                    } else {
                                                        $(this).removeClass('active');
                                                        $(this).next().stop(true, true).slideUp('normal');
                                                    }
                                                });

                                            });

        </script>

    </body>
</html>
