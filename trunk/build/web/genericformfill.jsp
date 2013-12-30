<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>ClaimSync Insurance Portal</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="">
		<meta name="author" content="">

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
		<link href="style.css" rel="stylesheet">

		<!--Load the AJAX API-->

		<style type="text/css" >
			body {

			}

			#chart_div {
				z-index: 100
			}
			.center {
				text-align: center;
			}

			.modal-header {
				background-color: #FBFBFB;
				background-image: -moz-linear-gradient(center top , #FFFFFF, #F5F5F5);
				background-repeat: repeat-x;
				border: 1px solid #DDDDDD;
				border-radius: 3px 3px 3px 3px;
				box-shadow: 0 1px 0 #FFFFFF inset;
			}
			input {
				height: 30px;
				font-size: 20px !important;
				color: #4183C4 !important;
				text-transform: capitalize
			}

			.left {
				text-align: left;
			}

			.right {
				text-align: right;
			}

			select {
				height: 25px;
				font-size: 20px !important;
				color: #4183C4 !important;
			}

			.ui-datepicker-header select {
				font-size: 12px !important;
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
					<a class="brand" href="#"><img src="images/logo.png" width="200px;" /></a>

					<div style="margin-top: 10px;" class="nav-collapse">
						<ul class="nav pull-right">

							<li class="dropdown">
								<a class="active" > Logged in as:  Mr. Amoo </a>

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
									<li class="divider"></li>

									<li>
										<a target="_blank" href="variables.less"><i class="icon-off"></i> Log Out</a>
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
							<a href="#">Generic Claim Form <i class="icon-chevron-right"></i></a>
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

					<div class="bar" style="width: 100%;">

					</div>
				</div>
			</div>

			<section class="hide" style="margin-top: -30px;" id="dashboard">

				<!-- Headings & Paragraph Copy -->
				<div class="container">
					<!--	<form id="contact-form" >  -->
					<fieldset>
						<div class="span" style="width: 97%" >
							<ul class="breadcrumb">
								<li>
									<a href="#">PATIENT </a>
								</li>
								<li class="pull-right">
									<i class="icon icon-chevron-down"> </i>
								</li>
							</ul>

						</div>

						<div class="offset8 span3">
							<input style="height: 40px;" type="text" class="input input-xlarge center date required" placeholder="DATE OF ATTENDANCE" />
							<br />
							<br />
							<div class="center">
								PATIENT FOLDER NUMBER
							</div>
							<input class="center input-xlarge required" type="text" />
						</div>

						<div class="clearfix">

						</div>
						<div class="span2">
							PATIENT NAME
						</div>
						<div class="clearfix">

						</div>

						<div  class="span4">
							<input class="input-xlarge" type="text" />
							<br/>
							SURNAME
						</div>
						<div  class="span4">
							<input  class="input-xlarge" type="text" />
							<br/>
							OTHER NAMES
						</div>
						<div class="span3 ">
							<input class="input-xlarge" type="text" />
							<br/>
							<span style="text-align: left;"> COMPANY OR FIRM </span>
						</div>

						<div class="clearfix">

						</div>
						<hr />

						<div class="clearfix">

						</div>
						<div class="span4">
							<input class="input-xlarge" type="text" />
							<br/>
							MEMBERSHIP NUMBER
						</div>
						<div class="span4">
							<input class="input-xlarge required" type="text" />
							<br/>
							PATIENT'S TELEPHONE NUMBER
						</div>
						<div class="span3 ">

							<select style="height: 40px; padding: 5px;" class="input-mini required">
								<option name="M">M</option>
								<option name="F">F</option>
							</select>
							<input class="dob required" style="margin-left:1px;width: 185px;" type="text" />
							<br/>
							<span style="text-align: left;"> SEX </span><span style="text-align: left; margin-left: 55px;"> DATE OF BIRTH </span>
						</div>

						<div class="clearfix">

						</div>
						<hr />

						<div class="clearfix">

						</div>
						<div class="span4">
							<input class="input-xlarge" type="text" />
							<br/>
							DEPENDANT'S NUMBER
						</div>
						<div class="span4">
							<input class="input-xlarge" type="text" />
							<br/>
							PATIENT'S SURNAME (if Different from member)
						</div>
						<div class="span3 ">
							<input  class="input-	large" type="text"  />

							<br/>
							<span style="text-align: left;"> NHIS NO (CO-CARE) </span>

						</div>

						<div class="divider">

						</div>

						<div class="span" style="width: 97%" >
							<br />
							<br />
							<ul class="breadcrumb">
								<li>
									<a href="#">SERVICE PROVIDER </a>
								</li>
								<li class="pull-right">
									<i class="icon icon-chevron-right"> </i>
								</li>
							</ul>

							<br />
							<br />

						</div>

						<div class="clearfix">

						</div>

						<div class="span3">
							<input class="input-xlarge" type="text" />
							<br/>
							NAME OF FACILITY
						</div>
						<div style="text-align: right;" class="span3">
							<input class="input-large" type="text" />
							<br/>
							<span style="margin-left: -80px;"> CLINCIAN / ATTENDING OFFICER </span>
						</div>
						<div style="border:  1px solid #ccc; padding: 12" class="span">
							<label class="radio inline">
								<input type="radio" name="patientstate" id="inlineCheckbox1" value="option1">
								IN-PATIENT </label>
							<br />
							<label class="radio inline">
								<input type="radio" name="patientstate" id="inlineCheckbox2" value="option2">
								OUT-PATIENT </label>

						</div>
						<div class="span4" style="text-align: right;">

							<span style="text-align: left; padding-right: 20px;"> DETENTION DATE </span>
							<input  class="input date" type="text"  />

							<br/>
							<span style="text-align: left;  padding-right: 20px;"> ADMISSION DATE </span>
							<input  class="input date" type="text"  />

							<br/>
							<span style="text-align: left;  padding-right: 20px;"> DISCHARGE DATE </span>
							<input  class="input date" type="text"  />

							<br/>

						</div>
						<div class="span8" style="margin-left: 30px; margin-top: -55px;">
							<label style="padding: 20px;" class="radio inline">
								<input name="typeofservice" type="radio" id="inlineCheckbox1" value="option1"/>
								MEDICAL </label>
							<label style="padding: 20px;"  class="radio inline">
								<input name="typeofservice" type="radio" id="inlineCheckbox2" value="option2"/>
								OPTHALMOLOGY </label>
							<label style="padding: 20px;" class="radio inline">
								<input name="typeofservice" type="radio" id="inlineCheckbox1" value="option1"/>
								RADIOLOGY </label>
							<label  style="padding: 20px;" class="radio inline">
								<input name="typeofservice" type="radio" id="inlineCheckbox2" value="option2"/>
								PHARMACY </label>
							<label style="padding: 20px;" class="radio inline">
								<input name="typeofservice" type="radio" id="inlineCheckbox1" value="option1"/>
								LABORATORY </label>
							<label style="padding: 20px;" class="radio inline">
								<input name="typeofservice" type="radio" id="inlineCheckbox2" value="option2">
								OTHER </label>

						</div>

						<div class="clearfix">

						</div>
						<div class="span9">
							<input class="span9" type="text" />
							<br/>
							DIAGNOSIS
						</div>

						<div class="span2">
							<button class="btn btn-info btn-large">
								<i class="icon icon-white icon-adjust"> </i> Add
							</button>

						</div>

						<div class="clearfix">

						</div>
						<hr />
						<div class="divider">

						</div>

						<div class="span" style="width: 95%" >
							<br />
							<br />
							<ul class="breadcrumb">
								<li>
									<a href="#">INVESTIGATIONS & TREATMENTS</a>
								</li>
								<li class="pull-right">
									<i class="icon icon-chevron-right"></i>
								</li>

							</ul>

							<br />
							<br />

						</div>
						<div class="clearfix">

						</div>

						<table class="table table-striped table-bordered">
							<thead>
								<tr>
									<th> DATE OF SERVICE </th>
									<th> DESCRIPTION </th>
									<th> MED / DEN / LAB / PHA </th>
									<th> FORM </th>
									<th> QTY </th>
									<th> UNIT COST </th>
									<th> TOTAL COST </th>
								</tr>
							</thead>
							<tbody>

								<tr class="clone_source">
									<td>
									<input id="dateofservice1" name="dateofservice1" class="input-medium date" type="text" />
									</td>
									<td>
									<input id="description1" name="description1" class="input-xlarge" type="text" />
									</td>
									<td>
									<select id="typeofservice1" name="typeofservice1" style="height: 40px; vertical-align: middle;" class="input-medium">
										<option></option>
										<option> MED </option>
										<option> DEN </option>
										<option> LAB </option>
										<option> PHARM </option>
									</select></td>
									<td>
									<select id="form1" name="form1" style="height: 40px; vertical-align: middle;" class="input-small">
										<option></option>
										<option> TABS </option>
										<option> CAPS </option>
										<option> SYR </option>
										<option> INJ </option>
										<option> IV </option>
									</select></td>
									<td>
									<input style="text-align: right;" id="quantity1" name="quantity1" class="input-small positive-integer" type="text" />
									</td>
									<td>
									<input style="text-align: right;" id="unitcost1" name="unitcost1" class="input-small numeric" type="text" />
									</td>
									<td>
									<input style="text-align: right;" disabled="disabled" id="totalcost1" name="totalcost1" class="input-small totalcost numeric" type="text" />
									</td>
								</tr>
								<tr id="dummyrow">
									<td colspan="4">
									<button id="addrow" class="btn btn-info btn-large">
										<i class="icon icon-white icon-plus-sign"> </i> Add
									</button></td>

									<td style="border: solid 0px black;"> AMOUNT DUE </td>
									<td style="border: solid 1px black; text-align: right;" colspan="2">
									<input id="totalamount" style="font-size: 30px !important; color: #83BB6C !important; height: 40px;" placeholder="0.00" type="text" class="input-medium right numeric"/>
									</td>
								</tr>
							</tbody>

						</table>

						<div class="clearfix">

						</div>

						<hr />

						<div class="span4">
							<input placeholder="REFERRED TO" class="input-xlarge center" type="text" />

						</div>
						<div class="span4">
							<input  placeholder="REMARKS" class="input-xlarge center" type="text" />

						</div>
						<div class="span3 ">
							<input placeholder="DATE"  class="input-large center date" type="text"  />

						</div>
					</fieldset>
					<!--		</form>  -->
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
		<script src="assets/js/jquery.validate.min.js"></script>
		<script type="text/javascript" src="js/jquery.numeric.js"></script>
		<!-- Scripts specific to this page -->
		<script src="script.js"></script>

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
				$("#dashboard").fadeIn();
				$(".menu").fadeIn();
				$(".content1").fadeIn();
				$(".navbar").fadeIn();
				$(".footer").fadeIn();
				$(".subnav").fadeIn();
				$(".progress1").hide();

				$(".numeric").numeric();
				$(".positive-integer").numeric({
					decimal : false,
					negative : false
				}, function() {
					alert("Positive integers only");
					this.value = "";
					this.focus();
				});
				$('#quantity1').live('keyup', function() {
					var sum = 0;
					quantity = $(this).val();
					price = $('#unitcost1').val();
					result = quantity * price;
					$("#totalcost1").val(result);
					$("#totalcost" + click_count).val(result);

					$('.totalcost').each(function() {
						sum += Number($(this).val());

					})
					$('#totalamount').attr('value', sum.toFixed(2));
				});

				$('#unitcost1').live('keyup', function() {
					var sum = 0;
					quantity = $('#quantity1').val();
					price = $(this).val();
					result = quantity * price;
					$("#totalcost1").val(result);
					$("#totalcost" + click_count).val(result);

					$('.totalcost').each(function() {
						sum += Number($(this).val());

					})
					$('#totalamount').attr('value', sum.toFixed(2));
				});

				/*	$(document).mouseover(function(){
				 var sum = 0;
				 $('.totalcost').each(function() {
				 sum += Number($(this).val());

				 });

				 $('#totalamount').attr('value', sum);

				 }) */
				var click_count = 1;

				$("#addrow").click(function() {

					click_count = click_count + 1;

					var clone = $(".clone_source").clone().attr("class", "clone");
					clone.find("#dateofservice1").attr("id", "dateofservice" + click_count).attr("name", "dateofservice" + click_count).attr("value", "").attr("class", "datePick input-medium");
					clone.find("#description1").attr("id", "description" + click_count).attr("name", "description" + click_count).attr("value", "");
					clone.find("#typeofservice1").attr("id", "typeofservice" + click_count).attr("name", "typeofservice" + click_count).attr("value", "");
					clone.find("#form1").attr("id", "form" + click_count).attr("name", "form" + click_count).attr("value", "");
					clone.find("#quantity1").attr("id", "quantity" + click_count).attr("name", "quantity" + click_count).attr("value", "0");
					clone.find("#unitcost1").attr("id", "unitcost" + click_count).attr("name", "unitcost" + click_count).attr("value", "0.00");
					clone.find("#totalcost1").attr("id", "totalcost" + click_count).attr("name", "totalcost" + click_count).attr("value", "0.00");
					clone.insertBefore("#dummyrow")

					$('#quantity' + click_count).live('keyup', function() {
						var sum = 0;
						quantity = $(this).val();
						price = $('#unitcost' + click_count).val();
						result = quantity * price;
						$("#totalcost" + click_count).val(result);

						$('.totalcost').each(function() {
							sum += Number($(this).val());
						})
						$('#totalamount').attr('value', sum.toFixed(2));
					});

					$('#unitcost' + click_count).live('keyup', function() {
						var sum = 0;
						quantity = $('#quantity' + click_count).val();
						price = $(this).val();
						result = quantity * price;

						$("#totalcost" + click_count).val(result);

						$('.totalcost').each(function() {
							sum += Number($(this).val());

						})
						$('#totalamount').attr('value', sum.toFixed(2));
					});

				});

			});

		</script>

	</body>
</html>
