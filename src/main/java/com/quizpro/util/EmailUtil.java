package com.quizpro.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import com.openhtmltopdf.pdfboxout.PdfRendererBuilder;

public class EmailUtil {

	private static final String FROM_EMAIL = "quizpro.org@gmail.com";
	private static final String APP_PASSWORD = "pien sjzi ksxh xepi";

	public static void sendOtp(String to, int otp) {
		String subject = "Your OTP Code";
		String html = getOtpTemplate(otp);
		sendMail(to, subject, html);
	}

	public static void sendSuccessMail(String to) {
		String subject = "Registration Successful";
		String html = getSuccessTemplate();
		sendMail(to, subject, html);
	}

	public static void sendCreateMail(String to, String name, String password) {
		String subject = "Account Creation Successful";
		String html = getCreationMail(name, to, password);
		sendMail(to, subject, html);
	}

	public static void sendCompleteMail(String to) {
		String subject = "Test Completed Successfully";
		String html = getTestCompleteTemplate();
		sendMail(to, subject, html);
	}

	public static void sendMail(String to, String subject, String htmlContent) {
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");

		Session session = Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
			}
		});

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(FROM_EMAIL));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
			message.setSubject(subject);
			message.setContent(htmlContent, "text/html; charset=utf-8");
			Transport.send(message);
			System.out.println("HTML Mail Sent Successfully!");
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	public static void sendCertificateMail(String to, String userName, String quizName, String certificateId,
			String date) {
		try {
			// 1. Generate certificate HTML
			String html = getCertificateHtml(userName, quizName, date, certificateId);

			// 2. Convert HTML to PDF
			File pdf = generateCertificatePdf(html, "QuizPro-Certificate.pdf");

			// 3. Send mail with attachment
			sendMailWithAttachment(to, "🎓 Your QuizPro Certificate",
					"Congratulations! Your certificate is attached with this email.", pdf);

			// 4. Cleanup
			pdf.delete();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static void sendMailWithAttachment(String to, String subject, String messageText, File attachment)
			throws Exception {

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		Session session = Session.getInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
			}
		});

		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(FROM_EMAIL));
		message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
		message.setSubject(subject);

		// Text body
		MimeBodyPart textPart = new MimeBodyPart();
		textPart.setText(messageText);

		MimeBodyPart htmlPart = new MimeBodyPart();
		htmlPart.setContent(getCertificateMailBody(), "text/html; charset=UTF-8");

		// Attachment
		MimeBodyPart attachmentPart = new MimeBodyPart();
		attachmentPart.attachFile(attachment);

		Multipart multipart = new MimeMultipart("mixed");

		Multipart bodyMultipart = new MimeMultipart("alternative");
		bodyMultipart.addBodyPart(textPart);
		bodyMultipart.addBodyPart(htmlPart);

		MimeBodyPart bodyWrapper = new MimeBodyPart();
		bodyWrapper.setContent(bodyMultipart);

		multipart.addBodyPart(bodyWrapper);
		multipart.addBodyPart(attachmentPart);

		message.setContent(multipart);
		System.out.println("Email sent successfully");
		Transport.send(message);
	}

	private static String getCertificateMailBody() {
		return """
				<div style="font-family: Arial, sans-serif; background:#f4f6f8; padding:25px;">
				    <div style="
				        max-width:600px;
				        margin:auto;
				        background:#ffffff;
				        padding:30px;
				        border-radius:10px;
				        box-shadow:0 4px 12px rgba(0,0,0,0.1);
				        border-top:6px solid #0077B6;
				    ">

				        <h2 style="text-align:center; color:#0077B6;">
				            🎓 Congratulations!
				        </h2>

				        <p style="font-size:16px; color:#333;">
				            You have successfully completed the quiz:
				        </p>



				        <p style="font-size:15px; color:#444;">
				            We are pleased to inform you that your <strong>certificate of mastery</strong>
				            has been generated successfully.
				        </p>



				        <p style="font-size:14px; color:#555;">
				            You can download and share this certificate for professional or academic use.
				        </p>

				        <p style="font-size:14px; color:#333;">
				            Best wishes,<br/>
				            <strong>QuizPro Team</strong>
				        </p>

				        <p style="
				            font-size:12px;
				            color:#888;
				            text-align:center;
				            margin-top:25px;
				        ">
				            © 2025 QuizPro. All rights reserved.
				        </p>

				    </div>
				</div>
				""";
	}

	public static String getOtpTemplate(int otp) {
		return String.format("""
				            <div style="font-family: Arial, sans-serif; background:#eef2f7; padding:25px;">
				    <div style="
				        max-width:520px;
				        margin:auto;
				        background:white;
				        padding:30px;
				        border-radius:15px;
				        box-shadow:0 6px 20px rgba(0,0,0,0.12);
				        border-top:6px solid #4A90E2;
				    ">

				        <!-- Header -->
				        <div style="
				            text-align:center;
				            padding-bottom:15px;
				            border-bottom:1px solid #e5e5e5;
				        ">
				            <h2 style="
				                margin:0;
				                font-size:26px;
				                color:#4A90E2;
				                font-weight:700;
				            ">
				                🔐 QuizPro Verification
				            </h2>
				            <p style="color:#555; margin-top:5px; font-size:14px;">
				                Secure One-Time Password (OTP)
				            </p>
				        </div>

				        <!-- Message -->
				        <p style="font-size:16px; color:#333; margin-top:25px;">
				            Hello User,
				        </p>
				        <p style="font-size:16px; color:#444;">
				            Use the verification code below to complete your action:
				        </p>

				        <!-- OTP Box -->
				        <div style="
				            text-align:center;
				            background:#f7f9fc;
				            padding:20px;
				            border-radius:10px;
				            margin:25px 0;
				            border:1px solid #e0e6ed;
				        ">
				            <span style="
				                font-size:42px;
				                font-weight:bold;
				                color:#2d3436;
				                letter-spacing:10px;
				            ">
				                %06d
				            </span>
				        </div>

				        <!-- Footer Info -->
				        <p style="font-size:15px; color:#333; text-align:center;">
				            This code is valid for <b>2 minutes</b><br>
				            Please do not share it with anyone.
				        </p>

				        <p style="font-size:13px; color:#888; text-align:center; margin-top:20px;">
				            If you did not request this code, simply ignore this email.
				        </p>

				    </div>
				</div>

				            """, otp);
	}

	public static String getSuccessTemplate() {
		return """
								<div style="font-family: Arial, sans-serif; background:#eef2f7; padding:25px;">
				    <div style="
				        max-width:520px;
				        margin:auto;
				        background:white;
				        padding:30px;
				        border-radius:15px;
				        box-shadow:0 6px 20px rgba(0,0,0,0.12);
				        border-top:6px solid #2ecc71;
				    ">

				        <!-- Header -->
				        <div style="text-align:center; padding-bottom:15px; border-bottom:1px solid #e5e5e5;">
				            <h2 style="
				                margin:0;
				                font-size:26px;
				                color:#2ecc71;
				                font-weight:700;
				            ">
				                🎉 Registration Successful!
				            </h2>
				            <p style="color:#555; margin-top:5px; font-size:14px;">
				                Welcome to QuizPro – Your learning journey starts now.
				            </p>
				        </div>

				        <!-- Body -->
				        <p style="font-size:16px; color:#333; margin-top:25px;">
				            Hello,
				        </p>

				        <p style="font-size:16px; color:#444;">
				            Your QuizPro account has been created successfully.
				            You can now log in and start attempting quizzes.
				        </p>

				        <!-- Success Icon -->
				        <div style="text-align:center; margin:25px 0;">
				            <div style="
				                display:inline-block;
				                background:#e9f9f0;
				                padding:18px;
				                border-radius:50%;
				                border:2px solid #2ecc71;
				            ">
				                <span style="font-size:32px; color:#2ecc71;">✔</span>
				            </div>
				        </div>

				        <!-- Button -->
				        <div style="text-align:center; margin-top:20px;">
				            <a href="http://localhost:8080/QuizPro/login.jsp"
				                style="
				                    background:#2ecc71;
				                    color:white;
				                    padding:12px 22px;
				                    text-decoration:none;
				                    border-radius:8px;
				                    font-size:16px;
				                    font-weight:bold;
				                    box-shadow:0 3px 10px rgba(0,0,0,0.1);
				                    display:inline-block;
				                ">
				                Login Now
				            </a>
				        </div>

				        <!-- Footer -->
				        <p style="font-size:13px; color:#888; text-align:center; margin-top:25px;">
				            If you did not create this account, please ignore this email.
				        </p>

				    </div>
				</div>

								""";
	}

	public static String getTestCompleteTemplate() {
		return """
								<div style="font-family: Arial, sans-serif; background:#eef2f7; padding:25px;">
				    <div style="
				        max-width:520px;
				        margin:auto;
				        background:white;
				        padding:30px;
				        border-radius:15px;
				        box-shadow:0 6px 20px rgba(0,0,0,0.12);
				        border-top:6px solid #4A90E2;
				    ">

				        <!-- Header -->
				        <div style="text-align:center; padding-bottom:15px; border-bottom:1px solid #e5e5e5;">
				            <h2 style="
				                margin:0;
				                font-size:26px;
				                color:#4A90E2;
				                font-weight:700;
				            ">
				                🎉 Test Completed Successfully!
				            </h2>
				            <p style="color:#555; margin-top:5px; font-size:14px;">
				                Your QuizPro test has been submitted.
				            </p>
				        </div>

				        <!-- Body -->
				        <p style="font-size:16px; color:#333; margin-top:25px;">
				            Hello,
				        </p>

				        <p style="font-size:16px; color:#444;">
				            You have successfully completed the test.
				            You can check your score by login in to the portal and download the certificate from there.
				        </p>

				        <p style="font-size:14px; color:#444;">
				            Thanks for using QuizPro
				        </p>

				        <!-- Footer -->
				        <p style="font-size:13px; color:#888; text-align:center; margin-top:25px;">
				            If you did not take this test, please ignore this email.
				        </p>

				    </div>
				</div>

								""";
	}

	public static String getCreationMail(String name, String email, String password) {

		String loginUrl = "http://localhost:8080/QuizPro/login.jsp"; // change if needed

		return """
				<div style="max-width:600px; margin:40px auto; background:#ffffff; padding:30px;
				            border-radius:10px; box-shadow:0 4px 12px rgba(0,0,0,0.1);">

				    <h2 style="text-align:center; color:#0077B6; margin-bottom:10px;">
				        Welcome to QuizPro 🎉
				    </h2>
				    <p style="text-align:center; color:#6c757d; margin-top:0;">
				        Your account has been successfully created by the administrator
				    </p>

				    <hr style="border:none; border-top:1px solid #e0e0e0; margin:25px 0;">

				    <p style="font-size:16px; color:#333;">
				        Hello <strong>%s</strong>,
				    </p>

				    <p style="font-size:15px; color:#555; line-height:1.6;">
				        We’re excited to inform you that your <strong>QuizPro</strong> account has been
				        successfully created by the administrator.
				        You can now log in and start exploring quizzes, assessments, and certifications.
				    </p>

				    <div style="background:#f8f9fa; padding:15px; border-radius:8px; margin:20px 0;">
				        <p style="margin:6px 0;"><strong>Username:</strong> %s</p>
				        <p style="margin:6px 0;"><strong>Temporary Password:</strong> %s</p>
				    </div>

				    <p style="font-size:14px; color:#856404; background:#fff3cd; padding:12px; border-radius:6px;">
				        ⚠️ For security reasons, please change your password after your first login.
				    </p>

				    <div style="text-align:center; margin:30px 0;">
				        <a href="%s"
				           style="background:#0077B6; color:#ffffff; padding:12px 26px;
				                  text-decoration:none; border-radius:6px; font-size:16px;">
				            Login to QuizPro
				        </a>
				    </div>

				    <p style="font-size:13px; color:#6c757d; text-align:center; margin-top:30px;">
				        If you have any questions, please contact the administrator.<br>
				        © 2025 QuizPro. All rights reserved.
				    </p>

				</div>
				""".formatted(name, email, password, loginUrl);
	}

	private static String getCertificateHtml(String name, String quiz, String date, String certId) {
		return """
												     <!DOCTYPE html>
				<html xmlns="http://www.w3.org/1999/xhtml">
				<head>
				<meta charset="UTF-8" />
				<title>Certificate of Mastery</title>

				<style>

				@page {
				    size: A4 landscape;
				    margin: 0;
				}

				html, body {
				    width: 297mm;
				    height: 210mm;
				    margin: 0;
				    padding: 0;
				    font-family: Arial, Helvetica, sans-serif;
				}

				/* ================= CERTIFICATE ================= */
				.certificate-container {
				    width: 297mm;
				    height: 210mm;
				    background: #f7f4e4;
				    border: 10px solid #c8a853;
				    padding: 20mm 25mm;
				    box-sizing: border-box;
				    text-align: center;
				}

				/* ================= LOGO ================= */
				.logo {
				    font-size: 46px;
				    font-weight: bold;
				    margin-bottom: 12mm;
				}

				.logo-quiz { color: #2b6b7f; }
				.logo-pro  { color: #d4a429; }

				/* ================= TITLE ================= */
				.certificate-title {
				    font-family: "Times New Roman", Times, serif;
				    font-size: 54px;
				    letter-spacing: 1.5px;
				    margin-bottom: 5mm;
				}

				/* ================= BODY ================= */
				.certifies-text {
				    font-size: 18px;
				    margin-bottom: 5mm;
				}

				.recipient-banner {
				    font-size: 40px;
				    font-weight: bold;
				    margin: 6mm 0 3mm;
				}

				.completion-text {
				    font-size: 16px;
				    margin-bottom: 6mm;
				}

				/* Narrow content like Image-2 */
				.course-name {
				    width: 75%%;
				    margin: 0 auto 19mm;
				    font-size: 28px;
				    font-weight: bold;
				    letter-spacing: 1.5px;
				    line-height: 1.3;
				}

				/* ================= FOOTER ================= */
				.certificate-footer {
				    display: table;
				    width: 100%%;
				    table-layout: fixed;
				    margin-top: -6mm;
				}

				.footer-cell {
				    display: table-cell;
				    vertical-align: middle;
				}

				/* ================= SEAL ================= */
				.footer-left {
				    width: 25%%;
				    text-align: left;
				}

				.gold-seal {
				    width: 105px;
				    height: 105px;
				    border-radius: 50%%;
				    background: #d4a429;
				    border: 4px solid #c8a853;
				    text-align: center;
				}

				.seal-text {
				    color: #ffffff;
				    font-size: 13px;
				    font-weight: bold;
				    padding-top: 32px;
				}

				/* ================= DETAILS ================= */
				.footer-center {
				    width: 40%%;
				    text-align: left;
				    font-size: 14px;
				    padding-left: 10px;
				}

				/* ================= SIGNATURE ================= */
				.footer-right {
				    width: 35%%;
				    text-align: right;
				}

				.signature {
				    font-family: "Times New Roman", Times, serif;
				    font-size: 36px;
				    color: #2b6b7f;
				}

				.signature-title {
				    font-size: 14px;
				}
				</style>
				</head>

				<body>

				<div class="certificate-container" id="elite-certificate">

				    <div class="logo">
				        <span class="logo-quiz">Quiz</span><span class="logo-pro">Pro</span>
				    </div>

				    <div class="certificate-title">Certificate of Mastery</div>

				    <div class="certifies-text">This certifies that</div>

				    <div class="recipient-banner">%s</div>

				    <div class="completion-text">
				        has successfully completed and mastered the specialized learning path in
				    </div>

				    <div class="course-name">%s</div>

				    <div class="certificate-footer">

				    <div class="footer-cell footer-left">
				        <div class="gold-seal">
				            <div class="seal-text">QuizPro<br/>Certified</div>
				        </div>
				    </div>

				    <div class="footer-cell footer-center">
				        <p><strong>Awarded on:</strong> %s</p>
				        <p><strong>Unique Verification ID:</strong> %s</p>
				    </div>

				    <div class="footer-cell footer-right">
				        <div class="signature">Sandesh</div>
				        <div class="signature-title">CEO, QuizPro</div>
				    </div>

				</div>
				</div>

				</body>
				</html>
												     """.formatted(name, quiz, date, certId);
	}

	private static File generateCertificatePdf(String html, String fileName) throws Exception {

		File pdfFile = new File(System.getProperty("java.io.tmpdir"), fileName);

		try (OutputStream os = new FileOutputStream(pdfFile)) {
			PdfRendererBuilder builder = new PdfRendererBuilder();
			builder.withHtmlContent(html, null);
			builder.toStream(os);
			builder.run();
		}
		return pdfFile;
	}

	public static void sendSupportQueryFromUser(String userEmail, String username, String userId, String userMessage) {

		String subject = "📩 Support Query - QuizPro";

		String html = """
				<div style="font-family: Arial, sans-serif; background:#f4f6f8; padding:25px;">
				    <div style="
				        max-width:600px;
				        margin:auto;
				        background:#ffffff;
				        padding:30px;
				        border-radius:10px;
				        box-shadow:0 4px 12px rgba(0,0,0,0.1);
				        border-top:6px solid #FFB700;
				    ">

				        <h2 style="color:#0077B6;">New Support Query</h2>

				        <p><strong>User Name:</strong> %s</p>
				        <p><strong>User ID:</strong> %s</p>
				        <p><strong>User Email:</strong> %s</p>

				        <div style="
				            background:#f0f2f5;
				            padding:15px;
				            border-radius:8px;
				            margin-top:15px;
				            line-height:1.6;
				        ">
				            %s
				        </div>

				        <p style="font-size:12px; color:#777; margin-top:25px;">
				            Sent from QuizPro dashboard footer
				        </p>

				    </div>
				</div>
				""".formatted(username, userId, userEmail, userMessage.replaceAll("\n", "<br>"));

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");

		Session session = Session.getInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
			}
		});

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(FROM_EMAIL));
			message.setReplyTo(InternetAddress.parse(userEmail)); // ⭐ reply to user
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(FROM_EMAIL));
			message.setSubject(subject);
			message.setContent(html, "text/html; charset=UTF-8");

			Transport.send(message);
			System.out.println("Support query mail sent with user details");

		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

}
