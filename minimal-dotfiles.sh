#!/bin/bash

sed -i 's/archive.ubuntu.com/mirror.sg.gs/g' /etc/apt/sources.list.d/ubuntu.sources
apt-get update
apt-get install -y htop zsh tmux wget curl git vim
mkdir ~/.zsh

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
chsh -s $(which zsh) $USER
zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
echo 'source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.zshrc

mv ~/.fzf.zsh .zsh/.fzf.zsh
sed -i 's,.fzf.zsh,.zsh/.fzf.zsh,g' ~/.zshrc

curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

$HOME/.local/bin/zoxide init zsh >> ~/.zsh/.zoxide.zsh
echo '[[ ! -f ~/.zsh/.zoxide.zsh ]] || source ~/.zsh/.zoxide.zsh' >> ~/.zshrc
source ~/.zshrc

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc

wget --output-document=/tmp/ripgrep.deb https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
apt-get install /tmp/ripgrep.deb


# needs to be last
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting


cat << EOF >> .zshrc 
export EDITOR=vim
HISTFILE=~/.zsh/.history
HISTSIZE=500
SAVEHIST=100000
setopt SHARE_HISTORY

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

EOF 


cat <<< 'set nocompatible
filetype off
set encoding=UTF-8
set t_Co=256
set laststatus=2
syntax on
set backspace=indent,eol,start  " more powerful backspacing

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("\'\"") > 0 && line("\'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Allow saving of files as sudo when I forget to start vim using sudo.
cmap w\!! w \!sudo tee > /dev/null %

" mouse support
set mouse=a

" Tabs/Indentation
filetype indent on
filetype plugin indent on

" " New Implementation
augroup tab_config
    autocmd!
    autocmd FileType * setlocal expandtab tabstop=4 shiftwidth=4
    autocmd FileType html,css,javascript,dart setlocal expandtab tabstop=2 shiftwidth=2
augroup end
set shell=zsh
set number

" case insensitive search
set ignorecase

" autopread in case file was changed outside vim
set autoread

" Search
set incsearch
set hlsearch
' > ~/.vimrc

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


cat << EOF > .tmux.conf
bind C-r command-prompt "rename-window '%%'"
bind C-t new-window -c "#{pane_current_path}"
bind -n M-j previous-window
bind -n M-k next-window
set -g -a terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'
set-window-option -g mode-keys vi
set -g history-limit 100000
set -g mouse on
######################
### DESIGN CHANGES ###
######################

# loud or quiet?
set-option -g visual-activity on
#set-option -g visual-bell off
#set-option -g visual-silence off
set-window-option -g monitor-activity on
#set-option -g bell-action none

# Status position
#set-option -g status-position top

# Status update interval
set-option -g status-interval 5

# Basic status bar colors
#set-option -g status-bg darkpurple
#set-option -g status-fg white

# Left side of status bar
#set-option -g status-left-length 40
#set-option -g status-left "#[fg=brightwhite,bg=brightblack] #S #[fg=darkpurple,bg=default] "
#
## Window status
#set-option -g window-status-format "#[fg=white,bg=brightblack] #I #[fg=white,bg=black] #W "
#set-option -g window-status-current-format "#[fg=brightwhite,bg=darkgreen] #I #[fg=brightwhite,bg=magenta] #W "
#set-option -g window-status-separator " "
#set-option -g status-justify left
#
## Right side of status bar
#set-option -g status-right-length 40
#set-option -g status-right " #[fg=brightwhite,bg=brightblack] %a, %d %b %H:%M #[fg=brightwhite,bg=brightblack] #(whoami)@#h "

# Pane number indicator
set-option -g display-panes-colour brightblack
set-option -g display-panes-active-colour brightwhite

# Clock mode
set-option -g clock-mode-colour white
set-option -g clock-mode-style 24

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'



set -g @plugin 'dracula/tmux'
set -g @dracula-show-powerline true
set -g @dracula-show-left-icon shortname
# available plugins: battery, cpu-usage, git, gpu-usage, ram-usage, tmux-ram-usage, network, network-bandwidth, network-ping, ssh-session, attached-clients, network-vpn, weather, time, mpc, spotify-tui, playerctl, kubernetes-context, synchronize-panes
set -g @dracula-plugins "attached-clients cpu-usage ram-usage time battery"
set -g @dracula-show-empty-plugins false

# for left
#set -g @dracula-show-left-sep |

# for right symbol (can set any symbol you like as separator)
#set -g @dracula-show-right-sep |
# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
set -g @dracula-show-flags true
# the default is 5, it can accept any number
set -g @dracula-refresh-rate 5
run '~/.tmux/plugins/tpm/tpm'

EOF

