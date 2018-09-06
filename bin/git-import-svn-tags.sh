# When using git-svn to manipulate a svn repo
# through git tool, the SVN tags are not automatically
# imported as GIT tags, instead, the svn tagas are
# initially git remote branches
#
# This functions tranforms those svn tags in actual
# git tags

if [ "x$1" = "x--do-it" ]; then
    DO_IT=1
fi

git for-each-ref --format="%(refname:short) %(objectname)" refs/remotes/tags | while read BRANCH REF; do
    TAG_NAME=${BRANCH#*/}
    BODY="$(git log -1 --format=%s $REF)"
    #echo "ref=[$REF] parent=[$(git rev-parse $REF^)] tagname=[$TAG_NAME] branch=[$BRANCH]" >&2

    echo "git tag -a -m \"$BODY\" $TAG_NAME $REF^"
    echo "git branch -r -d $BRANCH"
    if [ ! -z $DO_IT ]; then
        git tag -a -m "$BODY" $TAG_NAME $REF^
        git branch -r -d $BRANCH
    fi
done

if [ -z $DO_IT ]; then
    echo ##################################
    echo Only showing what to do!
    echo To actually do that run: $0 --do-it
    echo ##################################
fi

