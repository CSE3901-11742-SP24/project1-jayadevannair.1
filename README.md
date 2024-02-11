# The Game Of Sets

Welcome to The Game of Sets, a challenging and engaging card game that tests your ability to identify patterns and sets among cards with various symbols. This game is implemented in Ruby, making it easy to run on any system with Ruby installed.

## Getting Started

### Prerequisites

Before you can run The Game of Sets, you'll need to have Ruby installed on your computer. If you don't have Ruby installed, you can download and install it from the official Ruby website:

- [Ruby Installation Guide](https://www.ruby-lang.org/en/documentation/installation/)

This game has been tested with Ruby version 3.1 and above. Please ensure your Ruby version meets this requirement.

### Installation

1. **Clone the Repository**

First, clone the repository to your local machine using Git:

`git clone https://github.com/CSE3901-11742-SP24/project1-jayadevannair.1.git
cd game-of-sets`

2. **Install Dependencies**

The Game of Sets uses Bundler to manage its dependencies. Install Bundler (if you haven't already) and then install the required gems:

`gem install bundler
bundle install`

## Running the Game

Once the installation is complete, you're ready to run the game:

`bundle exec rake run`

This command starts the game. Follow the on-screen instructions to play.

## How to Play

- The game will present you with a grid of cards, each with unique attributes such as shape, color, and number.
- Your task is to identify a 'set' of three cards where each feature, when looked at individually, is either all the same on each card or all different.
- The game offers options to add more cards to the play area, enter a set manually, or get a hint for a set.

Enjoy the game, and may the best pattern recognizer win!