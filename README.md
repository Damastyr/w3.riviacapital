# How to build the mod

Before you unzip and build the mod, make sure you fulfill these steps:
1) Download and install Github Desktop https://desktop.github.com/. Use GitHub Desktop to download the Rivia project to your PC.

2) It's necessary to make adjustments to the Radish Tools directory (your folder with Radish exe files). Look inside repo.quests folder and open theworld.repo.yml
Inside theworld.repo.yml you will find this:

```yaml
    hubtest:
      id: 14
      world: dlc/dlchubtest/levels/hubtest/hubtest.w2w
      level: levels/hubtest/
```
Right below it, insert these lines:
```yaml
    riviacapital:
      id: 13
      world: dlc/dlcriviacapital/levels/riviacapital/riviacapital.w2w
      level: levels/riviacapital/
```
Right now we are using hub id 13 (testing id). Later, upon release of the mod we shall switch to a public id. I strongly advice you to read
carefully all the comments there before trying to tweak anything else.

Additionally you will need to uncook some extra vanilla meshes to help Radish encode shadow meshes. Shadow meshes are simplified geometry for large objects to keep drawing their shadows over long distances. Open the repo.shadowmeshes folder and follow the instructions listed in the readme file. The uncook.meshes.bat will uncook some 10GB of static meshes and then patch them into a "shadow mesh form". If you have an error or crash be sure to check wcc.log inside your Modkit directory. It's worth noting, some Radish projects linked inside r4data can cause this to fail. It may required to temporarily empty your linked Radish folders.

3) Make a copy of `_settings_.bat-template` and rename it to `_settings_.bat`, then adjust the paths within it. Do NOT delete the -template file from the project, this ensures the template file will not be deleted from the main repository if you make a commit. The _settings_.bat will be ignored by GitHub desktop, so your personal paths won't be added to the main project.

4) Make a copy of `w3.riviacapital.sublime-project.template`, and rename it to `w3.riviacapital.sublime-project`. Again, do not delete the template file.

5) Generate links via `_createLinks_.bat`.

6) Build the mod. Use the command "gotorc()" (no quotes) with the debug console to teleport to Rivia.

From now on, use Github Desktop in order to commit any changes you want to apply.
