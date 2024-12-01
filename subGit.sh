#!/bin/bash
# MAUVADAO
# VER: 1.0.0


git add -A
git status
git commit -m 'Update: $(date +%d%m%y_%H )'
git push
