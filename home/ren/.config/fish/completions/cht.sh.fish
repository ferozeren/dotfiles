# cht.sh tab completion for fish shell

complete -c cht.sh -a "(curl -s https://cht.sh/:list | awk '{print $1}')" -d "Cheatsheet topics"
