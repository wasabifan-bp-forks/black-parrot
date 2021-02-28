# Remove comment block at the beginning of the file, which includes local file
# paths and timestamps
/#\*\*\*/ {
    SEEN_FENCES += 1;
    next;
}

$0 !~ /#\*\*\*/ {
    if (SEEN_FENCES == 1 || SEEN_FENCES == 2)
        next;
}

# Make file paths relative in checkRequiredFiles function
/^proc checkRequiredFiles/, /^}/ {
    $0 = gensub(/".*\/black-parrot\/(.*")/, "\"${origin_dir}/../../\\1", 1)
}

# If we got this far, print the result
{ print }
