package com.spring.libway.util;

import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

public class FormatadorDeData {

    private static final ZoneId FUSO_HORARIO_BRASIL = ZoneId.of("America/Sao_Paulo");
    private static final DateTimeFormatter FORMATADOR = DateTimeFormatter.ofPattern("dd/MM/yyyy - HH:mm");

    public static String formatarParaBrasileiro(OffsetDateTime data) {
        if (data == null) {
            return "";
        }
        return data.atZoneSameInstant(FUSO_HORARIO_BRASIL).format(FORMATADOR);
    }
}