# Cyberpunk 2D Pixel Game – Third Project
# Overview

This is my third game project, a fast-paced cyberpunk-style 2D pixel game. Unlike my previous hypercasual games, this one is more complex, featuring level design, enemy AI, and a polished gameplay loop. I loved the process of creating this game from prototypes to the final version.

# How it went
so after i was done with the game prototype i decided to start building the game and build game mechanics but something went wrong, i saw that my game codes i was using earlier are kind of messy and becoming unreadable so i decided to took some more time and write the game codes again from the scratch, initially it was hard but after that the game progress was increased.

# What I learned frome this game project?
since this game is fast paced cyberpunk style game so i have learned and build many game mechanics for the game like-
1 I have made the kind of enemies who chases player throughout the game by using global script but the game was level based and the enemies chasing the player throughout the level is kind of unfair so i didn't added that enemies on the game.
2 I have coded a patroling type enemies who patrol in a particular part of the game and won't go outside from there, these are the basic type enemies and are in many games too like mario.
3 The most complex code for the game was finite state machine, basically i have seen in many games that the enemies are smart and react when the player is near the enemy and get to it's normal position when the player is not around.First I have watched some youtube tutorials and read some gameengine forum to learn how it works then decided to code my own finite state machine. Initially it was hard to do cuz faced some problem with scene tree but i have took some time and coded this mechanic for my game in one week.
4 Level design was also a new thing to me since I haven't done this before but so i started designing test the game by placing the enemies again and again. This part was really fun.

# Problems I faced and how I solved them
# state machine bug
so while making the game i faced various bugs like in finite state machine the state machine keeps looking for the enemy when it dies which breaks the whole game , the bug was very annoying cuz it triggers sometimes that even i didn't noticed it. so when i figured out why it is happening i just made a function which stops the state machine when the ememy dies

