# BubblePop Game - iOS SwiftUI

## Introduction

BubblePop is a iOS game built using SwiftUI, where players must pop randomly displayed bubbles to earn points within a set timeframe selected by the player. The game includes various bubble colours, each corresponding to different point values and probabilities. The goal is to pop as many bubbles as possible and achieve the highest score within the allotted time.

## Features
### Core Functionality:
1. **Player Name Input**: Players can enter their name before the game starts.
2. **Game Timer**: A countdown timer starts at 60 seconds, counting down to 0. The game time can be adjusted in the settings.
3. **Max Bubbles**: Players can adjust the maximum number of bubbles generated during the game in the settings.
4. **Score Display**: The score is updated as bubbles are popped.
5. **Bubble Generation**: Bubbles of different colors (Red, Pink, Green, Blue, Black) are displayed randomly with different probabilities.
6. **Bubble Popping**: When a bubble is tapped, it disappears and adds the corresponding points to the player's score. Consecutive bubbles of the same color provide bonus points.
7. **Bubble Refreshing**: The bubbles refresh every second during gameplay, with new bubbles appearing at random positions.
8. **High Score Storage**: The player's highest score is saved, and a leaderboard is displayed after the game ends.

### Extended Functionality:
1. **Flashing Countdown**: The game starts with a countdown of "3", "2", "1", flashing before gameplay begins.
2. **Bubble Animations**: Bubbles shrink/grow when popped or generated.
3. **Score Overlay**: When a bubble is tapped, an overlay shows the points gained in response to the tap.
4. **High Score Display**: The highest score is shown on the main screen during gameplay.
