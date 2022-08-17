# Change Log

All notable changes to this web application will be documented in this file.

File will be cleared upon public release.

## TODO
- rework code to use updated database schema
- create quiz functionality (parse GIFT file for questions/answers)
- create quiz results table in DB plus update function
- create treatments with patterns (not just colours)
- admin - basic functionality
- admin - security/user/password

## Jon TODO
- provide lesson + quiz
- provide site content, e.g., participant welcome/instructions and news
- Research server options and requirements, e.g., versions for PHP/MariaDB/Apache/etc.

## DONE
- Jon updated the database schema
- save lesson control and landmark versions as HTML
- update database config table (reparse_lesson)
- add functionality to only reparse lesson if required (check reparse_lesson flag in config table)
- create quiz functionality (hard coded)
- convert PHP config to database lookup (config file now just has DB info)
- switch to using array with treatment info, e.g., tag, treatment type, if treatment is unique
- create database
- create addLandmarks
- create generateTreatment - https://www.php.net/manual/en/book.imagick.php
    -use hash to seed random
- create generateHash - https://www.php.net/manual/en/function.hash.php
- create Git repo (GitHub) and .gitignore
- create isControlGroup
- create loadConfig (includes the config php file)
- parse HTML to DOMDocument and display control version
- update licence to CC BY-NC 4.0
- website skeleton (PHP/CSS)
- email Jon request for Lesson/Quiz and website content (e.g., news, study intro, etc.) plus versions required for PHP/MariaDB/Apache/etc.

## 1.0.1 - yyyy-mm-dd
Description of changes.

## 1.0.0 - yyyy-mm-dd
First stable release.