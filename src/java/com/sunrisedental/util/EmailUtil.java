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
            message.setSubject("Payment Received & Appointment Confirmed - Sunrise Dental");

            String content = "<div style='font-family: Arial, sans-serif; border: 1px solid #ddd; padding: 20px; max-width: 600px;'>"
                    + "<h2 style='color: #28a745;'>Payment Receipt: LKR 1,000.00</h2>"
                    + "<p>Dear <b>" + patientName + "</b>,</p>"
                    + "<p>We have successfully received your registration fee. Your appointment is now confirmed.</p>"
                    + "<div style='background: #f9f9f9; padding: 15px; border-radius: 5px;'>"
                    + "<p><b>Appointment Number:</b> " + appNumber + "</p>"
                    + "<p><b>Date:</b> " + date + "</p>"
                    + "<p><b>Time:</b> " + time + "</p>"
                    + "<p><b>Amount Paid:</b> LKR 1,000.00 (Registration)</p>"
                    + "</div>"
                    + "<p style='margin-top: 20px;'>Please show this email at the reception upon arrival.</p>"
                    + "<hr><p style='font-size: 0.8em; color: #777;'>Sunrise Dental Clinic<br>123, Ward Place, Colombo 07</p>"
                    + "</div>";

            message.setContent(content, "text/html");

            Transport.send(message);
            System.out.println("Email sent successfully to " + toEmail);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
