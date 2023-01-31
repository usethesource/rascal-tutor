---
title: Tutor Compilation
keywords:
    - compilation
    - compiler
    - configuration
    - maven
    - deployment
    - incremental
    - dependency
    - dependencies
---

After ((Authoring)) tutor files, they have to compiled down to plain docusaurus. The compiler implements features such as linking, screenshots, and executing code fragments.
Most importantly, when there are linking errors (missing or ambiguous) or code execution errors, the compiler reports them such that they can be fixed before releasing the documentation.

## Configuration

The way to execute the rascal tutor compiler is via [rascal-maven-plugin](http://github.com/usethesource/rascal-maven-plugin). First it 
has to be configured for your project.

Do configure the tutor, add the plugin to the pom.xml like so:

```xml
<plugins>
    <plugin>
        <groupId>org.rascalmpl</groupId>
        <artifactId>rascal-maven-plugin</artifactId>
        <version>0.16.0</version>
        <executions>
            <execution>
                <id>default-cli</id>
                <phase>compile</phase>
                <goals>
                    <goal>tutor</goal>
                </goals>
                <configuration>
                    <enableStandardLibrary>false</enableStandardLibrary> 
                    <errorsAsWarnings>false</errorsAsWarnings>
                    <isPackageCourse>true</isPackageCourse>
                    <bin>${project.build.outputDirectory}</bin>
                    <srcs>
                        <src>${project.basedir}/doc/Course1</src>
                        <src>${project.basedir}/doc/Course2</src>
                        <src>${project.basedir}/src/main/rascal</src>
                    </srcs>
                    <ignores>
                        <ignore>${project.basedir}/src/main/rascal/experimental</ignore>
                    </ignores>
                </configuration>
                </execution>
        </executions>
    </plugin>
</plugins>
```

1. `enableStandardLibrary` defines which library the links to standard library documentation refer to. Either the version of rascal that the rascal-maven-plugin depends on (`true`), or the version of rascal that the current project depends on (`false`). Also this defines which version of the library the code examples are executed against.
2. `errorsAsWarnings` and `warningsAsError` define failure modes for the compiler. Maven will not fail if `errorsAsWarnings` is set to `true` even if there are errors.
3. `isPackageCourse`, when set to `true` will nest all target documentation in `docs/Packages/projectName`, and rename `src/main/rascal` or `src` to `API`. All links will also be re-routed to these locations. Otherwise, when set to `false` all documentation ends up in `docs/Course1` and `docs/Course2`, etc.
4. `bin` points to the place that defines the root of the resulting `jar` file. All generated files will endup in `bin/docs` and `bin/docs/assets`. This has to be the outputDirectory and if you forget to configure this, it will be set automatically anyway. The compiler also writes `bin/index.value` file after it is done, to store the entire linking index for future usage. This future use can be either the next run of the compiler, or a depending project downstream.
5. `srcs` define root courses, some of which will be pure Concept hierarchies, and others could be the _root_ of Rascal source folders. Note that this also defines the search path for modules during code execution of `rascal-shell` blocks.
6. `ignores` defines files or folders which are to be ignore. These could be folder names inside of Rascal source folders, or files of Rascal modules, or course concept folders, or course concept files. When a folder is ignored, this works transitively for the contents of that folder.

## Dependencies

If the current Maven project has dependencies then the `index.value` files in these jar files are located
and imported in the current link index of the project. This allows you to refer to concepts in one of the 
projects you depend on, provided that project was also using the `rascal-maven-plugin` to run the tutor compiler.

The dependency feature depends on the assumption that the `/docs` folders in the jar of the current project and the jars of the
project it depends on are extracted into the `docs` folder of a Docusaurus project later, and that everything
under `/docs/assets` in the same jars is copied to `static/assets`. The `rascal-website` project
achieves this using the `resources` plugin `copy` commands. If you are running your own docusaurus site,
then this should be re-implemented.

## Execution

Simply run the maven `compile` or `package` or `install` command to trigger the rascal tutor compiler:

```bash
$ mvn install
```

However, to exclusively run the tutor you can try this:

```bash
$ mvn rascal:tutor
```

If there are screenshots in the documentation, then selenium must be configured with the location of `chrome` and `chromedriver`:

```bash
$ mvn rascal:tutor -Dwebdriver.chrome.driver=`which chromedriver` -Dwebdriver.chrome.browser=`which chrome`
```

Here we have used the bash feature to splice in the location of chromedrive and chrome using the `which` command. This requires both to
be found on the system `PATH`. If this is not the case, provide the absolute path to the binaries of these two programs. Both on Mac
and Windows the path to `Google Chrome`, for example, may contain many spaces and it is wise to wrap the path in double quotes.

The tutor compiler is **incremental** in a certain way. Running the compile twice in a row, only the markdown files and Rascal modules that have been modified will be compiled again. The compiler
reuses the output of the previous run, including error messages. All error messages and warnings, including those of unmodified files are
always presented at the end. 

Simple run the tutor twice to recompile only what has changed:

```bash
mvn rascal:tutor
mvn rascal:tutor
```

:::warning
When folders or files are renamed, the old output files remain in the `bin` folder as well as the old links to those in the link index file.
This can lead to:
* spurious link ambiguity; for example when `A/B.md` has moved to `C/B.md` both versions of `B` will be present in the link administration.
* unreported missing links; for example when `A/B.md` has moved to A/C.md`, `B` will still be linked even though it is not present anymore.

It is therefore always prudent to `mvn clean` such that the output directory including the `index.value` has been removed, when files or folder change name or location.
:::

## Deployment of documentation

* When `mvn install` or `mvn package` is run with the correct configuration for the `bin` folder, then all markdown files and other assets (screenshots) end up in the `jar` file of the current project.
