# Cyberpunk 2D Pixel Game

<img width="550" height="297" alt="game dev portfolio" src="https://github.com/user-attachments/assets/bd8fd9d9-c465-427d-b3e7-ffdb01def31e" />



## Overview

Cyberpunk 2D Pixel Game is a fast-paced platformer developed using the Godot Engine. This was my third game project and my first attempt at building a more complex game featuring enemy AI, level design, and structured gameplay systems.

Unlike my previous hyper-casual projects, this game required more advanced programming and design decisions. Throughout development, I focused on creating maintainable code, implementing AI systems, and designing engaging levels.

---

## Technologies Used

* Godot Engine
* GDScript
* Finite State Machine (FSM) Architecture
* TileMap-Based Level Design

---

## Key Features

* Cyberpunk-themed pixel art environment
* Multiple enemy behaviors
* Finite State Machine (FSM) AI system
* Player detection and enemy response system
* Level-based gameplay
* Enemy patrol mechanics
* Debugged and optimized gameplay systems

---

## Enemy AI Systems


### Chasing Enemy (Experimental)

Initially, I implemented an enemy that could chase the player using a global script.

During testing, I realized that because the game is level-based, allowing enemies to chase the player across large sections of the level made gameplay feel unfair and frustrating.

As a result, I decided not to include this enemy type in the final version.

### Patrolling Enemy

The final game uses patrol enemies that move within predefined areas and remain inside their assigned zones.

This behavior creates more predictable gameplay and allows for better level design and player planning.

---

## Finite State Machine (FSM)

One of the most important systems I implemented was a Finite State Machine (FSM) for enemy behavior.

The FSM allows enemies to:

* Stay idle
* Patrol their assigned area
* Detect the player
* Switch to an alert state
* Return to normal behavior when the player leaves detection range

I learned the fundamentals of FSM architecture through game development resources and then implemented my own version within Godot.

During development, I encountered several scene-tree-related issues and spent approximately one week debugging and refining the system before achieving a stable implementation.

---

## Level Design

This project was my first serious attempt at level design.

To improve gameplay flow, I repeatedly tested levels, adjusted enemy placement, and experimented with different layouts.

I also asked friends and family members to playtest the game and provide feedback. Their suggestions helped improve level pacing, difficulty balance, and enemy placement.

Through this iterative process, I gained a better understanding of how level design influences player experience.

---

## Challenges and Solutions

### FSM Referencing Destroyed Enemies

**Problem:**
After an enemy died, the FSM occasionally continued trying to access that enemy, causing errors and unstable behavior.

**Solution:**
Implemented a function that disables the state machine when an enemy is destroyed, preventing invalid references.

---

### Enemy Position Fluctuation

**Problem:**
When the player jumped above an enemy, the enemy's position occasionally fluctuated because the circular detection area produced inconsistent detection behavior.

**Solution:**
Replaced the circular detection shape with a rectangular detection zone, resulting in more stable AI behavior.

---

### Scene Tree and Node Structure Issues

**Problem:**
Certain enemy states failed to activate because of incorrect node names and scene hierarchy configuration.

**Solution:**
Reorganized the scene structure and standardized node naming conventions, which improved reliability and debugging efficiency.

---

### Level Design Challenges

**Problem:**
Creating engaging levels was difficult because I had limited prior experience with level design.

**Solution:**
Used repeated playtesting and external feedback to refine enemy placement, level flow, and gameplay pacing.

---

## What I Learned

This project significantly improved my understanding of:

* Enemy AI design
* Finite State Machines (FSM)
* Scene tree organization
* Debugging gameplay systems
* Level design fundamentals
* Code maintainability and refactoring
* Playtesting and iteration

One of the most valuable lessons from this project was learning when to rewrite systems instead of continuing with poorly structured code. Although rebuilding parts of the project initially slowed development, it resulted in cleaner and more maintainable code.

---

## Project Outcome

This project was both challenging and rewarding. It strengthened my programming, debugging, and game design skills while giving me hands-on experience with AI systems and structured gameplay architecture.

It remains one of the projects that contributed most to my growth as a game developer.

---


## Play the Game

https://adiyen.itch.io/glitch
