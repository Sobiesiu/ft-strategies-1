#!/bin/zsh

# script to install additional packages for the strategies in this repo

# I find this useful in that I normally have to do this if I upgrade something fundamental like python or anaconda.
# Also, I sometimes get in a mess with package dependencies and have to reset
# Either of these requires me to do a full install of freqtrade (sh setup.sh -r), and then re-install these packages

# Notes:
# - if you need conda versions of packages, you'll need to install those from within the freqtrade venv
# - at the current time, conda packages for the M1 Mac are a mess of conflicting version requirements, so beware
# - the neural network-based strategies require either keras & tensorflow, or darts & pytorch

# function to get y/n answer. Pass the prompt as arg
prompt_user () {
  result=0

  read -rq "yn?${1} (y/n) " # zsh-specific

  if [ "$yn" = 'y' ]; then
    result=1
  else
    result=0
  fi
  echo $result # stupid zsh doesn't really have a return
}

# install generally used packages
pkg_general=("finta" "prettytable" "PyWavelets" "simdkalman" "pykalman" "scipy" "scikit-learn")

if [[ $(prompt_user "Install general packages?: ") -eq 1 ]]; then
  echo ""
  for pkg in $pkg_general; do
    pip install $pkg
  done
fi
echo ""

# install packages for keres/tensorflow-based strategies

if [[ $(prompt_user "Install keras/rensorflow packages?: ") -eq 1 ]]; then
  echo ""
  conda install -c apple tensorflow-deps
  pip install tensorflow-macos
  pip install tensorflow-metal
  conda install -c conda-forge -y pandas jupyter
  pip install keras
fi
echo ""

# install packages for darts/pytorch-based strategies

if [[ $(prompt_user "Install darts/pytorch packages?: ") -eq 1 ]]; then
  echo ""
  conda install pytorch torchvision -c pytorch
  pip install darts
fi
echo ""
