# bazel-bug
This is a reproduction of Bazel issue #5541.
The problem is that virtual include directories are not cleaned.
The result is the following sequence:
- This repo builds successfully as-is.
- You delete a line in a BUILD file, and it still builds sucecssfully.
- You undo the deletion - now build fails.

The script reproduce.sh demonstrates it.
