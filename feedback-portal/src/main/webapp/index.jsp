<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Feedback Portal - Submit Feedback</title>
    <style>
        :root {
            --primary-color: #4361ee;
            --primary-hover: #3a56d4;
            --secondary-color: #7209b7;
            --text-color: #2b2d42;
            --light-gray: #f8f9fa;
            --border-color: #e9ecef;
            --success-color: #4bb543;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
            color: var(--text-color);
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            border-radius: 16px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 30px;
            text-align: center;
        }

        .header h1 {
            font-size: 2.2rem;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .header p {
            opacity: 0.9;
            font-size: 1.1rem;
        }

        .navigation {
            background: var(--light-gray);
            padding: 20px;
            border-bottom: 1px solid var(--border-color);
        }

        .nav-links {
            display: flex;
            justify-content: center;
            gap: 30px;
        }

        .nav-links a {
            text-decoration: none;
            color: var(--text-color);
            font-weight: 500;
            padding: 10px 20px;
            border-radius: 25px;
            transition: all 0.3s ease;
            position: relative;
        }

        .nav-links a:hover {
            background: white;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transform: translateY(-2px);
        }

        .nav-links a.active {
            background: var(--primary-color);
            color: white;
        }

        .form-container {
            padding: 40px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-color);
            font-size: 1rem;
        }

        .input-field {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid var(--border-color);
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: var(--light-gray);
        }

        .input-field:focus {
            outline: none;
            border-color: var(--primary-color);
            background: white;
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
        }

        textarea.input-field {
            resize: vertical;
            min-height: 140px;
            font-family: inherit;
        }

        .submit-btn {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 16px 32px;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .submit-btn:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(67, 97, 238, 0.3);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        .character-count {
            text-align: right;
            font-size: 0.9rem;
            color: #6c757d;
            margin-top: 5px;
        }

        .optional {
            color: #6c757d;
            font-weight: normal;
        }

        @media (max-width: 768px) {
            .container {
                margin: 10px;
            }

            .form-container {
                padding: 30px 20px;
            }

            .nav-links {
                flex-direction: column;
                gap: 10px;
            }

            .nav-links a {
                text-align: center;
            }
        }

        .flash-message {
            background: var(--success-color);
            color: white;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            display: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📝 Student Feedback Portal</h1>
            <p>Share your thoughts to help us improve</p>
        </div>

        <div class="navigation">
            <div class="nav-links">
                <a href="index.jsp" class="active">Submit Feedback</a>
                <a href="view.jsp">View Feedback</a>
            </div>
        </div>

        <div class="form-container">
            <div id="flashMessage" class="flash-message">
                Feedback submitted successfully!
            </div>

            <form action="submit.jsp" method="post" id="feedbackForm">
                <div class="form-group">
                    <label for="course">
                        Course <span class="optional">(optional)</span>
                    </label>
                    <input
                        type="text"
                        id="course"
                        name="course"
                        class="input-field"
                        placeholder="e.g., Computer Science 101"
                    >
                </div>

                <div class="form-group">
                    <label for="message">Your Feedback</label>
                    <textarea
                        id="message"
                        name="message"
                        class="input-field"
                        placeholder="Share your thoughts, suggestions, or concerns..."
                        required
                    ></textarea>
                    <div class="character-count">
                        <span id="charCount">0</span> characters
                    </div>
                </div>

                <button type="submit" class="submit-btn">
                    Submit Feedback 🚀
                </button>
            </form>
        </div>
    </div>

    <script>
        // Character count for textarea
        const messageTextarea = document.getElementById('message');
        const charCount = document.getElementById('charCount');

        messageTextarea.addEventListener('input', function() {
            charCount.textContent = this.value.length;
        });

        // Form submission handling
        document.getElementById('feedbackForm').addEventListener('submit', function(e) {
            const message = document.getElementById('message').value.trim();
            if (!message) {
                e.preventDefault();
                alert('Please enter your feedback before submitting.');
                return;
            }

            // You can add additional validation here
            if (message.length < 10) {
                e.preventDefault();
                alert('Please provide more detailed feedback (at least 10 characters).');
                return;
            }
        });

        // Show flash message if parameter exists in URL
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('success') === 'true') {
            const flashMessage = document.getElementById('flashMessage');
            flashMessage.style.display = 'block';
            setTimeout(() => {
                flashMessage.style.display = 'none';
            }, 5000);
        }
    </script>
</body>
</html>