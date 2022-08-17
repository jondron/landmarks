<!DOCTYPE html>
<html lang="en">
    <!-- <head>...</head> included in header.php -->
    <?php include "header.php" ?>
    
    <body>
        <div id="quiz">    
            <h1>Quiz</h1>
            <p>Please answer the questions below.</p>
            <form action="result.php" method="post" id="quiz">
                <ol>
                    <li>
                        <h3>Blue starts with the letter...</h3>
                        <div>
                            <input type="radio" name="Q1Answers" id="Q1A" value="A" />
                            <label for="Q1A">A) A </label>
                        </div>
                        
                        <div>
                            <input type="radio" name="Q1Answers" id="Q1B" value="B" />
                            <label for="Q1B">B) B</label>
                        </div>
                        
                        <div>
                            <input type="radio" name="Q1Answers" id="Q1C" value="C" />
                            <label for="Q1C">C) C</label>
                        </div>
                        
                        <div>
                            <input type="radio" name="Q1Answers" id="Q1D" value="D" />
                            <label for="Q1D">D) D</label>
                        </div>
                    </li>
                </ol>
                <input type="submit" value="Submit">
            </form>
        </div>
        <br><br><br><br>
    </body>
</html>