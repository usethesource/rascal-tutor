---
title: Screenshots
---

### Synopsis

Take screenshots of (interactive) webcontent produced by Rascal code examples.

### Description

The `rascal-shell` feature offers the option to take screenshots of interative content.

Every time the shell detects content that is not strictly plaintext:
* a headless browser is used to display the content.
* a screenshot is taking every second until the visual content stabilizes.
* the screenshot is saved as a PNG image with the markdown content.

This behavior simulates the effect that users have on the REPL when they produce
visual content. For them normally a browser is started in their development environment to
show the content and to interact with it. 

### Examples

Any function that produces an http content server, like below, leads to a screenshot:
``````
```rascal-shell
import vis::Charts;
barChart({<"bike",80>, <"car", 20>})
```
``````

This produces:
```rascal-shell
import vis::Charts;
barChart({<"bike",80>, <"car", 20>})
```

However, we can also hide the commands and only look at the image, using a prepare shell:

``````
```rascal-prepare
import vis::Charts;
barChart({<"bike",20>, <"car", 80>})
```
``````

This produces:

```rascal-prepare
import vis::Charts;
barChart({<"bike",20>, <"car", 80>})
```

#### Benefits

* Screenshots don't lie; you always see it in the documentation as the user will see it in their browser.

#### Pitfalls

* The screenshot feature automatically turns off when the tutor startup code can not link a browser and a selenium driver to control that browser. A warning is printed with hints on how to configure `mvn` to fix this.
