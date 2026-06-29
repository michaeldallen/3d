# BOF

make.targets :
	@echo "available Make targets:"
	@$(MAKE) -pRrq -f $(firstword $(MAKEFILE_LIST)) : 2>/dev/null \
	| awk -v RS= -F: '/^# Implicit Rules/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' \
	| fgrep -v '%' \
	| sed "s/^/    make /" \
	| env LC_COLLATE=C sort

make.targets.topics :
	@echo "available Make target topics:"
	@$(MAKE) -pRrq -f $(firstword $(MAKEFILE_LIST)) : 2>/dev/null \
	| awk -v RS= -F: '/^# Implicit Rules/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' \
	| fgrep -v '%' \
	| cut -d. -f1 \
	| sort -u \
	| env LC_COLLATE=C sort \
	| sed "s/^/    make make.targets./" \

make.targets.% :
	@echo "available Make $* targets:"
	@$(MAKE) -pRrq -f $(firstword $(MAKEFILE_LIST)) : 2>/dev/null \
	| awk -v RS= -F: '/^# Implicit Rules/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' \
	| fgrep -v '%' \
	| sed -n "s/^\($*\)/    make \1/p" \
	| env LC_COLLATE=C sort


make.a.new.top.level.makefile :
	@echo '# BOF'
	@echo ''
	@echo 'include libmake/Makefile'
	@echo ''
	@echo '# EOF'


make.clean :
	@find * -name \*~ -exec echo rm -v {} \;
	@$(MAKE) -pRrq -f $(firstword $(MAKEFILE_LIST)) : 2>/dev/null \
		| awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' \
		| egrep -v '^make.clean$$' \
		| egrep '.clean$$' \
		| env LC_COLLATE=C sort \
		| while read t ; do \
			${MAKE} --no-print-directory $${t} ; \
		  done

make.clean! :
	@find * -name \*~ -exec rm -v {} \;
	@$(MAKE) -pRrq -f $(firstword $(MAKEFILE_LIST)) : 2>/dev/null \
		| awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' \
		| egrep -v '^make.clean!$$' \
		| egrep '.clean!$$' \
		| env LC_COLLATE=C sort \
		| while read t ; do \
			${MAKE} --no-print-directory $${t} ; \
		  done

# EOF
