<!DOCTYPE html>
<html lang="en">
    <!-- <head>...</head> included in header.php -->
    <?php include "header.php" ?>
    
    <body>
        <!-- common navigation bar -->
        <?php include "navbar.php" ?>
        
        <!-- include scripts -->
        <?php include "../src/scripts.php" ?>
        
        <!-- unique content -->
        <div class="content">
            <h1>Landmarks Study</h1>
            <p>
            Welcome to the Landmarks Study. Thank you in advance for your interest and time.
            </p>
                    
            <div class="instructions">
                <h2>Instructions</h2>
                <ol>
                    <li>Read the lesson below.</li>
                    <li>Answer the questions.</li>
                    <li>(Optional) Pat yourself on the back for participating in this study -- Thank you from the Landmarks Team.</li>
                </ol>
            </div>
         
            <?php
                // gets config info from database
                loadConfig();
                if (REPARSE_LESSON) {
                    reparseLesson();
                }
                
                // if participant will be assigned to the control group, display without landmarks
                if (isControlGroup()) {
                    // control group gets the lesson without Landmarks
                    include PATH_CONTROL_VERSION;
                } else {
                    include PATH_LANDMARK_VERSION;
                }
                
                // quiz
                include "quiz.php"
            ?>
        </div>
        
        <!-- common footer -->
        <?php include "footer.php" ?>
    </body>
    
</html>