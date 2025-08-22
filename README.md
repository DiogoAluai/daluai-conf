# daluai-conf
Diogo Aluai's (me!) configuration is the repository which aggregates my custom scripts and config files, intended for Linux.
Simply run `full_instal.sh` to set up the machine with these.

### Scripts and aliases
These are have been accumulated throughout the years, so older ones may be... inconsistent.
Some of my most used are:
- `o            # alias to xdg-open, which opens with default app`
- `build_script # create a script using a template, and make it executable`
- `wifi         # convenience visualization and selection of network`
- `enter        # get shell of running docker container`

### .bashrc
The configuration appends aliases to `~/.bash_aliases` and environment variables to `~/.bash_envs`. The `~/.bashrc` files is also adapted to source from these two.

### Nano editor config
The nano dotconfig alters keybindings and the visual aspect. 
Editor colors differ for normal user and root, so that it grabs your atention on possibly critical edits. There is `ctrl+c` and `ctrl+v`, however `ctrl+k` remains as cut so that `ctrl+x` is reserved to exit the editor!
Example, running custom script `build_script some_script.sh` will present you with the nano editor with a template ready to go:

<p align="center">
  <img width="459" height="387" alt="image" src="https://github.com/user-attachments/assets/a4ab602e-3970-409f-b5a8-2108970af604" />
</p>
