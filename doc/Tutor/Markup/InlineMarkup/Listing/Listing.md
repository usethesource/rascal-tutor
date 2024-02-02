---
title: Listing
keywords:
    - rascal-shell
    - listing
    - source
    - rascal-prepare
    - rascal-commands
    - rascal-include
    - include
---

#### Synopsis

Include (executable) source code examples in the document.

#### Syntax

* Simple Rascal code, no execution:
``````
```rascal
42 / 6
```
``````
* Simple Rascal, with shell execution:
``````
```rascal-shell
1 + 1
```
``````
* Rascal shell execution with expected errors
``````
```rascal-shell,errors
1 / 0
```
``````
* Rascal shell execution with continued environment from previous code block
``````
```rascal-shell,continue
a + b; // where a and b where declared in an earlier listing
```
``````
* Hidden Rascal shell execution without any output (no code, no values, no prints)
``````
```rascal-prepare
int a = 0;
```
``````
* Visual shell execution with side-effects, but no value or printed output:
``````
```rascal-commands
int f(int n) {
  if (n <= 0) {
    return 1;
  }

  return n * f(n - 1);
}
```
``````
* Include the definition of a module in the documentation, and make it importable:
``````
```rascal-include
demo::my::Example
```
``````

#### Description

* You can use the triple backquotes to encapsulate a piece of literal source text. The language name indicates
which syntax highlighter to use. You can use all the builtin languages of the downstream markdown processor, but there are some special ones.
* The special langauges start with `rascal-`:
   * If you use `rascal-shell` as a language name, then the code is executed line-by-line by a Rascal shell and the output is collected. 
   * With `rascal-prepare` the code is executed in the current environment but no output is shown and the code is also hidden.
   * With `rascal-commands` the code is executed in the current environment, and the code is printed to the documentation page.
   * Finally using `rascal-include` you can include modules from disk that are on the current search path.
* Every rascal code block will start in a fresh environment, unless the `continue` label is used. With the `continue` label active, the _previous_ environment is continued. This is particularly useful with the use of `rascal-prepare` and `rascal-commands` as they allow to declare functions and syntax types before they are used in a shell.
* Either `rascal-shell`, `rascal-prepare`, `rascal-commands` or `rascal-include` code with an unexpected error in it will _fail_ the documentation build and an error message will be reported. The build will continue to find other issues and compile all the other files.
* Using the `error` label to a code block, an error will be expected and printed back to the user. This is to demonstrate error messages to the reader. 
   * If no error is produced by the code block, but the error label is used, an error will be printed and the compilation will fail.
   * If an error is produced by a code block, but the error label is not used, an error will be printed and the compilation will fail.
* The "magic comments" `highlight-next-line`, `highlight-start`, and `highlight-end` give you a way to highlight
selected lines in the code. Also you can use ranges like this `{1,4--6,9}`.
* If a `rascal-shell`, `rascal-commands` or `rascal-prepare` produces an interactive `Content` value, then the compiler will wait one second and try to make a [screenshot]((Screenshots)) of the browser's visual content. That [screenshot]((Screenshots)) is immediately included in the current document at that place. 
* Use `showLineNumbers` to render line numbers in the code examples.
* If you use `rascal` as a language, no checking occurs. There is only syntax highlighting.

#### Examples

``````
```rascal-shell
x = 1 + 1;
```
``````

Would produce:

```rascal-shell
x = 1 + 1;
```

Using `continue` you can continue where you've left off:

``````
```rascal-shell,continue
x + 1
```
``````

Which results in:

```rascal-shell,continue
x + 1
```

With `error` you can show an error message without the build failing:
``````
```rascal-shell,error
int x = 1;
y + y;
```
``````

```rascal-shell,error
int x = 1;
y + y;
```

Or you could prepare something in "secretly":
``````
```rascal-prepare
int x = 1;
```
``````

```rascal-prepare
int y = 1;
```

Nothing is shown; the `prepare` block is executed but hidden from view. Then use the context it created later. This is nice for generating example data in files or modules to import
without bothering the reader with the details. Watch out: it is not smart to
hide essential notions from the user. This feature is only for preparing a lesson, not to destroy it...

``````
```rascal-shell,continue
y + y
```
``````

```rascal-shell,continue
y + y
```

Simply using `rascal` as a language does not have all these effects:

``````
```rascal
int fac(0) = 1;
default int fac(int n) = n * fac(n - 1);
```
``````

That block simply produces this:

```rascal
int fac(0) = 1;
default int fac(int n) = n * fac(n - 1);
```

Now we demonstrate line highlighting:

``````
```rascal {2--7} showLineNumbers
int fac(int n) {
    if (n <= 0) {
        return 1;
    }
    else {
        return n * fac(n-1);
    }
}
```
``````

```rascal {2-7} showLineNumbers
int fac(int n) {
    if (n <= 0) {
        return 1;
    }
    else {
        return n * fac(n-1);
    }
}
```

``````
```rascal showLineNumbers
int fac(int n) {
    // highlight-next-line
    if (n <= 0) {
        return 1;
    }
    else {
    // highlight-start
        return n * fac(n-1);
    // highlight-end
    }
}
```
``````

```rascal showLineNumbers
int fac(int n) {
    // highlight-next-line
    if (n <= 0) {
        return 1;
    }
    else {
    // highlight-start
        return n * fac(n-1);
    // highlight-end
    }
}
```

#### Benefits

* Code examples that run at documentation compile-time are "always" tested and correct when deployed.
* Screenshots are always up-to-date with the latest look-and-feel of the example

#### Pitfalls

* Screenshots are only taken when the compiler is properly configured to link selenium and chrome


