<head>
    <meta charset="utf-8">
    <title>ClaimSync PharmaCare - Delivery Methods</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le styles -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap-responsive.min.css" rel="stylesheet">
    <link type="text/css" href="css/custom-theme/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <link href="css/docs.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" type="text/css" href="css/edit.css">
    <style type="text/css" title="currentStyle">
        @import "css/jquery.dataTables_themeroller.css";
        @import "css/custom-theme/jquery-ui-1.8.16.custom.css";
        body {
            overflow-x: hidden;
        }

        .large_button {
            background-color: #35AFE3;
            background-image: -moz-linear-gradient(center top , #45C7EB, #2698DB);
            box-shadow: 0 1px 0 0 #6AD2EF inset;
            color: #FFFFFF;
            text-decoration: none;
            font-weight: lighter;
            font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
            font-size: 32px;
        }

        .large_button:hover {
            background-color: #FBFBFB;
            background-image: -moz-linear-gradient(center top , #FFFFFF, #F5F5F5);
            background-repeat: repeat-x;
            border: 1px solid #DDDDDD;
            border-radius: 3px 3px 3px 3px;
            box-shadow: 0 1px 0 #FFFFFF inset;
            list-style: none outside none;
            color: #777777;
            /* padding: 7px 14px; */
        }

        .center{
            text-align: center;
        }
    </style>
    <link href="css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="third-party/jQuery-UI-Date-Range-Picker/css/ui.daterangepicker.css" media="screen" rel="Stylesheet" type="text/css" />
    <script type="text/javascript">
        var addcount; 
        function addDiadChecks(id1,id2,id3){
            addcount++;
            var t1 = document.getElementById(id1).value;
            var qty = document.getElementById(id2).value
            //var dsg = document.getElementById(id3).value
            var tr = document.createElement("tr");
            var td1 = document.createElement("td");
            var td4 = document.createElement("td");
            var td5 = document.createElement("td");
            var td6 = document.createElement("td");
            var td7 = document.createElement("td");
            // var text = document.createTextNode(document.getElementById(id1).value);
            var cb = document.createElement( "input" );
            var put = document.createElement( "input" );
            var btn = document.createElement( "button" );
            btn.innerHTML = 'Remove';
            cb.type = "checkbox";
            put.type = "hidden";
            put.name = "qty[]";
            cb.id = "id";
            cb.name = "labtest";
            var ttt = t1;
            var str = t1.split("><");
            var text = document.createTextNode(str[1]);
            var text1 = document.createTextNode(qty);
            // var text2 = document.createTextNode(dsg);
            cb.value = str[0];
            put.value = qty
            cb.checked = true;
            td1.appendChild(text);
            td4.appendChild(text1);
            td4.appendChild(put);
            td6.appendChild(btn);
            // td7.appendChild(text2)
            //alert(ttt)
            td5.appendChild(cb);
            tr.appendChild(td1);
                
            tr.id = "tr1_"+addcount;
            tr.appendChild(td7);
            tr.appendChild(td4);
            
            tr.appendChild(td5);
               
            tr.appendChild(td6);
            document.getElementById(id3).appendChild(tr);
            //var ch = document.getElementById("dosagecode");
               
            btn.onclick = function(){
                var tbl = document.getElementById(id3);
                var rem = confirm("Are you sure you to remove this diagnosis");
                if(rem){
                    tbl.removeChild(document.getElementById(tr.id));
                    alert("Removed Successfully");
                    return false;
                }else{
                    return false;
                }
            };
        }
        function addDosageChecks(id1,id2,id3,id4,id5){
            
            addcount++;
            var t1 = document.getElementById(id1).value;
            var qty = document.getElementById(id2).value
            var dsg = document.getElementById(id4).value
            var batch = document.getElementById(id5).value
            //alert(t1)
            var tr = document.createElement("tr");
            var td1 = document.createElement("td");
            var td4 = document.createElement("td");
            var td5 = document.createElement("td");
            var td6 = document.createElement("td");
            var td7 = document.createElement("td");
            // var text = document.createTextNode(document.getElementById(id1).value);
            var cb = document.createElement( "input" );
            var put = document.createElement( "input" );
            var price = document.createElement( "input" );
            var batchid = document.createElement( "input" );
            var btn = document.createElement( "button" );
            var btn2 = document.createElement( "button" );
            btn.innerHTML = 'Remove';
            btn2.innerHTML = 'Print Cover';
            //btn2.onclick='return false'
            cb.type = "checkbox";
            put.type = "hidden";
            price.type = "hidden";
            batchid.type = "hidden";
            put.name = "qty[]";
            cb.id = "id";
            price.name="price";
            batchid.name="batch_number";
            price.id="price_"+addcount
            price.className="price_value"
            cb.name = "labtest";
            var ttt = t1;
            var str = t1.split("><");
            var dsgs = dsg.split("-");
            var batches = batch.split("_");
            var text = document.createTextNode(str[1]);
            var text1 = document.createTextNode(qty);
            //var text3 = document.createTextNode(batches[1]);
            
            put.value = qty
            batchid.value=batches[0];
            var cost = batches[1];
            
            var total = cost*qty
            price.value=total;
            cb.value = str[0]+","+dsgs[0]+","+batches[0]+","+qty+","+cost+","+total;
            cb.checked = true;
            td1.appendChild(text);
            td4.appendChild(text1);
            td4.appendChild(put);
            td6.appendChild(btn);
            td6.appendChild(btn2)
            td4.appendChild(price);
            td4.appendChild(batchid);
            //var text2 = document.createTextNode(total);
            var text3 = document.createTextNode(total);
            //td7.appendChild(text2)
            td7.appendChild(text3);
            //alert(ttt)
            td5.appendChild(cb);
            tr.appendChild(td1);
                
            tr.id = "tr1_"+addcount;
            
            tr.appendChild(td4);
            tr.appendChild(td7); 
            tr.appendChild(td5);
              
            tr.appendChild(td6);
            document.getElementById(id3).appendChild(tr);
            //var ch = document.getElementById("dosagecode");
            var prices = document.getElementsByName("price"); 
            //parseInt(string, radix)
            var totalPrice = 0;
            for(var i=0;i<prices.length;i++){
                totalPrice = totalPrice+ parseInt(prices[i].value,10); 
            }
            // alert(prices.length);
            document.getElementById("totalPrice").innerHTML =totalPrice;
            btn.onclick = function(){
                var tbl = document.getElementById(id3);
                
                var rem = confirm("Are you sure you want to remove this Treatement");
                if(rem){
                    tbl.removeChild(document.getElementById(tr.id));
                    //alert(tr.id)
                    var totalPrice = 0;
                    for(var i=0;i<prices.length;i++){
                        totalPrice = totalPrice+ parseInt(prices[i].value,10); 
                    }
                    document.getElementById("totalPrice").innerHTML =totalPrice;
                    alert("Removed Successfully");
                    return false;
                }else{
                    return false;
                }
            };
            btn2.onclick = function(){
                var tbl = document.getElementById(id3);
                return false;
            };
        }
        function updateUnit(id,qty){
            var id = document.getElementById(id).value;
            // var code = document.getElementById(code).value;
            //alert("hhhh")
            var qty = document.getElementById(qty).value;
            $.post('actions/requisitionaction.jsp', { action : "edititemstock", id : id, qty : qty}, function(data) {
                //alert(data);
                //location.reload();
                alert("Request Edited Successfully");
                //$('#results').html(data).hide().slideDown('slow');
            } );
        }
            
        function acceptUnit(id,id2){
            var id = document.getElementById(id).value;
            var code = document.getElementById(id2).value;
            $.post('actions/requisitionaction.jsp', { action : "acceptpost", id : id, code:code}, function(data) {
                alert(data);
                $('#results').html(data).hide().slideDown('slow');
            } );
        }
        function cancelUnit(id){
            var id = document.getElementById(id).value;
            var con = confirm("Are You Sure You Want Cancel This Delivery");
            if (con ==true)
            {
                $.post('actions/requisitionaction.jsp', { action : "canceldelivery", id : id}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            else 
            {
                alert("Delete Was Cancled!");
                //return;
            }
        }
        function removeRequest(id){
            //var id = document.getElementById(id).value;
            var con = confirm("Are You Sure You Want Remove This Request");
            if (con ==true)
            {
                $.post('actions/requisitionaction.jsp', { action : "removerequest", id : id}, function(data) {
                    alert(data);
                    $('#results').html(data).hide().slideDown('slow');
                } );
            }
            else 
            {
                alert("Remove Was Cancled!");
                //return;
            }
        }
            
        function getDosages(id){
            //var id = document.getElementById(id).value;
            $.ajax({
                url:"ajaxcalls/listdosage.jsp?action=getdosage&itemcode="+id,
                dataType:'json',
                success:function(resp){
                    $("#code").empty();
                    $("#code").html("");
                    if(resp && resp.success=="1"){
                        var dosages=resp.data;
                        //alert(dosages)
                        for(var i=0;i<dosages.length;i++){
                            var id=dosages[i].id;
                            var name=dosages[i].name;
                            $("#code").append($("<option></option><option value="+id+" onclick=getQty("+id+")>"+name+"</option>"));
                           
                        }
                    }
                }
                
            });
        }
        function getBatches(id){
            //var id = document.getElementById(id).value;
            $.ajax({
                url:"ajaxcalls/listdosage.jsp?action=getbatch&itemcode="+id,
                dataType:'json',
                success:function(resp){
                    $("#batch").empty();
                    $("#batch").html("");
                    if(resp && resp.success=="1"){
                        var dosages=resp.data;
                        //alert(dosages)
                        for(var i=0;i<dosages.length;i++){
                            var id=dosages[i].id;
                            var name=dosages[i].name;
                            $("#batch").append($("<option></option><option value="+id+" onclick=getQty("+id+")>"+name+"</option>"));
                           
                        }
                    }
                }
                
            });
        }
        function getQty(id){
            $.post('ajaxcalls/listdosage.jsp', { action : "getqty", qtycode : id}, function(data) {
                // alert(data);
                //var content=array();
                // content = split(data, ">");
                document.getElementById("quantity").value=data;
            } );
        }
    </script>
</head>