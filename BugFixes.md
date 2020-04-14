# Bug Fixes
### Floor - double deaths
- Players no longer die twice when hitting the ground.
- This was an occasional bug, caused by `resurrect` being executed before `teleport`.
- Fixed by removing `is alive` check from `Floor` rule.
### Ult reset - double deaths
- Can no longer trigger twice.
- This was an occasional bug caused by `resurrect` being executed before `teleport`.
- Fixed by removing `is alive` check from `Ult Reset` rule.
### Ult reset - works in spawn
- Can no longer reset players who are in the spawn circle.
- This bug was caused by an incorrect distance comparison betwenn `PosStart` and `Position of Event Player`.
- Fixed by only comparing in 2D space (setting y coordinates equal to each other).
### Checkpoint Icon getting deleted
- (season 3 exclusive bug) Checkpoint Icons don't get deleted at the start of the game now.
- This bug was caused by an incorrect `Delete Last created Entity` action in `Fire Status (disabled)` rule which gets triggered at the start of the game.
- Fixed by removing incorrect `Delete Last created Entity` action.
### Hud sort order
- Hud is now sorted correctly.
- This bug was caused by two `Hud Text` having the same sort number.
- Fixed by changing sort numbers.
### Lobby reset
- Game no longer gets send back to lobby after long periods of time.
- This bug was likely caused by `Game Time` being frozen.
- Fixed by looping `Game Time` when close to 0.
### Phased out
- Players now corretly recive `Phased out` Status.
- This bug was caused due to not clearing `Phased out` status first before setting it again.
- Fixed by clearing status before setting it again.
### Punching
- Players can no longer be punched.
- This bug was caused due to missing `Phased out` status.
- Fixed by fixing `Phased out` and by setting `receive headhsots only` to true.
### Mode leaving
- Players can no longer keep momentum when leaving `Practice` and `Spectator` mode.
- This bug was caused by the player keeping momentun after a teleport.
- Fixed by killing the player, so `Respawn` rule takes the momentun away.
### Checkpoint trigger
- Checkpoints can no longer be triggered multiple times.
- This bug was caused due to `Checkpoint` rule not checking if `player var Checkpoint` is already true.
