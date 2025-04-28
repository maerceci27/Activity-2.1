<?php
include 'db.php';

$username = $_POST['username'];
$password = $_POST['password'];

$stmt = $conn->prepare("SELECT id, password FROM User WHERE username = ?");
$stmt->bind_param("s", $username);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows > 0) {
    $stmt->bind_result($user_id, $hashed_password);
    $stmt->fetch();

    // Check failed attempts in the last 5 minutes
    $checkAttempts = $conn->prepare("
        SELECT COUNT(*) 
        FROM log_in_attempts 
        WHERE user_id = ? AND attempt = 'failed' 
        AND attempt_time > (NOW() - INTERVAL 5 MINUTE)
    ");
    $checkAttempts->bind_param("i", $user_id);
    $checkAttempts->execute();
    $checkAttempts->bind_result($failed_count);
    $checkAttempts->fetch();
    $checkAttempts->close();

    if ($failed_count >= 5) {
        echo "locked"; // Special message handled by JS
    } elseif (password_verify($password, $hashed_password)) {
        $log = $conn->prepare("INSERT INTO log_in_attempts (user_id, attempt) VALUES (?, 'successful')");
        $log->bind_param("i", $user_id);
        $log->execute();
        echo "success";
    } else {
        $log = $conn->prepare("INSERT INTO log_in_attempts (user_id, attempt) VALUES (?, 'failed')");
        $log->bind_param("i", $user_id);
        $log->execute();
        echo "invalid";
    }
} else {
    echo "invalid";
}

$stmt->close();
$conn->close();
?>
