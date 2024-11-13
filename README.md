# How to use:

**Remember: as more text you give as input, as good result you will get**

You can simply run .exe file and write text without other options:
![Снимок экрана 2024-09-06 220651](https://github.com/user-attachments/assets/844333c8-cb03-443e-8380-d99dc514f350)

Or you can use app arguments:
![Снимок экрана 2024-09-06 220849](https://github.com/user-attachments/assets/0dd16585-7236-4819-942c-1530834134c4)

## Arguments 

WordGenerator has this console arguments:<br>
source={file with extension}- read text from file. You can`t use other arguments without this one.<br>
tg={number} - generate x tokens (tokens != symbols)<br>
ts={number} - set token size to x symbols (tg=100 ts=2 will generate 200 symbols. Less values makes strange result, but too big values just copy parts of text)<br>
tn={number} - set next tokens size to x tokens (less values gives repeating values like abrbrbrbbrbrbrbrbrbrbr...)<br>
tr={number 0..100} - set the chance of random next token (0 - no random, 99 - all random)<br>
fr={number} - generate text and use it again x times (uses generated text as input)
