package com.xebia.feedback;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class feedbacktest {

    @BeforeEach
    public void setup() {
        feedback.clear();
    }

    @AfterEach
    public void tearDown() {
        feedback.clear();
    }

    @Test
    public void testAddValidFeedback() {
        boolean added = feedback.addFeedback("CSE101", "Great course!");
        assertTrue(added, "Valid feedback should be added");

        List<feedback.Feedback> all = feedback.getAllFeedbacks();
        assertEquals(1, all.size());
        assertEquals("Great course!", all.get(0).getMessage());
        assertEquals("CSE101", all.get(0).getCourse());
        assertNotNull(all.get(0).getTimestamp());
    }

    @Test
    public void testAddFeedbackWithNullCourse() {
        boolean added = feedback.addFeedback(null, "Good content!");
        assertTrue(added, "Feedback with null course should be added with empty course name");

        List<feedback.Feedback> all = feedback.getAllFeedbacks();
        assertEquals(1, all.size());
        assertEquals("Good content!", all.get(0).getMessage());
        assertEquals("", all.get(0).getCourse());
    }

    @Test
    public void testRejectEmptyFeedback() {
        boolean added1 = feedback.addFeedback("CSE101", " ");
        boolean added2 = feedback.addFeedback("CSE101", " ");
        boolean added3 = feedback.addFeedback("CSE101", "");

        assertFalse(added1, "Whitespace-only feedback must be rejected");
        assertFalse(added2, "Null feedback must be rejected");
        assertFalse(added3, "Empty string feedback must be rejected");

        assertEquals(0, feedback.getFeedbackCount());
    }

    @Test
    public void testMultipleFeedbacksAndCount() {
        feedback.addFeedback("CSE101", "Nice explanations");
        feedback.addFeedback("CSE102", "Need more labs");
        feedback.addFeedback("CSE103", "Excellent instructor");

        assertEquals(3, feedback.getFeedbackCount());
        assertEquals(3, feedback.getAllFeedbacks().size());
    }

    @Test
    public void testFeedbackIsolation() {
        // Test that feedbacks are isolated between tests
        feedback.addFeedback("TEST", "First feedback");
        assertEquals(1, feedback.getFeedbackCount());

        // tearDown will clear this, so next test starts fresh
    }

    @Test
    public void testGetAllFeedbacksReturnsCopy() {
        feedback.addFeedback("CSE101", "Original feedback");

        List<feedback.Feedback> firstCopy = feedback.getAllFeedbacks();
        assertEquals(1, firstCopy.size());

        // Modify the returned list shouldn't affect the original store
        firstCopy.clear();

        // Original store should still have the feedback
        assertEquals(1, feedback.getFeedbackCount());
        assertEquals(1, feedback.getAllFeedbacks().size());
    }

    @Test
    public void testFeedbackProperties() {
        feedback.addFeedback("MATH201", "Challenging but rewarding");

        List<feedback.Feedback> feedbacks = feedback.getAllFeedbacks();
        feedback.Feedback feedback = feedbacks.get(0);

        assertEquals("MATH201", feedback.getCourse());
        assertEquals("Challenging but rewarding", feedback.getMessage());
        assertNotNull(feedback.getTimestamp());
        assertTrue(feedback.getTimestamp().matches("\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}"));
    }

    @Test
    public void testClearFeedbacks() {
        feedback.addFeedback("CSE101", "Feedback 1");
        feedback.addFeedback("CSE102", "Feedback 2");

        assertEquals(2, feedback.getFeedbackCount());

        feedback.clear();

        assertEquals(0, feedback.getFeedbackCount());
        assertTrue(feedback.getAllFeedbacks().isEmpty());
    }

    @Test
    public void testConcurrentAccess() throws InterruptedException {
        Thread t1 = new Thread(() -> {
            for (int i = 0; i < 100; i++) {
                feedback.addFeedback("Course" + i, "Message" + i);
            }
        });

        Thread t2 = new Thread(() -> {
            for (int i = 0; i < 100; i++) {
                feedback.addFeedback("Course" + (i + 100), "Message" + (i + 100));
            }
        });

        t1.start();
        t2.start();
        t1.join();
        t2.join();

        assertEquals(200, feedback.getFeedbackCount());
    }
}