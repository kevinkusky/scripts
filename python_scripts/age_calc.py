"""Terminal App to calculate age"""

print('Welcome to the age calculator')
a = input('Would you like to know how old you will be in a particular year? ')

year = input('What year were you born? ')
future = input('What year did you want to know about? ')

age = future - year

print('in the year ', future, ' you will be ', age, ' years old. ')
print('Goodbye, Grandpa!')
