# Connect4 for Sonic Pi and TouchOSC

## Requirements

Sonic Pi (v3.0.1 or later supporting OSC calls),
TouchOSC ( preferrably desktop version) running on the same computer as Sonic Pi

clone or download the repository into a suitable position eg your Documents Folder
## Setup

1. Load Connect4b.tosc file from your downloads into TouchOSC
2. Set connection 1 on the connections menu to UDP, Host: localhost,
   Send Port: 4560 Receive Port 9000, Zeroconf: Default
3. Click the Run button
4. Startup Sonic Pi and load the program connect4b.rb file into an empty buffer
5. Adjust the path to the program windefs.rb in line 3 to match your installation
6. Make sure that incoming OSC calls are enabled in the Preferences IO tab

## Operation

1.  Press the Run button on Sonic Pi
2.  You can bring the TouchOSC screen to the front, and if you wish,
    hide the Sonic Pi Screen
3.  The screen should look like the image below

<placeholder start>

4.  Player 1 adjusts the postion of the "dropper" disk by using the left and right arrowsheads
5.  When you have selected the postion you wish, press the Drop yellow square
6.  The disk drops down to the bottom vacant postion in the selected column
7.  The dropper disk at the top changes colour and player 2 selects the postion
    for the next dropper
8.  The game continues until one player achieves four disks in a row.
    These can be either horizontal, vertical or diagonal
9.  The Sonic Pi program detects a win condition and indicates who has one.
10. The winning disk is flashed several times to indicate where the winning line is.
11. After a pause a button appears which you can push to start a new game.
12. The starting player colour is chosen at random between red and green.
13. At any time (including before it starts) you can cancel the current game and start another.

<placeholder redwin>

<placehoder greenwin>

<placeholder draw>
Note the Sonic Pi prgoram is in two parts, so that the main program can be displayed 
in a single buffer. The supporeting program windefs.rb contains a series of logical 
conditions which enable a winning state to be ascertained. This program is run using 
the run_fiole command to set up the required definitions before the main program starts.

The program does NOT supply an automatic component, although it would be feasible to
write one at athe expense of a much more involved program.
