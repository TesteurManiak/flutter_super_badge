package com.maniak.flutter_super_badge;

import java.io.Serializable;
import java.util.HashMap;

public class BadgeSettings implements Serializable {
    public int count;
    public String title;
    public String icon;

    public static BadgeSettings from(HashMap<String, Object> arguments) {
        BadgeSettings configuration = new BadgeSettings();
        configuration.count = (int) arguments.get("count");
        configuration.title = (String) arguments.get("title");
        configuration.icon = (String) arguments.get("icon");

        return configuration;
    }
}
