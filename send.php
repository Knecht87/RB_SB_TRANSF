<?php
				require "vendor/phpmailer/phpmailer/PHPMailerAutoload.php";
				$mail = new PHPMailer;
				$mail->From = "";
				#$mail->FromName = $_POST['username'];
				$mail->FromName = 'noreply';
				#$mail->addAddress($_POST['email']);
				$mail->addAddress('');
				$mail->addAddress('');
				$mail->addAddress('');
				$mail->addAddress('');
				$mail->addAddress('');
				$mail->addAddress('');
				$mail->isHTML(true);
				$mail->Subject = "Selfbill transfer";
				$mail->Body = "File attached";
				#attach file
				$attachment_path = '/ua13app/lifeua/ecom/scripts/out/sb_transf/sb_transf.csv';
				$filename = 'sb_transf.csv';
				$mail->addAttachment($attachment_path,$filename);
				$mail->IsSMTP();
				$mail->CharSet = 'UTF-8';
				$mail->Host       = '';
				$mail->SMTPAuth   = true;
				$mail->SMTPSecure = 'ssl';
				$mail->Port       = 465;
				$mail->Username   = '';
				$mail->Password   = '';
				#$mail->SMTPDebug = 3;  
				if(!$mail->send()) 
					{
					    echo $error.$mail->ErrorInfo;
					} 
				else 
					{
					    echo "WELL DONE NIGGA!\n";
					}
?>
