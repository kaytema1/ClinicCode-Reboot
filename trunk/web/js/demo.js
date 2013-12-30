$(function() {
    $( ".sortable" ).sortable({
        
        placeholder: "ui-state-highlight",
        update: function(event, ui) {
            var newOrder = $(this).sortable('toArray').toString();
            $(".newOrder").attr("value",newOrder);
        }
        
    });
    $( ".sortable" ).disableSelection();
    $('#tabs2, #tabs').tabs();
    
    $('.tabs').tabs();
    
    
   
    $( "#verticaltabs" ).tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
    $( "#verticaltabs li" ).removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );
         
    
    
    $( "#vertical_tabs" ).tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
    $( "#vertical_tabs li" ).removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );
    
    
    
        $( ".vertical_tabs" ).tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
        $( ".vertical_tabs li" ).removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );
   
    
    $('.radioset').buttonset();
    
   
    
    $(".date").datepicker({
        changeMonth: true,
        changeYear: true
    });
    $('#dialog').dialog({
        autoOpen : false,
        width : 600,
        
        modal : true
       

    });
    
    

    $('.dialog_link').click(function() {
        $('#dialog').dialog('open');
        return false;
    });
    
    
    $('#emergency_dialog').dialog({
        autoOpen : false,
        width : "70%",
        modal : true,
        position : "top"
       

    });
    
    

    $('.emergency_dialog_link').click(function() {
        $('#emergency_dialog').dialog('open');
        return false;
    });
    
    $('#registration_dialog').dialog({
        autoOpen : false,
        width : "100%",
        modal : true,
        position : "top"
        
       

    });
    
    

    $('.registration_dialog_link').click(function() {
        $('#registration_dialog').dialog('open');
        return false;
    });
    
    
    $('#reregistration_dialog').dialog({
        autoOpen : false,
        width : "100%",
        modal : true
       

    });
    
    

    $('.reregistration_dialog_link').click(function() {
        $('#reregistration_dialog').dialog('open');
        return false;
    });

    $('.user_summary').dialog({
        autoOpen : false,
        width : 1000,
        modal : true
        

    });

    $('.user_summary_link').click(function() {
        $('.user_summary').dialog('open');
        return false;
    });

	

    $('#dialog2').dialog({
        autoOpen : false,
        width : "60%",
        modal : true,
        position :"top"

    });

    $('.dialog_link2').click(function() {
        
        $('#dialog2').dialog('open');
        return false;
    });
    
    $(".continue").click(function() {

        $(".first_half").slideUp();

        $(".second_half").slideDown();

        $(".pre_first_half").find("div").addClass("success");

    });

    $(".proceed").click(function() {

        $(".second_half").slideUp();

        $(".third_half").slideDown();

    });

    $(".back").click(function() {

        $(".first_half").slideDown();

        $(".second_half").slideUp();

        $(".third_half").slideUp();

        $(".pre_first_half").find("div").removeClass("success");

    });

    $(".previous").click(function() {

        $(".second_half").slideDown();

        $(".third_half").slideUp();

        $(".first_half").slideUp();
    });

    $('.close_dialog').click(function() {

        $('#dialog').dialog('close');

    });

    $('.usersummary').dialog({
        autoOpen : false,
        width : 600,
        modal : true,
        position : "top"

    });

    $('#patientidlink').click(function() {

        $('.usersummary').dialog('open');
        return false;
    });

    $(".update_sponsor").click(function() {
        $(".sponsor_panel").slideToggle();
        $(".vitals_panel").slideUp();
        $(".history_panel").slideUp();
    });

    $(".update_vitals").click(function() {
        $(".sponsor_panel").slideUp();
        $(".vitals_panel").slideToggle();
        $(".history_panel").slideUp();
    });

    $(".update_history").click(function() {
        $(".sponsor_panel").slideUp();
        $(".vitals_panel").slideUp();
        $(".history_panel").slideToggle();
    });

    $(".slideup").click(function() {
        $(".sponsor_panel").slideUp();
        $(".vitals_panel").slideUp();
        $(".history_panel").slideUp();

    })      
    /*   
    $(".vital_link").click(function(){
        $(".bar").addClass("btn-info")
        $(".bar").removeClass("btn-inverse")
       
        $(".vital").slideDown("slow");
        $(".diagnosis").slideUp("slow");
        $(".history").slideUp("slow");
        $(".prescription").slideUp("slow");
        $(".laboratory").slideUp("slow");
        $(".results").slideUp("slow");
        $(".complaints").slideUp("slow"); 
        $(".clerk").slideUp("slow");
        $(".symptoms").slideUp("slow");
        $(".allergies").slideUp("slow");
         $(".visit_summary").slideUp("slow"); 
         $(".procedure").slideUp("slow");
            
    });
    $(".diagnosis_link").click(function(){
        $(".bar").addClass("btn-info")
        $(".bar").removeClass("btn-inverse")
        
        $(".vital").slideUp("slow");
        $(".diagnosis").slideDown("slow");
        $(".history").slideUp("slow");
        $(".prescription").slideUp("slow");
        $(".laboratory").slideUp("slow");
        $(".results").slideUp("slow");
        $(".complaints").slideUp("slow"); 
        $(".clerk").slideUp("slow");
        $(".symptoms").slideUp("slow");
        $(".allergies").slideUp("slow");
         $(".visit_summary").slideUp("slow"); 
         $(".procedure").slideUp("slow");
    });
    $(".history_link").click(function(){
        $(".bar").addClass("btn-info")
        $(".bar").removeClass("btn-inverse")
       
        $(".vital").slideUp("slow");
        $(".diagnosis").slideUp("slow");
        $(".history").slideDown("slow");
        $(".prescription").slideUp("slow");
        $(".laboratory").slideUp("slow");
        $(".results").slideUp("slow");
        $(".complaints").slideUp("slow"); 
        $(".clerk").slideUp("slow");
        $(".symptoms").slideUp("slow");
        $(".allergies").slideUp("slow");
         $(".visit_summary").slideUp("slow"); 
         $(".procedure").slideUp("slow");
    });
    $(".prescription_link").click(function(){
        $(".bar").addClass("btn-info")
        $(".bar").removeClass("btn-inverse")
        
        $(".vital").slideUp("slow");
        $(".diagnosis").slideUp("slow");
        $(".history").slideUp("slow");
        $(".prescription").slideDown("slow");
        $(".laboratory").slideUp("slow");
        $(".results").slideUp("slow");
        $(".complaints").slideUp("slow"); 
        $(".clerk").slideUp("slow"); 
        $(".symptoms").slideUp("slow");
        $(".allergies").slideUp("slow");
         $(".visit_summary").slideUp("slow"); 
         $(".procedure").slideUp("slow");
    });
    $(".laboratory_link").click(function(){
        $(".bar").addClass("btn-info")
        $(".bar").removeClass("btn-inverse")
        
        $(".vital").slideUp("slow");
        $(".diagnosis").slideUp("slow");
        $(".history").slideUp("slow");
        $(".prescription").slideUp("slow");
        $(".laboratory").slideDown("slow");
        $(".results").slideUp("slow");
        $(".complaints").slideUp("slow"); 
        $(".clerk").slideUp("slow"); 
        $(".symptoms").slideUp("slow");
        $(".allergies").slideUp("slow");
          $(".visit_summary").slideUp("slow"); 
          $(".procedure").slideUp("slow");
    });
        
    $(".results_link").click(function(){
        $(".bar").addClass("btn-info")
        $(".bar").removeClass("btn-inverse")
       
        $(".vital").slideUp("slow");
        $(".diagnosis").slideUp("slow");
        $(".history").slideUp("slow");
        $(".prescription").slideUp("slow");
        $(".laboratory").slideUp("slow");
        $(".results").slideDown("slow");
        $(".complaints").slideUp("slow"); 
        $(".clerk").slideUp("slow");
        $(".symptoms").slideUp("slow");
        $(".allergies").slideUp("slow");
        $(".visit_summary").slideUp("slow"); 
        $(".procedure").slideUp("slow");
    });
    $(".clerking_link").click(function(){
        $(".bar").addClass("btn-info")
        $(".bar").removeClass("btn-inverse")
        
        $(".vital").slideUp("slow");
        $(".diagnosis").slideUp("slow");
        $(".history").slideUp("slow");
        $(".prescription").slideUp("slow");
        $(".laboratory").slideUp("slow");
        $(".results").slideUp("slow");
        $(".complaints").slideUp("slow"); 
        $(".clerk").slideDown("slow");
        $(".symptoms").slideUp("slow");
        $(".allergies").slideUp("slow");
          $(".visit_summary").slideUp("slow");
          $(".procedure").slideUp("slow");
    });
    $(".complaints_link").click(function(){
        $(".bar").addClass("btn-info")
        $(".bar").removeClass("btn-inverse")
       
        $(".vital").slideUp("slow");
        $(".diagnosis").slideUp("slow");
        $(".history").slideUp("slow");
        $(".prescription").slideUp("slow");
        $(".laboratory").slideUp("slow");
        $(".results").slideUp("slow");
        $(".clerk").slideUp("slow"); 
        $(".complaints").slideDown("slow"); 
        $(".symptoms").slideUp("slow");
        $(".allergies").slideUp("slow");
          $(".visit_summary").slideUp("slow");
          $(".procedure").slideUp("slow");
    });
    $(".symptoms_link").click(function(){
        $(".bar").addClass("btn-info")
        $(".bar").removeClass("btn-inverse")
        
        $(".vital").slideUp("slow");
        $(".diagnosis").slideUp("slow");
        $(".history").slideUp("slow");
        $(".prescription").slideUp("slow");
        $(".laboratory").slideUp("slow");
        $(".results").slideUp("slow");
        $(".clerk").slideUp("slow"); 
        $(".complaints").slideUp("slow"); 
        $(".symptoms").slideUp("slow");
        $(".allergies").slideDown("slow");
          $(".visit_summary").slideUp("slow");
          $(".procedure").slideUp("slow");
    });
    $(".allergies_link").click(function(){
        $(".bar").addClass("btn-info")
        $(".bar").removeClass("btn-inverse")
       
        $(".vital").slideUp("slow");
        $(".diagnosis").slideUp("slow");
        $(".history").slideUp("slow");
        $(".prescription").slideUp("slow");
        $(".laboratory").slideUp("slow");
        $(".results").slideUp("slow");
        $(".clerk").slideUp("slow"); 
        $(".complaints").slideUp("slow"); 
        $(".symptoms").slideDown("slow");
        $(".allergies").slideUp("slow");
         $(".visit_summary").slideUp("slow");
         $(".procedure").slideUp("slow");
    });
    
    $(".visit_summary_link").click(function(){
        $(".bar").addClass("btn-info")
        $(".bar").removeClass("btn-inverse")
        
        $(".vital").slideUp("slow");
        $(".diagnosis").slideUp("slow");
        $(".history").slideUp("slow");
        $(".prescription").slideUp("slow");
        $(".laboratory").slideUp("slow");
        $(".results").slideUp("slow");
        $(".clerk").slideUp("slow"); 
        $(".complaints").slideUp("slow"); 
        $(".symptoms").slideUp("slow");
        $(".allergies").slideUp("slow");
         $(".visit_summary").slideDown("slow");
         $(".procedure").slideUp("slow");
    });
    
    $(".procedure_link").click(function(){
        $(".bar").addClass("btn-info")
        $(".bar").removeClass("btn-inverse")
       
    $(".vital").slideUp("slow");
    $(".diagnosis").slideUp("slow");
    $(".history").slideUp("slow");
    $(".prescription").slideUp("slow");
    $(".laboratory").slideUp("slow");
    $(".results").slideUp("slow");
    $(".clerk").slideUp("slow"); 
    $(".complaints").slideUp("slow"); 
    $(".symptoms").slideUp("slow");
    $(".allergies").slideUp("slow");
    $(".visit_summary").slideUp("slow");
    $(".procedure").slideDown("slow");
});
    */
    $(".opd_vital_link").click(function(){
        $(".bar").addClass("btn-info")
        $(".bar").removeClass("btn-inverse")
      
        $(".opd_vital").slideDown("slow");
        $(".opd_enquiry").slideUp("slow");
        $(".opd_procedures").slideUp("slow");
         
       
    });
    
    
    $(".opd_enquiry_link").click(function(){
        $(".bar").addClass("btn-info")
        $(".bar").removeClass("btn-inverse")
      
        $(".opd_vital").slideUp("slow");
        $(".opd_enquiry").slideDown("slow");
        $(".opd_procedures").slideUp("slow");
         
       
    });
    
    
   
    
    /* $(".opd_allergies_link").click(function(){
        $(".bar").addClass("btn-info")
        $(".bar").removeClass("btn-inverse")
        
        $(".opd_vital").slideUp("slow");
        $(".opd_medical_histories").slideUp("slow");
        $(".opd_family_histories").slideUp("slow");
        $(".opd_social_histories").slideUp("slow");
        $(".opd_allergies").slideDown("slow");
        
        $(".opd_procedures").slideUp("slow");
    }); */
    
    $(".opd_procedures_link").click(function(){
        $(".bar").addClass("btn-info")
        $(".bar").removeClass("btn-inverse")
        
        $(".opd_vital").slideUp("slow");
        $(".opd_wnquiry").slideUp("slow");
        $(".opd_procedures").slideDown("slow");
    });
    
    /* $(".opd_medical_histories_link").click(function(){
        $(".bar").addClass("btn-info")
        $(".bar").removeClass("btn-inverse")
        
        $(".opd_vital").slideUp("slow");
        $(".opd_procedures").slideUp("slow");
        $(".opd_family_histories").slideUp("slow");
        $(".opd_social_histories").slideUp("slow");
        $(".opd_allergies").slideUp("slow");
        $(".opd_medical_histories").slideDown("slow");
    })
    $(".opd_social_histories_link").click(function(){
        $(".bar").addClass("btn-info")
        $(".bar").removeClass("btn-inverse")
        
        $(".opd_vital").slideUp("slow");
        $(".opd_medical_histories").slideUp("slow");
        $(".opd_family_histories").slideUp("slow");
       
        $(".opd_allergies").slideUp("slow");
        $(".opd_procedures").slideUp("slow");
        
        $(".opd_social_histories").slideDown("slow");
    });
    $(".opd_family_histories_link").click(function(){
        $(".bar").addClass("btn-info")
        $(".bar").removeClass("btn-inverse")
        
        $(".opd_vital").slideUp("slow");
        $(".opd_medical_histories").slideUp("slow");
        $(".opd_social_histories").slideUp("slow");
        $(".opd_allergies").slideUp("slow");
        $(".opd_procedures").slideUp("slow");
        $(".opd_family_histories").slideDown("slow");
    });
    
    */
    
    $(".date").datepicker({
        changeMonth: true,
        changeYear: true
    });
/*$('#user_summary').dialog({
	 autoOpen : false,
	 width : 600,
	 modal :true

	 });

	 // Dialog Link
	 $('#dialog_link').click(function() {
	 $('#dialog').dialog('open');
	 return false;
	 });

	 // Modal Link
	 $('#modal_link').click(function() {
	 $('#dialog').dialog('open');
	 return false;
	 });

	 $('#view_user').click(function(){
	 $('#user_summary').dialog('open');
	 return false;
	 });

	 $('#rangeA').daterangepicker();

 */

});
