HOW TO BUILD THE MOD

Before you unzip and build the mod, make sure you fulfill these steps:
1) download and install Github Desktop https://desktop.github.com/, get an account.

2) go to your radish tools directory, open repo.quests -> world.repo.yml 
There, find this:

    hubtest:
      id: 14
      world: dlc/dlchubtest/levels/hubtest/hubtest.w2w
      level: levels/hubtest/

Right below it, insert these lines:

    riviacapital:
      id: 13
      world: dlc/dlcriviacapital/levels/riviacapital/riviacapital.w2w
      level: levels/riviacapital/

Right now we are using hub id 13 (testing id). Later, upon release of the mod we shall switch to a public id. I strongly advice you to read 
carefully all the comments there before trying to tweak anything else.

3) make a copy of `_settings_.bat-template` and rename it to `_settings_.bat`, then adjust the paths within it. Do not delete the file you copied.

4) make a copy of `w3.riviacapital.sublime-project.template`, and rename it to `w3.riviacapital.sublime-project`.

5) generate links via `_createLinks_.bat`.

6) build the mod.

From now on, use Github Desktop in order to commit any changes you want to apply.