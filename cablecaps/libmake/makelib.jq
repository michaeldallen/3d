#BOF

jq.eks-list-clusters :
	  aws eks list-clusters | jq --raw-output '.clusters | sort | .[]'

jq.readme :
	@echo 'https://stedolan.github.io/jq/manual/'
	@echo 'https://jqplay.org/'

# EOF
