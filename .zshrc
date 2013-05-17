
#####################################################
# オプションの設定
# man zshoptions
#####################################################

# cd のとき自動でpushd
setopt autopushd
# ディレクトリ名だけで移動
setopt auto_cd
# ディレクトリスタックへの+/-の意味を逆転
setopt pushd_minus
# 引数なしのpushd は pushd $HOME
setopt pushd_to_home

# グロブの拡張
setopt extendedglob
# 補完のあいまいさがあっても完全一致があれば、確定
#setopt rec_exact
# ドットファイルにマッチさせるとき、明示的 "." がいらない
setopt glob_dots
# ディレクトリのスラッシュ補完はしない
setopt no_autoparamslash
# マッチしないときに出力しない
setopt no_nomatch
# コマンドの訂正を試みる
setopt correct
# カーソル位置を考えての補完
setopt completeinword

# ジョブリストをデフォルトでロングフォーマット
setopt long_list_jobs
# '(シングルクォート)内でシングルをつなげて' を表現できる
# 例) '''' シングルセット内のシングル
setopt rc_quotes
# プロンプト表示で自動で改行はいれない
setopt no_promptcr

# バックグラウンドジョブ状態の即時報告
setopt notify

# PROMPT で変数などの評価ができるようにする
setopt prompt_subst

# ヒストリの共有
setopt share_history
# ヒストリイベントが最大になったら重複削除
setopt hist_expire_dups_first
# シェルの終了時、ヒストリの追加書き込み
setopt appendhistory


# ヒストリの検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
# reverse menu completion to Shift-Tab
# Note: "autoload zkbd"
bindkey "^[[Z" reverse-menu-complete

# emacs key
bindkey -e

# auto created
zstyle :compinstall filename '/home/katsumata/.zshrc'

# 補完に色をつける
eval `dircolors -b`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# 補完候補を矢印キーで選択
zstyle ':completion:*:default' menu select=1


###################################################
# モジュールの読み込み
###################################################

# すごい補完をやる
autoload -Uz compinit; compinit

# 色情報の読み込み
autoload -Uz colors; colors

# add-zsh-hook を使えるようにする
autoload -Uz add-zsh-hook

# vcs の読み込みができるように
autoload -Uz vcs_info

###################################################
# バージョン管理システム用の表示
###################################################

# とりあえず git のみ
zstyle ':vcs_info:*' enable git
# [git - master] のように管理システムを表示するときは上
# zstyle ':vcs_info:*' formats "%{${fg[green]}%}[%b]%{${reset_color}%} " 
zstyle ':vcs_info:*' formats "%{${fg[cyan]}%}[%b]%{${reset_color}%} "
# コンフリクトとか起きたときのフォーマット
zstyle ':vcs_info:*' actionformats "%{${fg[cyan]}%}[%b|%a]%{${reset_color}%} "
_precmd_vcs_info () {
    LANG=en_US.UTF-8 vcs_info
    vcs_info
}
add-zsh-hook precmd _precmd_vcs_info


###################################################

# use ctrl+q to command stack
stty start undef

# load math functions
zmodload zsh/mathfunc

###################################################
# エイリアス
###################################################
alias bc='bc -l'
alias nautilus.='nautilus .'
alias less='less -X'
alias ls="ls --color=auto"
alias ll="ls -l --color=auto"
alias la="ls -al --color=auto"
alias l="ls -l --color=auto"

# xsel (about clipboard command)
if test -f $HOME/install/bin/xsel ; then
    alias -g C=" | xsel -bi" #stdout => clip
    alias -g C2=" | tee >(xsel -bi)" #stdout => clip + stdout
fi

###################################################
# 表示
###################################################
MACHINE="%m"
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && MACHINE="%{${fg[magenta]}%}${MACHINE}%{${reset_color}%}"
PROMPT=\${vcs_info_msg_0_}"%n@${MACHINE}:%{${fg[green]}%}%~%{${reset_color}%}> "
PROMPT2="> "
SPROMPT="zsh: correct '%R' to '%r' [(N)o, (Y)es, (A)bort, (E)dit]? "
unset MACHINE

