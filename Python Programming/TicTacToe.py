# -*- coding: utf-8 -*-
"""
Tic Tac Toe Game
By: Thomas Gow
"""
'''
This was my coding skills at Python at beginning of the IAA program.

*** Will redo at the end of the year to see the improvement of my coding skills,
specifically adding functions to make my code way more efficient.***
'''


from beautifultable import BeautifulTable


# =============================================================================
# Below is the Tic Toe Game Setup
# The while loop runs until there is a tie
# or if player one or two wins
# Good luck!!!
# Note you have to run the i=0 and win=False before starting
# =============================================================================

i=0
win=False
#Game Loop
while (i<=9 or win==True or win=='tie') :
    if i==0:
        table = BeautifulTable()
        table.append_row(['A1', 'A2', 'A3'])
        table.append_row(['B1', 'B2', 'B3'])
        table.append_row(['C1', 'C2', 'C3'])
    if i==9:
        print("It's a tie!")
        break
    if i % 2 == 0:
         print(table)
         pick_one=input('Player 1: Type your chosen spot and then click enter. ').upper()
         if pick_one == 'A1' :  
             if table[0][0] != 'O' and table[0][0] != 'X':
                 table[0][0]='X'
                 i=i+1
                 if table[0][0]=='X' and table[0][1]=='X' and table[0][2]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 elif table[0][0]=='X' and table[1][1]=='X' and table[2][2]=='X':
                     print(table)
                     print('Player 1 Wins!')  
                     win=True
                     break
                 elif table[0][0]=='X' and table[1][0]=='X' and table[2][0]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 elif table[0][0]=='X' and table[1][0]=='X' and table[2][0]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 else: 
                     continue  
             elif table[0][0] == 'O' or table[0][0] == 'X':
                 print('Already Chosen. Pick Again')
                 i=i
             else:
                 print('Broken- Retry- Error when checking Player1 Wins')
             
         elif pick_one == 'A2' :
             if table[0][1] != 'O' and table[0][1] != 'X':
                 table[0][1]='X'
                 i=i+1
                 if table[0][0]=='X' and table[0][1]=='X' and table[0][2]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 elif table[0][1]=='X' and table[1][1]=='X' and table[2][1]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 else: 
                     continue
             elif table[0][1] == 'O' or table[0][1] == 'X':
                 print('Already Chosen. Pick Again')
                 i=i
             else:
                 print('Broken- Retry- Error when checking Player1 Wins')
         elif pick_one == 'A3' :
             if table[0][2] != 'O' and table[0][2] != 'X':
                 table[0][2]='X'
                 i=i+1
                 if table[0][0]=='X' and table[0][1]=='X' and table[0][2]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 elif table[0][2]=='X' and table[1][2]=='X' and table[2][2]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 elif table[2][0]=='X' and table[1][1]=='X' and table[0][2]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 else: 
                     continue
             elif table[0][2] == 'O' or table[0][2] == 'X': 
                 print('Already Chosen. Pick Again')
                 i=i
             else:
                 print('Broken- Retry- Error when checking Player1 Wins')
         elif pick_one == 'B1' :
             if table[1][0] != 'O' and table[1][0] != 'X':
                 table[1][0]='X'
                 i=i+1
                 if table[0][0]=='X' and table[1][0]=='X' and table[2][0]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 elif table[1][0]=='X' and table[1][1]=='X' and table[1][2]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 else: 
                     continue
             elif table[1][0] == 'O' or table[1][0] == 'X':
                 print('Already Chosen. Pick Again')
                 i=i
             else:
                 print('Broken- Retry- Error when checking Player1 Wins')
         elif pick_one== 'B2' :
             if table[1][1] != 'O' and table[1][1] != 'X':
                 table[1][1]='X'
                 i=i+1
                 if table[0][0]=='X' and table[1][1]=='X' and table[2][2]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 elif table[0][1]=='X' and table[1][1]=='X' and table[2][1]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 elif table[0][2]=='X' and table[1][1]=='X' and table[2][0]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                 elif table[1][0]=='X' and table[1][1]=='X' and table[1][2]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 else: 
                     continue
             elif table[1][1] == 'O' or table[1][1] == 'X':
                 print('Already Chosen. Pick Again')
                 i=i
             else:
                 print('Broken- Retry- Error when checking Player1 Wins')
         elif pick_one== 'B3' :
             if table[1][2] != 'O' and table[1][2] != 'X': 
                 table[1][2]='X'
                 i=i+1
                 if table[1][0]=='X' and table[1][1]=='X' and table[1][2]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 elif table[0][2]=='X' and table[1][2]=='X' and table[2][2]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 else: 
                     continue 
             elif table[1][2] == 'O' or table[1][2] == 'X':
                 print('Already Chosen. Pick Again')
                 i=i
             else:
                 print('Broken- Retry- Error when checking Player1 Wins')
         elif pick_one== 'C1' :
             if table[2][0] != 'O' and table[2][0] != 'X':
                 table[2][0]='X' 
                 i=i+1
                 if table[2][0]=='X' and table[2][1]=='X' and table[2][2]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 elif table[2][0]=='X' and table[1][1]=='X' and table[0][2]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 elif table[2][0]=='X' and table[1][0]=='X' and table[0][0]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 else: 
                     continue 
             elif table[2][0] == 'O' or table[2][0] == 'X':
                 print('Already Chosen. Pick Again')
                 i=i
             else:
                 print('Broken- Retry- Error when checking Player1 Wins')
         elif pick_one== 'C2' :
             if table[2][1] != 'O' and table[2][1] != 'X':
                 table[2][1]='X'
                 i=i+1
                 if table[2][1]=='X' and table[1][1]=='X' and table[0][1]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 elif table[2][0]=='X' and table[2][1]=='X' and table[2][2]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 else: 
                     continue
             elif table[2][1] == 'O' or table[2][1] == 'X':
                 print('Already Chosen. Pick Again')
                 i=i
             else:
                 print('Broken- Retry- Error when checking Player 1 Wins')
         elif pick_one== 'C3' :
             if table[2][2] != 'O' and table[2][2] != 'X':
                 table[2][2]='X'
                 i=i+1
                 if table[0][0]=='X' and table[1][1]=='X' and table[2][2]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 elif table[2][0]=='X' and table[2][1]=='X' and table[2][2]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 elif table[0][2]=='X' and table[1][2]=='X' and table[2][2]=='X':
                     print(table)
                     print('Player 1 Wins!')
                     win=True
                     break
                 else: 
                     continue
             elif table[2][2] == 'O' or table[2][2] == 'X':
                 print('Already Chosen. Pick Again')
                 i=i
             else:
                 print('Broken- Retry- Error when checking Player1 Wins')
         else:
             print('Try Again')
             i=i
    elif i % 2 == 1:
         print(table)
         pick_one=input('Player 2: Type your chosen spot and then click enter. ').upper()
         if pick_one == 'A1' :
             if table[0][0] != 'X' and table[0][0] != 'O':
                 table[0][0]='O'
                 i=i+1
                 if table[0][0]=='O' and table[0][1]=='O' and table[0][2]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 elif table[0][0]=='O' and table[1][1]=='O' and table[2][2]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 elif table[0][0]=='O' and table[1][0]=='O' and table[2][0]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 else: 
                     continue 
             elif table[0][0] == 'X' or table[0][0] == 'O':
                 print('Already Chosen. Pick Again')
                 i=i
             else:
                 print('Broken- Retry- Error when checking Player 2 Wins')
             
         elif pick_one == 'A2' :
             if table[0][1] != 'X' and table[0][1] != 'O':
                 table[0][1]='O'
                 i=i+1
                 if table[0][0]=='O' and table[0][1]=='O' and table[0][2]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 elif table[0][1]=='O' and table[1][1]=='O' and table[2][1]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 else: 
                     continue
             elif table[0][1] == 'X' or table[0][1] == 'O':
                 print('Already Chosen. Pick Again')
                 i=i
             else:
                 print('Broken- Retry- Error when checking Player 2 Wins')
         elif pick_one== 'A3' :
             if table[0][2] != 'X' and table[0][2] != 'O':
                 table[0][2]='O'
                 i=i+1
                 if table[0][0]=='O' and table[0][1]=='O' and table[0][2]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 elif table[0][2]=='O' and table[1][2]=='O' and table[2][2]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 elif table[2][0]=='O' and table[1][1]=='O' and table[0][2]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 else: 
                     continue
             elif table[0][2] == 'O' or table[0][2] == 'X':
                 print('Already Chosen. Pick Again')
                 i=i
             else:
                 print('Broken- Retry- Error when checking Player 2 Wins')
         elif pick_one== 'B1' :
             if table[1][0] != 'X' and table[1][0] != 'O': 
                 table[1][0]='O'
                 i=i+1
                 if table[0][0]=='O' and table[1][0]=='O' and table[2][0]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 elif table[1][0]=='O' and table[1][1]=='O' and table[1][2]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 else: 
                     continue
             elif table[1][0] == 'O' or table[1][0] == 'X':
                 print('Already Chosen. Pick Again')
                 i=i
             else:
                 print('Broken- Retry- Error when checking Player 2 Wins')
         elif pick_one== 'B2' :
             if table[1][1] != 'X' and table[1][1] != 'O':
                 table[1][1]='O'
                 i=i+1
                 if table[0][0]=='O' and table[1][1]=='O' and table[2][2]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 elif table[0][1]=='O' and table[1][1]=='O' and table[2][1]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 elif table[0][2]=='O' and table[1][1]=='O' and table[2][0]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 elif table[1][0]=='O' and table[1][1]=='O' and table[1][2]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 else: 
                     continue
             elif table[1][1] == 'O' or table[1][1] == 'X':
                 print('Already Chosen. Pick Again')
                 i=i
             else:
                 print('Broken- Retry- Error when checking Player 2 Wins')
         elif pick_one== 'B3' :
             if table[1][2] != 'X' and table[1][2] != 'O':
                 table[1][2]='O'
                 i=i+1
                 if table[1][0]=='O' and table[1][1]=='O' and table[1][2]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 elif table[0][2]=='O' and table[1][2]=='O' and table[2][2]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 else: 
                     continue 
             elif table[1][2] == 'O' or table[1][2] == 'X':
                 print('Already Chosen. Pick Again')
                 i=i
             else:
                 print('Broken- Retry- Error when checking Player 2 Wins')
         elif pick_one== 'C1' :
             if table[2][0] != 'X' and table[2][0] != 'O':
                 table[2][0]='O'
                 i=i+1
                 if table[2][0]=='O' and table[2][1]=='O' and table[2][2]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 elif table[2][0]=='O' and table[1][1]=='O' and table[0][2]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 elif table[2][0]=='O' and table[1][0]=='O' and table[0][0]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 else: 
                     continue
             elif table[2][0] == 'O' or table[2][0] == 'X':
                 print('Already Chosen. Pick Again')
                 i=i
             else:
                 print('Broken- Retry- Error when checking Player 2 Wins')
         elif pick_one== 'C2' :
             if table[2][1] != 'X' and table[2][1] != 'O':
                 table[2][1]='O'
                 i=i+1
                 if table[2][1]=='O' and table[1][1]=='O' and table[0][1]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 elif table[2][0]=='O' and table[2][1]=='O' and table[2][2]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 else: 
                     continue
             elif table[2][1] == 'O' or table[2][1] == 'X':
                 print('Already Chosen. Pick Again')
                 i=i
             else:
                 print('Broken- Retry- Error when checking Player 2 Wins')
         elif pick_one== 'C3' :
             if table[2][2] != 'X' and table[2][2] != 'O':
                 table[2][2]='O'
                 i=i+1
                 if table[0][0]=='O' and table[1][1]=='O' and table[2][2]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 elif table[2][0]=='O' and table[2][1]=='O' and table[2][2]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 elif table[0][2]=='O' and table[1][2]=='O' and table[2][2]=='O':
                     print(table)
                     print('Player 2 Wins!')
                     win=True
                     break
                 else: 
                     continue
             elif table[2][2] == 'O' or table[2][2] == 'X':
                 print('Already Chosen. Pick Again')
                 i=i
             else:
                 print('Broken- Retry- Error when checking Player 2 Wins')
         else:
             print('Try Again')
             i=i



    
    
    
    