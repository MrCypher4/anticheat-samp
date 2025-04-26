# AntiCheat & Filterscripts Collection

Welcome to the **AntiCheat & Filterscripts Collection** repository!

This project is a complete set of **advanced AntiCheat systems** and **utility Filterscripts** designed specifically for **San Andreas Multiplayer (SA-MP)** servers.  
Whether you are running a **small private server** or a **large public server**, these scripts aim to provide **solid protection**, **efficient management tools**, and **a better player experience** without sacrificing server performance.

Every line of code is written with **efficiency, stability, and modularity** in mind, making it easy to implement, expand, and maintain.

---

## Table of Contents

- [Features](#features)
- [Project Goals](#project-goals)
- [Technical Overview](#technical-overview)
- [Installation Guide](#installation-guide)
- [Dependencies](#dependencies)
- [Repository Structure](#repository-structure)
- [How to Contribute](#how-to-contribute)
- [Roadmap](#roadmap)
- [Credits](#credits)
- [License](#license)

---

## Features

### AntiCheat System
- **Teleport Hack Detection**  
  Detects and flags sudden, unrealistic player position changes.
  
- **Weapon Hack Detection**  
  Detects unauthorized weapon grants or invalid weapon use.

- **Health & Armor Hack Detection**  
  Blocks and logs illegal health or armor modifications beyond normal gameplay.

- **Money Hack Detection**  
  Monitors and reacts to illegal money increases.

- **Fly Hack Detection**  
  Identifies unnatural movements, flying without a vehicle or permissions.

- **Speed Hack Detection**  
  Detects movement speeds far beyond allowed vehicle or player capabilities.

- **Rapid Fire Detection**  
  Detects abnormal firing rates, auto-shoot scripts, or weapon modifications.

- **Crash Exploit Protection**  
  Prevents known SA-MP crash exploits and stops malformed packet attacks.

- **Logging System**  
  All suspicious activities are automatically logged into server files for further analysis.

- **Immediate Action**  
  Depending on configuration: Kick, Ban, or Only Log without disrupting gameplay.

---

### Utility Filterscripts
- **Admin Command Tools**
  - Kick, Ban, Freeze, Slap, Spectate Players
  - View detailed player info (ping, IP, status)

- **Vehicle Management Tools**
  - Repair, flip, respawn vehicles
  - Vehicle ownership basic system

- **Server Enhancement Scripts**
  - Display server uptime, online player count
  - Beautiful Welcome Messages for new players
  - Player help commands and instructions system

- **Chat Protection System**
  - Anti-Spam: Detects and blocks chat flooding
  - Anti-Advertising: Block common ad spam attempts

- **Notification and Event System**
  - Customizable pop-up notifications
  - Real-time admin alerts on important server events

---

## Project Goals

- **Secure:** Provide strong, reliable protection against most common cheats and exploits.
- **Efficient:** Maintain lightweight scripts that do not degrade server performance.
- **Scalable:** Easy to expand or customize for larger servers and different server types (Roleplay, Freeroam, Stunt, TDM, etc.).
- **Educational:** Serve as a clean codebase reference for beginner and intermediate PAWN developers.
- **Open-source:** Allow free use, modification, and contributions from the community.

---

## Technical Overview

- **Language:** PAWN
- **Script Type:** Filterscripts (modular) and AntiCheat core system
- **Compatibility:**  
  - Fully compatible with **SA-MP 0.3.7-R2** and above.
  - Designed to work with standard plugins for extended functionality.
- **Performance:**  
  - Optimized event handlers
  - Minimal use of heavy loops
  - Smart timers and caching where necessary

---

## Installation Guide

### Step-by-Step Installation:

1. **Clone or Download** the repository:
   ```bash
   git clone https://github.com/MrCypher4/anticheat-samp.git
   ```bash
   For installation instructions, please see the tutorial on YouTube vatiera
