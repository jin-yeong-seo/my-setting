# Build cscope xref for Golang.  Works well for "Find this C symbol", but not very well for definitions.

# Assuming you're in the project Root:

#Find the files
find . -name '*.go' > cscope.files

#Build the xref
cscope -b -k

#Run cscope
cscope -d
