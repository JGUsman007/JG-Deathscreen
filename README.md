# JG-Deathscreen


   ```JG Deathscreen```
   
   It is a simple death screen with respawn selector and nui
   
   
   ```INSTALLATION```

Rename the folder to JG-Deathscreen
And place it in you resource and put 
ensure JG-Deathscreen in the server.cfg

## ESX_Ambulance

So this resource was made for esx so you will have to remove some functions
from esx_ambulancejob
1. Got to esx_ambulance/client/main.lua
And comment these functions
<p align="center">
  <img width="612" height="240" src="https://cdn.discordapp.com/attachments/985595018800681000/1078701681245683822/reviveesxambulance.PNG">
</p>

2. Got to esx_ambulance/client/main.lua
And comment these functions
<p align="center">
  <img width="612" height="240" src="https://cdn.discordapp.com/attachments/985595018800681000/1078702371921723454/12.PNG">
</p>

3.And for revive and reviveall command
Go to esx_ambulancejob/server/main.lua
and add this event
```args.playerId.triggerEvent('JG-Deathscreen:revive')```
and
```TriggerClientEvent('JG-Deathscreen:revive', -1)```
in this commands
<p align="center">
  <img width="612" height="240" src="https://cdn.discordapp.com/attachments/985595018800681000/1078704253390032956/commadns.PNG">
</p>
