# PSO2NGS Mod Manager 
 An app to manage and apply mod files to Phantasy Star Online 2 New Genesis  
 
![Screenshot 2023-02-09 202346](https://user-images.githubusercontent.com/101075148/218000260-af778197-8d57-4b68-ae6b-08043cc995cc.png)

# Download

[Release page](https://github.com/KizKizz/pso2_mod_manager/releases)  
Check back for latest releases

# Features

- Organize, keep track of available and applied mods
- Add, remove single/multiple items or mods
- Apply entire mod, or single .ice file
- Mod sets, save mods into sets to apply later 
- Backup originals from the game, restore when unapplying mods
- Auto apply checksum and reapply mods if they are being unapply after game update
- Preview mods by hovering mouse cursor on them, and right click to zoom on an image (if there are images [.jpg, .png] or videos [.mp4, .webm] included inside the mod)
- Search (literally any keyword, even .ice file), favorites list

and more..

# Usage
**Note:**  
- Restore the game files to their originals before using the app
- App's settings (light\dark mode, pso2_bin path, ect) are stored in:  
  ```C:\Users\YourUserName\AppData\Roaming\PSO2NGS Mod Manager\shared_preferences.json```
- Mod files settings are stored in:  
  ```...\PSO2 Mod Manager\PSO2ModManSettings.json```
- If the app started as a blank white screen, resizing it would fix this issue.
- If the app wont start or crashing on start:

  ```Right click on PSO2NGSModManager.exe > Properties > Compatibility tab > Check the box under Compatibility mode > Apply```
  
  ![Screenshot 2023-06-10 193951](https://github.com/KizKizz/pso2_mod_manager/assets/101075148/d2dcbbdd-3136-4379-a19c-fe691435fec3)


**First time setup:**

- Locate pso2_bin folder

   ![Screenshot 2022-06-26 143014](https://user-images.githubusercontent.com/101075148/175836232-f62b8484-c4a5-4815-a7b0-66d54b8f6332.png)
   ![Screenshot 2022-06-26 143139-crop](https://user-images.githubusercontent.com/101075148/175836300-1d3462b6-57e1-4418-b2ab-12bf66f7bcd8.png)

- Click to auto download checksum, or hold to manually select 

   ![Screenshot 2022-06-26 143206-crop](https://user-images.githubusercontent.com/101075148/175836423-3b2b0ed6-b6b1-401c-9b71-2c7cb911db82.png)

**Adding mods:**

**Note**: 
- Supporting .zip files, folders, .ice files, drag and drop to add
- Mods can also be added by copying your mod folders into each category folder in ```...\PSO2 Mod Manager\Mods``` then refresh or restart the app

[addmods.webm](https://github.com/KizKizz/pso2_mod_manager/assets/101075148/16846f2e-f631-4323-8358-4dfb0b4635c6)


**Applying - unapplying mod(s):**

https://github.com/KizKizz/pso2_mod_manager/assets/101075148/5b5ffe32-3699-4033-901d-aeccdff65818
   
**Add Mods to Sets:**

[addsets.webm](https://github.com/KizKizz/pso2_mod_manager/assets/101075148/3d49c2c1-452e-4779-802b-f07cd6061d11)


# Known Issues
Drag & drop won't work if app is running with Administrator

# Plans
More improvements  

# Built With

Flutter and various libraries from [pub.dev](https://pub.dev/packages)

[Zamboni](https://github.com/Shadowth117/Zamboni) and [DDStronk](https://github.com/scorpdx/ddstronk)

Found a bug? [Leave a message here](https://github.com/KizKizz/pso2_mod_manager/issues)

Made by キス★ (KizKizz)  
<sup>I'm not taking any responsibility if your game files messed up</sup>
