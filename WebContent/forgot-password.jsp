<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="header.jsp" />
	<script  type="text/javascript">
	(function($) {
	    "use strict";
		
		// Options for Message
		//----------------------------------------------
	  var options = {
		  'btn-loading': '<i class="fa fa-spinner fa-pulse"></i>',
		  'btn-success': '<i class="fa fa-check"></i>',
		  'btn-error': '<i class="fa fa-remove"></i>',
		  'msg-success': 'All Good! Redirecting...',
		  'msg-error': 'Wrong login credentials!',
		  'useAJAX': true,
	  };

		// Login Form
		//----------------------------------------------
		// Validation
	  $("#login-form").validate({
	  	rules: {
	      lg_username: "required",
	  	  lg_password: "required",
	    },
	  	errorClass: "form-invalid"
	  });
	  
		// Form Submission
	  $("#login-form").submit(function() {
	  	remove_loading($(this));
			
			if(options['useAJAX'] == true)
			{
				// Dummy AJAX request (Replace this with your AJAX code)
			  // If you don't want to use AJAX, remove this
	  	  dummy_submit_form($(this));
			
			  // Cancel the normal submission.
			  // If you don't want to use AJAX, remove this
	  	  return false;
			}
	  });
		
		// Register Form
		//----------------------------------------------
		// Validation
	  $("#register-form").validate({
	  	rules: {
	      reg_username: "required",
	  	  reg_password: {
	  			required: true,
	  			minlength: 5
	  		},
	   		reg_password_confirm: {
	  			required: true,
	  			minlength: 5,
	  			equalTo: "#register-form [name=reg_password]"
	  		},
	  		reg_email: {
	  	    required: true,
	  			email: true
	  		},
	  		reg_agree: "required",
	    },
		  errorClass: "form-invalid",
		  errorPlacement: function( label, element ) {
		    if( element.attr( "type" ) === "checkbox" || element.attr( "type" ) === "radio" ) {
	    		element.parent().append( label ); // this would append the label after all your checkboxes/labels (so the error-label will be the last element in <div class="controls"> )
		    }
				else {
	  	  	label.insertAfter( element ); // standard behaviour
	  	  }
	    }
	  });

	  // Form Submission
	  $("#register-form").submit(function() {
	  	remove_loading($(this));
			
			if(options['useAJAX'] == true)
			{
				// Dummy AJAX request (Replace this with your AJAX code)
			  // If you don't want to use AJAX, remove this
	  	  dummy_submit_form($(this));
			
			  // Cancel the normal submission.
			  // If you don't want to use AJAX, remove this
	  	  return false;
			}
	  });

		// Forgot Password Form
		//----------------------------------------------
		// Validation
	  $("#forgot-password-form").validate({
	  	rules: {
	      fp_email: "required",
	    },
	  	errorClass: "form-invalid"
	  });
	  
		// Form Submission
	  $("#forgot-password-form").submit(function() {
	  	remove_loading($(this));
			
			if(options['useAJAX'] == true)
			{
				// Dummy AJAX request (Replace this with your AJAX code)
			  // If you don't want to use AJAX, remove this
	  	  dummy_submit_form($(this));
			
			  // Cancel the normal submission.
			  // If you don't want to use AJAX, remove this
	  	  return false;
			}
	  });

		// Loading
		//----------------------------------------------
	  function remove_loading($form)
	  {
	  	$form.find('[type=submit]').removeClass('error success');
	  	$form.find('.login-form-main-message').removeClass('show error success').html('');
	  }

	  function form_loading($form)
	  {
	    $form.find('[type=submit]').addClass('clicked').html(options['btn-loading']);
	  }
	  
	  function form_success($form)
	  {
		  $form.find('[type=submit]').addClass('success').html(options['btn-success']);
		  $form.find('.login-form-main-message').addClass('show success').html(options['msg-success']);
	  }

	  function form_failed($form)
	  {
	  	$form.find('[type=submit]').addClass('error').html(options['btn-error']);
	  	$form.find('.login-form-main-message').addClass('show error').html(options['msg-error']);
	  }

		// Dummy Submit Form (Remove this)
		//----------------------------------------------
		// This is just a dummy form submission. You should use your AJAX function or remove this function if you are not using AJAX.
	  function dummy_submit_form($form)
	  {
	  	if($form.valid())
	  	{
	  		form_loading($form);
	  		
	  		setTimeout(function() {
	  			form_success($form);
	  		}, 2000);
	  	}
	  }
		
	})(jQuery);
	</script>

</head>
<body>
	<div id="wrapper">
        <div id="page-wrapper">

            <div class="container-fluid">
				<!-- FORGOT PASSWORD FORM -->
				<div class="row">
					<h1 class="page-header">Password olvidado</h1>
					<!-- Main Form -->
					<div class="col-lg-8">
					</div>
					<div class="col-lg-8">
						<form id="forgot-password-form" class="text-left">
							<div class="etc-login-form">
								<p>Si el usuario en su registro cuenta con una cuenta de correo electronico, las instrucciones seran enviadas a dicha cuenta.</p>
							</div>
							<div class="login-form-main-message"></div>
							<div class="main-login-form">
								<div class="login-group">
									<div class="form-group">
										<label for="fp_email" class="sr-only">Correo electronico</label>
										<input type="text" class="form-control" id="fp_email" name="fp_email" placeholder="correo electronico">
									</div>
								</div>
								<button type="submit" class="btn btn-info">Enviar</button>
							</div>
							<div class="etc-login-form">
								<p>¿Ya tienes una cuenta? <a href="#">login aquí</a></p>
							</div>
						</form>
					</div>
					<div class="col-lg-8">
					</div>
					<!-- end:Main Form -->
				</div>
			</div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->

    </div>
</body>
</html>