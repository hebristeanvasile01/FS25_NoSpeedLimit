# 🚜 No Speed Limit - Full Power (FS25)

Removes the `speedLimit` from every vehicle and implement in Farming Simulator 25, and gives engines extra torque so heavy tools no longer slow you down.

## ✨ Features
- 🏁 No speed limit on any tractor, trailer, tool or implement, whatever mod it comes from
- 💪 Full power: engine torque is multiplied (x3 by default), so heavy loads don't drag the speed down
- ⚙️ Works automatically, no key or menu needed
- 🌐 Multiplayer supported
- 🔧 Adjustable: change `NoSpeedLimit.TORQUE_MULTIPLIER` at the top of `scripts/NoSpeedLimit.lua` (1.0 = vanilla power)

## 📦 Installation
1. Download `FS25_NoSpeedLimit.zip` from the Releases page.
2. Put the zip (not unzipped) in your mods folder: `Documents/My Games/FarmingSimulator2025/mods`.
3. Enable **No Speed Limit - Full Power** when starting a savegame.

## 🔍 Check it works
In `log.txt` look for:
`FS25_NoSpeedLimit: full power active (x3.0 torque)`

## ⚠️ Notes
- Top speed is still the vehicle's own maximum; only the speedLimit and the load slowdown are removed.
- With this much pull, wheels can spin on soft ground. Lower the multiplier if needed.

## 👤 Author
FS Modding
