If you are having trouble, you should try to follow the suggested 3 state solution very closely:

search right to find the first unbalanced close parenthesis, mark it as matched, then go to state 2. If you reach a blank cell, go to state 3.
search left to find the matching open paren, mark it as matched then return to state 1.
search left to ensure there are no unmatched parentheses. If an unmatched parenthesis is found, the TM should write a 0 on the tape and halt. If the blank cell at the left end of the tape is reached, the TM should write a 1 on the tape and halt.
To help you get started, I'll help you work through state 1.

First of all, you should note that you are specifying the movement of the tape, not the head, in your action statements. So if you need to search to the right, that means that you want to move your tape to the left.

The statement for state 1 says that if you are in state 1 you should be moving to the right as long as you don't see a ")" or "-". This is achieved by moving your tape to the left for actions that remain in state s1 and writing out the same symbol that you just read back onto the tape in order to leave it unchanged.

This is achieved with action statements of the form:

action s1 X s1 X l
where X is any valid symbol that is not ")" or "-".

If you see a ")", you should replace it with a symbol that means matched (e.g., M) and then go to state 2. Since state 2 wants to search to the left, you would want to move your tape to the right in order to be in the correct position as you begin state 2.

Together these 2 requirements translate into the following action statement:

 action s1 ) s2  M r
The instructions for state 1 also say that if you are in state 1 and you see a '-' that you should go to state 3. This would be achieved with:

action s1 - s3  - r
Hopefully, this helps you get a sense for how you should tackle the remaining states behavior for this lab.