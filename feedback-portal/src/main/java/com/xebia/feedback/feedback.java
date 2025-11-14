package com.xebia.feedback;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

public class feedback {
    public static class Feedback {
        private final String course;
        private final String message;
        private final String timestamp;

        public Feedback(String course, String message) {
            this.course = course;
            this.message = message;
            this.timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        }

        public String getCourse() { return course; }
        public String getMessage() { return message; }
        public String getTimestamp() { return timestamp; }

        @Override
        public String toString() {
            return String.format("[%s] %s: %s", timestamp, course, message);
        }
    }

    private static final int MAX_FEEDBACKS = 1000;
    private static final List<Feedback> feedbacks = Collections.synchronizedList(new ArrayList<>());

    public static boolean addFeedback(String course, String message) {
        if (message == null || message.trim().isEmpty()) {
            return false;
        }

        String trimmedMessage = message.trim();
        String courseName = (course == null) ? "General" : course.trim();

        // Validate message length
        if (trimmedMessage.length() > 1000) {
            return false;
        }

        synchronized (feedbacks) {
            // Manage capacity
            if (feedbacks.size() >= MAX_FEEDBACKS) {
                feedbacks.remove(0);
            }

            Feedback feedback = new Feedback(courseName, trimmedMessage);
            feedbacks.add(feedback);
        }
        return true;
    }

    public static List<Feedback> getAllFeedbacks() {
        synchronized (feedbacks) {
            return new ArrayList<>(feedbacks);
        }
    }

    public static int getFeedbackCount() {
        return feedbacks.size();
    }

    public static void clear() {
        feedbacks.clear();
    }

    public static List<Feedback> getFeedbacksByCourse(String course) {
        synchronized (feedbacks) {
            return feedbacks.stream()
                    .filter(f -> f.getCourse().equals(course))
                    .collect(Collectors.toList());
        }
    }
}