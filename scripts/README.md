### Autostaking script

1. Download the raw file of the script:
```
wget https://raw.githubusercontent.com/DenisDiachenko/cosmos/main/scripts/autostake.sh
```
2. Give the permissions to this script:
```
chmod +x autostake.sh
```
3. Open the script and edit the variables accroding your testned, validator address, fees, etc.:
```
nano autostake.sh
```
4. Install the `Screen` tool:
```
sudo apt install screen
```
5. Attach script to `screen` in order to run it on the background:
```
screen -S autostake
```
6. Run script to automatically claiming and delegating rewards:
```
bash autostake.sh
```
7. Run `cmd + A + D` to exit from `screen`
