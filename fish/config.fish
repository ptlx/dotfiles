set fish_greeting
fish_vi_key_bindings

alias l "ls"
alias v "nvim"

function fish_user_key_bindings
	bind -M insert \cc kill-whole-line repaint
	bind -M insert -m default jk 'commandline -f repaint'
	bind -M insert \cf accept-autosuggestion
end

bind \cd 'exit'
