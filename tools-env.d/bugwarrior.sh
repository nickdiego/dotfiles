#!/bin/bash

_bugwarrior_virtualenv() {
    #assumes python2-virtualenv is installed
    virtualenv2 ~/.apps/bugwarrior
    source ~/.apps/bugwarrior/bin/activate
}

_bugwarrior_install() {
    _bugwarrior_virtualenv && \
        pip install bugwarrior jira keyring
}

bugwarrior-pull() {
    ~/.apps/bugwarrior/bin/bugwarrior-pull
}

bugwarrior-vault() {
    ~/.apps/bugwarrior/bin/bugwarrior-vault
}

