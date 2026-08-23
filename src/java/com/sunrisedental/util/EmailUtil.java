package com.sunrisedental.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailUtil {

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_FROM = "your-clinic-email@gmail.com";
    private static final String APP_PASSWORD = "your-app-password"; // Use App Password for Gmail

    public static void sendConfirmationEmail(String toEmail, String patientName, String appNumber, String date, String time) {
        Properties prop = new Properties();
        prop.put("mail.smtp.host", SMTP_HOST);
        prop.put("mail.smtp.port", SMTP_PORT);
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(prop, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_FROM, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_FROM));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Appointment Confirmation - Sunrise Dental Clinic");

            String content = "<h1>Appointment Confirmed!</h1>"
                    + "<p>Dear " + patientName + ",</p>"
                    + "<p>Your appointment has been successfully booked.</p>"
                    + "<p><b>Appointment Number:</b> " + appNumber + "</p>"
                    + "<p><b>Date:</b> " + date + "</p>"
                    + "<p><b>Time:</b> " + time + "</p>"
                    + "<p>Please arrive 15 minutes early. Registration fee of LKR 1,000.00 is confirmed.</p>"
                    + "<br><p>Regards,<br>Sunrise Dental Team</p>";

            message.setContent(content, "text/html");

            Transport.send(message);
            System.out.println("Email sent successfully to " + toEmail);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
