package com.sunrisedental.util;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class QRUtil {

    private static final String QR_API_URL = "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=";

    public static String generateQRUrl(String data) {
        try {
            return QR_API_URL + URLEncoder.encode(data, StandardCharsets.UTF_8.toString());
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }
}
