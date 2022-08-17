<!DOCTYPE html>
<html lang="en">
    <!-- <head>...</head> included in header.php -->
    <?php include "header.php" ?>
    <body>
        <div id="quiz">
            <h1>Results</h1>
                <?php            
                    $answer1 = $_POST['Q1Answers'];
                    $totalCorrect = 0;
                    if ($answer1 == "B") { $totalCorrect++; }
                    echo "<div id='results'>$totalCorrect / 1 correct</div>";
                ?>
        </div>
        <br><br>
        <p>Thank you for participating in the Landmark Study.</p>
    </body>
</html>