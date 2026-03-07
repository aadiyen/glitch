# Cyberpunk 2D Pixel Game – Third Project
# Overview

This is my third game project, a fast-paced cyberpunk-style 2D pixel game developed using the Godot Engine.

Unlike my previous hyper-casual games, this project is more complex and includes level design, enemy AI, and a more polished gameplay loop. I enjoyed the entire process of creating this game, starting from the initial prototype to the final playable version.

# Development Process

After completing the game prototype, I began implementing the main gameplay mechanics. However, I quickly realized that the code I had written earlier was becoming messy and difficult to read.

Instead of continuing with poorly structured code, I decided to rewrite the gameplay systems from scratch. Although this slowed development at first, it made the code cleaner, easier to manage, and easier to expand later in development.

# What I Learned From This Project
1. Enemy Types

# Chasing Enemy (Experimental)
Initially, I implemented an enemy that chased the player using a global script. However, because the game is level-based, enemies that chased the player across the entire level made the gameplay unfair. Because of this, I decided not to include this enemy type in the final version.

# Patrolling Enemy
I implemented patrol enemies that move within a specific area and do not leave their assigned zone. This is a common enemy behavior used in many platformer games.

2. Finite State Machine (FSM)

The most complex system I implemented was a Finite State Machine (FSM) for enemy behavior.

This system allows enemies to:

Stay idle

Patrol their area

Detect the player when nearby

Return to normal behavior when the player leaves

I first studied FSM concepts through YouTube tutorials and game development forums. After understanding the concept, I decided to implement my own FSM system.

Initially, I faced issues related to the scene tree structure, but after debugging and experimenting for about one week, I successfully implemented the system.

3. Level Design

Level design was completely new for me in this project. I experimented by placing enemies repeatedly and testing the gameplay to understand enemy placement and level flow.

This iterative process helped me understand how level design affects gameplay difficulty and pacing.

Problems I Faced and How I Solved Them
State Machine Bug

While developing the FSM system, I encountered a bug where the state machine continued trying to access the enemy even after the enemy had died. This sometimes broke the game.

Solution:
I implemented a function that stops the state machine when the enemy dies, preventing it from referencing a destroyed object.

Enemy Position Fluctuation

Another bug occurred when the player jumped above an enemy. The enemy’s position began fluctuating because the player detection collision shape was circular, which confused the AI detection.

Solution:
I changed the detection shape to a rectangle, which improved the AI behavior and made it more stable.

Node Structure Problems

While implementing the FSM system, I realized how important proper node naming and scene structure is.

Some enemy states were not triggering because the node names were incorrect, which caused the system to fail.

This issue helped me understand the importance of organized scene hierarchy and clear node naming.

Level Design Challenges

In my previous projects, I struggled with level design. For this game, I decided to focus on building a proper level-based gameplay experience.

To improve the levels, I asked my brothers and friends to playtest the game and provide feedback. Their feedback helped me improve enemy placement and level flow.

After several iterations, I was able to create a decent and enjoyable level design.


## Conclusion

This project helped me understand several important aspects of game development such as enemy AI, finite state machines, level design, and debugging gameplay systems.

It was a challenging but rewarding experience, and it helped me improve my coding structure and problem-solving skills.

I plan to continue improving my game development skills and build more complex projects in the future.

