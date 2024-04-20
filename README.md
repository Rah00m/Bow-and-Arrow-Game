## Design Choices and Implementation Explanation

### Class Hierarchy
The program is structured using object-oriented principles, with multiple classes representing different game elements and functionalities. Here's an overview of the class hierarchy:

1. *Main Sketch Functions:*
   - setup(): Initializes the game environment, loads assets, sets initial variables, and initializes levels.
   - draw(): Controls the game loop, including updating and rendering game elements.

2. *Level Classes:*
   - Level1 and Level2: Represent different levels of the game.
     - Each level manages its setup, draw, and game logic independently.
     - Manages the game state, including win/lose conditions and transitioning between levels.

3. *Game Elements:*
   - Arrow: Represents the player's projectile.
   - Balloon1, RedCircle, and YellowCircle: Represent different types of balloons or circles in the game.
     - Balloons/circles have different behaviors and appearances.

### Design Choices
1. *Separate Level Classes:*
   - Each level is encapsulated within its class to manage its unique features independently.
   - Allows for easier maintenance and extensibility, enabling the addition of more levels in the future.

2. *Game Element Classes:*
   - Different classes represent distinct game elements such as arrows and balloons/circles.
   - Encapsulation ensures modular and reusable code, simplifying debugging and expansion.

3. *State Management:*
   - Flags and variables control various game states like reloading, dragging, firing, and game over.
   - Clear separation of concerns facilitates clear code organization and logic flow.

4. *Audio Integration:*
   - Utilizes the Minim library for sound effects, enhancing the gaming experience.
   - Sounds are triggered based on specific game events like shooting, winning, and losing.

### Challenges and Considerations
1. *Collision Detection:*
   - Implementing accurate collision detection between arrows and balloons/circles requires precise calculations.
   - Efficient algorithms are essential to handle collisions effectively, especially with multiple moving objects.

2. *State Management Complexity:*
   - Managing various game states and transitions between levels requires careful coordination.
   - Ensuring proper synchronization of state changes and user interactions to avoid unexpected behavior.

3. *Performance Optimization:*
   - Balancing graphical richness with performance optimization is crucial for smooth gameplay.
   - Efficient rendering and updating of game elements are necessary, especially with potentially large numbers of balloons/circles and arrows.

4. *Asset Management:*
   - Handling asset loading, including images and sounds, efficiently to minimize memory usage and load times.
   - Choosing appropriate asset formats and compression techniques to optimize file size without sacrificing quality.

Overall, by carefully designing the class hierarchy, managing game states effectively, and addressing potential challenges, the implementation aims to deliver an engaging and enjoyable gaming experience for players.
