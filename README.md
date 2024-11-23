# How to use:

!!WARNING!! Cyrillic (and maby other) script DOESN`T WORK IN OLD WINDOWS CONSOLE, use new terminal instead 

**Remember: as more text you give as input, as good result you will get**

You can simply run .exe file and write text without other options:
![Снимок экрана 2024-09-06 220651](https://github.com/user-attachments/assets/844333c8-cb03-443e-8380-d99dc514f350)

Or you can use app arguments:
![Снимок экрана 2024-09-06 220849](https://github.com/user-attachments/assets/0dd16585-7236-4819-942c-1530834134c4)

As more text you give as input, as more realistic result will be (source.txt is 182kb size): 
![изображение](https://github.com/user-attachments/assets/f9e1484d-925a-4fdd-9000-3e4c2523ff00)

## Arguments 

WordGenerator has this console arguments:<br>
source={file with extension}- read text from file.<br>
### tg={number} - generate x tokens (tokens != symbols)<br>
### ts={number} - set token size to x symbols (tg=100 ts=2 will generate 200 symbols)<br>
Small token size often create new words:<br>
![изображение](https://github.com/user-attachments/assets/1a173bfb-0b67-4bb9-ab12-bd5951cb9953)
Greater token size copies part of text:<br>
![изображение](https://github.com/user-attachments/assets/b8f9a94e-977a-48cc-a5a1-4418da46c534)<br>
### tn={number} - set next tokens size to x tokens (less values gives repeating values like abrbrbrbbrbrbrbrbrbrbr...)<br>
### tr={number 0..100} - set the chance of random next token (0 - no random, 99 - all random)<br>
### fr={number} - generate text and use it again x times (uses generated text as input)
