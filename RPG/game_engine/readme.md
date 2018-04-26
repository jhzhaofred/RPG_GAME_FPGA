Feel free to download the game engine and test bench with and without accuracy included, or the HP_module and its testbench, which was integrated into the game engine modules.

With accuracy, the game becomes more challenging for the players (punch 90%, kick 80%, bat 70%, and sword 60%).

The bat can be used three times, while the sword can be used two times, but punch and kick can be used infinitely.

This module only allows the players to battle when a collision detection occurs.

On the rising edge of a collision detection, the player's HP reset to 100, and the enemy's HP is reset to value between 50 and 100.  Also, the power points (PP) of the sword and bat will be reset.  In the future, an input will be used to detect if a level-up has occurred, which brings the player's HP up to 150, while another input will be used to detect if the opponent is a boss, which will also bring the opponent's HP up to 150.

$random% is used for the accuracy, enemy's HP, and for adjusting the strength of an attack by as much as 20% of its average value.

Punch = 8-12 HP lost

Kick = 16-24 HP lost

Bat = 24-36 HP lost

Sword = 32-48 HP lost

The HP module and its testbench can show you how much HP is taken away from the player or enemy if an attack lands.
