read -p "Enter the name of your feature branch: " BRANCH_NAME

# uncomment if it is in linux, and need to convert dos to unix
# sed -i 's/\r$//' git_script/git_push_branch.sh

# Stage deletions and updates to tracked files
git add .

# Unstage files >=100MB if they were staged (e.g., via git add -u)
LARGE_FILES=$(find . -type f -size +100M)
if [ -n "$LARGE_FILES" ]; then
	echo "The following files are 100MB or larger and will NOT be added. Use git_lfs_push.sh for large files:"
	echo "$LARGE_FILES"
	echo "$LARGE_FILES" | while read -r file; do
		git restore --staged $file
	done
fi


git commit -m "update"

git push origin "$BRANCH_NAME"