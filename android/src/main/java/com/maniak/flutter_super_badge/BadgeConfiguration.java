package com.maniak.flutter_super_badge;

import java.util.HashMap;

public class BadgeConfiguration {
    public final int count;
    public final String title;

    public BadgeConfiguration(int count, String title) {
        this.count = count;
        this.title = title;
    }

    public static BadgeConfiguration fromJson(HashMap<String, Object> json) {
        final int count = (int) json.get("count");
        final String title = (String) json.get("title");
        return new BadgeConfiguration(count, title);
    }
}
