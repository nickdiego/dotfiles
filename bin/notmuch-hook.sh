#!/bin/sh

notmuch new
# retag all "new" messages "inbox" and "unread"
notmuch tag +inbox +unread -new -- tag:new
# tag all messages from "me" as sent and remove tags inbox and unread
notmuch tag -new -inbox +sent -- from:me@example.org or from:nickdiego@igalia.com

## tag newsletters, but dont show them in inbox ## Example?
#notmuch tag +newsletters +unread -new -- from:newsletter@example.org or subject:'newsletter*'

