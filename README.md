# chtml
A function that helps users create html files. Allows for easy insertion of repetative blocks of code across html files

## How to use:
For each .html file, create a corresponding .chtml file for it. chtml parses each .chtml file in the current directory to produce a corresponding .html file. There are two types of insertions that we can do: *static insertions* and *dynamic insertions*.

### Static Insertions
At any line in our .chtml file we can include a line <code>{file_name}</code> that will insert the contents of <code>file_name</code> at that line verbatim. The <code>{file_name}</code> must be its own line; only whitespace may be before the "{" and no text at all may be after the "}". <code>file_name</code> may be of any file type other than .html or .chtml

For example, say we have multiple .html files with the same CSS formatting, we can copy the code in <code><style></code> into its own file, call it <code>mycss.css</code> and then add <code>{mycss.css}</code> in its place for all corresponding .chtml files.
  
### Dynamic Insertions
Dynamic insertions allow us to pass parameters into the files that are being include. Similar to static insertions they have the following formatting: <code>{file_name 1:text1 2:text2 ...}</code> and in our file, <code>file_name</code>, we include <code>~1</code> in the place that we want "text1" to be inserted into. The replacement text, e.g. text1, must not contain spaces and the identifier, e.g. 1, must be a whole number greater than or equal to 0.

##### An example is in the "example" folder
