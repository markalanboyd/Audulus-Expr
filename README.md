# Audulus-Expr
A repository for code implemented in Audulus using C expressions in the Expr node.

The files are saved as Objective-C .m files so that the C linter in VS Code doesn't interfere with formatting when saving.

Each file folder consists of:

1. **Source code:** That is, what is to be pasted into an `Expr` node in Audulus. Each file is extensively documented, providing a description of inputs and necessary external helper nodes (usually something like a `Unit Delay` for feedback). It also includes a line-by-line commented, uncommented, and minified (ready to paste with whitespaces removed) version of the code. Note: you must paste in the uncommented or (preferably) minified version into Audulus for it to work.
2. **Screenshots:** In an `/img` folder that show what the implementation looks like and how to wire any necessary external nodes.
3. **Patch files:** A module or submodule patch with internal documentation, and a demo showing how to implement it.
