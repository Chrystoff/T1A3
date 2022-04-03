README!
---

[Source Control Repository Link](https://github.com/Chrystoff/T1A3)

---
### Style guide/conventions of app

Indentations are 2 spaces. Kept a maximum line length where I could.
No trailing whitespace.

Most conventions are just what makes sense. Rubocop helped with parts
I wasn't familiar with like keeping a blank line under 'raise' expressions.

---

### Develop a list of features. describe each feature.

- Feature 1: Interactive Menu

    A menu that you can interact with and get to every element of the app. I used a 'while loop' that a 'case' method utilised for control flow. My hash variables(and other minor variables) are called throughout every menu option. also restricted menu options to what's available.
- Feature 2: Adding Scores

    A Score feature that adds the input values into a hash for short term storage. Choices are restricted with error handling. handled with a case method that keeps you there without a loop by calling the method if it tries to leave improperly and error handling.
- Feature 3: Saving Scores
  
  A system to save the current best score to a file under your name and the course name. no retreival. Simple open and close file system. Some minor graphic design for readability within the file. A cheap attempt at making profiles and courses by letting you input it when you save.
- Feature 4: High Score system
  
  Keeps track of the lowest score that gets added into the input. Per session.
  merges hashes and finds the best score.


[Trello link](https://trello.com/b/kXYdHK1u/terminal-app)


describe help documentation
#### Installation: 

unzip and place folder somewhere on computer. navigate with your preferred command line tool, open file with 'ruby golf_stat.rb'

### Dependencies:

Ruby

### System/Hardware

- Processor: 1.2GHz processor
- Memory: 512 MB RAM

### Using the App

It's pretty simple, but there are 3 lists, one for par of the default(and only) course. You can add the score of your last played round of golf and then save it to a file.
If you add multiple games/rounds. save between adding, because otherwise in it's current state it will just be overwriting your scores with the new input(except the high score which will keep just taking the lowest value).
You can then feel free to view the last games and your current high score for that hole.
Again in it's current state it's not recorded unless you save it, and the app can't fetch that data yet().