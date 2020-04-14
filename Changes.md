# Changes
### Start - Gamemode
- Getting maps is now done through build in `Map variables` rather than `Objective Position`.
- Control Points are evaluated trough `Objective Index`.
- Control Points are alphabetically ordered now.
### Start - Player
- Kills the player instead of teleporting him to `PosStart`, leaving `Respawn` rule to do the rest.
### Finish
- Leaderboard updates rewritten.
- `NewBest` check reworked.
### Finish (New Best)
- rewritten to work with new `Finish` rule.
### Finish (New Record)
- rewritten to work with new `Finish` rule.
### Practice Mode (enabled)
- removed all unnessary actions.
### Practice Mode (disabled - Button held)
- removed all unnessary actions.
- Kills the player to let `Respawn` reset him, rather than doing it itself.
### Player spectator mode (enabled)
- removed all unnessary actions.
### Player spectator mode (disabled - Button held)
- removed all unnessary actions.
### Spectator mode (enabled)
- removed all unnessary actions.
### Spectator mode (disabled - Button held)
- removed all unnessary actions.
- Kills the player to let `Respawn` reset him, rather than doing it itself.
### Circle Fix
- Tranfered some actions from `Respawn` to `Circle Fix`.
- Now only triggers when the players speed is under or equal his walking speed.
### Disable Prehop
- Removed due to `Circle Fix` changes.
### No Damage
- Removed due to `Phased out` fixes and `receive headshots only` activation.
### Lobby settings
- Now allows player who are in queue.
- Lucio specific settings tranfered to all Heros.
- Specator count increased to 12.
- `turn to lobby` set to `never`.
- `Receive headshots only` enabled.
