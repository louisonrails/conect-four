# Connect Four — Ruby TDD Challenge

A terminal-based implementation of the classic **Connect Four** game, built in Ruby using **Test-Driven Development (TDD)** principles.

This project is part of **The Odin Project** Ruby curriculum and focuses on writing clean, well-tested code while following best practices in object-oriented design.

---

## 📌 Features

- Fully playable **Connect Four** game in the terminal
- Game logic developed using **RSpec** and TDD
- Win detection:
  - Vertical
  - Horizontal
  - Diagonal
- Clean separation of game logic and display
- Readable and maintainable Ruby code

---

## 🛠️ Built With

- **Ruby**
- **RSpec**
- **Bundler**

---

## 🚀 Getting Started

### Prerequisites

Make sure you have the following installed:

- Ruby (recommended: latest stable version)
- Bundler

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/connect-four.git
   cd connect-four
    ```

2. Install dependencies:
    ```bash
    bundle install
    ```

### Running the Tests

- To run the full test suite:
    ```bash
    rspec
    ```
- To run a specific file:
    ```bash
    rspec spec/board_spec.rb
    ```

All game logic was developed using TDD, so tests are the primary source of truth.

### Playing the Game

- Run the game in your terminal:
    ```bash
    ruby lib/main.rb
    ```

Follow the on-screen instructions to drop discs and play against another player.

### Learning Goals

- Practice Test-Driven Development
- Improve understanding of RSpec
- Apply Object-Oriented Programming in Ruby
- Write expressive, readable, and testable code
