#BOF

EMACS_CLEAN_FIND   := find * -name '*~' -print | xargs --max-lines=1 --no-run-if-empty
EMACS_CLEAN_RMFILE := rm -v
EMACS_CLEAN_WISH   := echo '*** you may wish to: '

emacs.clean  :
	@${EMACS_CLEAN_FIND} ${EMACS_CLEAN_WISH} ${EMACS_CLEAN_RMFILE}

emacs.clean! :
	@${EMACS_CLEAN_FIND}                     ${EMACS_CLEAN_RMFILE}

#EOF
