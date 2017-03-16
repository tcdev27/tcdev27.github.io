<?php
if(isset($_POST['email'])) {

    $email_to = "tom@tchadwickdev.co.uk";

    $email_subject = "Contact Message";

    /**
	*	Error Page
	*		- If an error occurs this function will be processed.
	*		- The user will be presented with a page explaining
	*		  the errors and allowing them to go back.
	**/
    function died($error) {
		echo '<link rel="stylesheet" href="../css/style.css"/>';
		echo '<link rel="stylesheet" href="../css/animate.css"/>';
		echo '<div id="error_page">';
        echo '<h1>An Error was found with your Message</h1>';
        echo '<p>These errors appear below.</p><br /><br />';
        echo '<p>'.$error.'</p><br /><br />';
        echo '<p>Please go back and fix these errors.</p><br /><br />';
        echo '<a href="javascript:history.back()"><button class= "animated rubberBand">Click Here to Go Back</button></a>';
		echo '<img class= "animated fadeinleftBig" src="../img/email_fail.png" alt="Error_Icon">';
		echo '</div';
        die();
    }

    /**
	*	Check that Data Exists
	**/
    if(!isset($_POST['first_name']) ||
        !isset($_POST['last_name']) ||
        !isset($_POST['email']) ||
        !isset($_POST['telephone']) ||
        !isset($_POST['message'])) {
        died('We are sorry, but there appears to be a problem with the form you submitted.');
    }

	/**
	*	Main Code Body
	*		- Assign Variables & Expectations for Validation
	*		- If validation fails error message is created.
	*		- If validation passes, the string data will be
	*		  prepared for sending within an email.
	*		- Finally the email will be sent with the prepared data.
	**/
    $first_name = $_POST['first_name']; // required
    $last_name = $_POST['last_name']; // required
    $email_from = $_POST['email']; // required
    $telephone = $_POST['telephone']; // not required
    $message = $_POST['message']; // required
    $error_message = "";
    $email_exp = '/^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/';
  if(!preg_match($email_exp,$email_from)) {
    $error_message .= 'The Email Address you entered does not appear to be valid.<br />';
  }
    $string_exp = "/^[A-Za-z .'-]+$/";
  if(!preg_match($string_exp,$first_name)) {
    $error_message .= 'The First Name you entered does not appear to be valid.<br />';
  }
  if(!preg_match($string_exp,$last_name)) {
    $error_message .= 'The Last Name you entered does not appear to be valid.<br />';
  }
  if(strlen($message) < 2) {
    $error_message .= 'The message you entered does not appear to be valid.<br />';
  }
  if(strlen($error_message) > 0) {
    died($error_message);
  }
    $email_message = "Form details below.\n\n";

    function clean_string($string) {
      $bad = array("content-type","bcc:","to:","cc:","href");
      return str_replace($bad,"",$string);
    }

    $email_message .= "First Name: ".clean_string($first_name)."\n";
    $email_message .= "Last Name: ".clean_string($last_name)."\n";
    $email_message .= "Email: ".clean_string($email_from)."\n";
    $email_message .= "Telephone: ".clean_string($telephone)."\n";
    $email_message .= "message: ".clean_string($message)."\n";


// Create Email headers
$headers = 'From: '.$email_from."\r\n".
'Reply-To: '.$email_from."\r\n" .
'X-Mailer: PHP/' . phpversion();
// Send Email
@mail($email_to, $email_subject, $email_message, $headers);
}
/**
*	Confirmation Page
*		- Once the Email has been sent the following confirmation page
*		  will show.
*		- From here the user can then navigate back to main page.
**/
?>

<!--Confirmation Page-->
<html>
	<head>
		<title>Message Sent!</title>
		<link rel="icon" href="img/icon.ico">
		<!-- Styling -->
		<link rel="stylesheet" href="../css/style.css"/>
		<!-- Fonts -->
		<link href='https://fonts.googleapis.com/css?family=Play:400,700' rel='stylesheet' type='text/css'>
	</head>
	<body id="message_sent">
		<div class="content">
			<h1>Message Sent!</h1>
			<!-- Was = javascript:history.back() -->
			<a href="http://www.tchadwickdev.co.uk"><button class= "animated rubberBand">Click Here to Go Back</button></a>
			<img class= "" src="../img/sent_icon.png" alt="message_sent" align="left" width="15%">
		</div>
	</body>
</html>

<?php
die();
?>
