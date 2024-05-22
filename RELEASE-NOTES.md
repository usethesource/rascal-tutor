
### 0.18.5

* New documentation section @deprecated for all Rascal declarations added. Will generate an admonition
near the synopsis.
* All defaults for RELEASE-NOTES, FUNDING and CITATION have the extension `.md` added to them now.

### 0.18.3

* Fixes example screenshots

### 0.18.2

* Fixes details in tutor documentation

### 0.18.1

* Configure webdrivers
* Added chrome and chromedriver config for screenshot in documentation

### 0.18.0

* Simplified and corrected SourceMarkup
* fixed error
* fixed syntax of keywords list in Listing.md
* fixed docs on tutor

### 0.18.0-RC1

* bumped rascal to 0.35.0-RC5 for fixes in class loaders
* printed a help message for people wanting to take screenshots
* tutor will search for chromedriver, chrome/Google Chrome for Testing in the environment PATH if -D options are not provided

### 0.17.0

* added a wait loop for screenshots, which stops only when the last two screenshots taken are exactly equal

### 0.16.1

* longer waits maybe help with the screenshot feature

### 0.16.0

* fixed release notes feature
* added RELEASE-NOTES.md feature


### 0.15.0
* bumped rascal to 0.34.0 and rascal-maven-plugin to 0.22.0-RC2


### 0.15.0-RC1
* bumped rascal for pre-release


### 0.14.2
* properly escape title strings
* removed remnants of test-modules://


### 0.14.1
* simplified titles to quiet the package menu a bit
* organized imports


### 0.14.0
* added hacks to give Index.rsc files a different name to avoid collisions with index.html and index.md


### 0.13.1
* rascal-prepare blocks now also take screenshots for invisible prepations of salix screenshots


### 0.13.0
* removed unnecessary cropping
* finetuning of the screenshot feature, to help with salix tooltips
* bumped rascal maven plugin


### 0.12.7
* bumped rascal
* bumped rascal-maven-plugin version to 0.20.0 to close the loop
* run this on buildjet-4vcpu-ubuntu-2204 now for speed


### 0.12.6

* bumped to rascal 0.33.6
* removed commented code

### 0.12.4

* minor updates in the upgrading tools
* fixes usethesource/rascal-website#25

### 0.12.3

* working on split doc tag
* removed debug function
* use less markup, more content by removing headers for synopsis and description where possible
* moved position of synopsis in API docs
* fix root name for course folders named src/main/rascal
* fixes #26 and fixes #27

### 0.12.2

* removed extra line at the end of a function

### 0.12.1

* fixed debug statement

### 0.12.0

* dealing with package names with hyphens
* remove superfluous newlines in full function and test bodies

### 0.11.6

* fixes #24

### 0.11.5

* bumped rascal and rascal-maven
* tutor now is type-correct, also added FUNDING and CITATION

### 0.11.4

* do not generate source links if its not a package; and fix the links

### 0.11.3

* fixed links

### 0.11.2

* fixed extra space

### 0.11.1

* better support for source links in documentation

### 0.11.0

* fixed some bugs
* better text
* added optional pages about funding and citation to packages

### 0.10.0

* turned off tutor compilation for tutor itself due to #22

### 0.9.0

* cleared up usage of rascal- languages in Listings
* if a code block expects errors but no errors are reported, this is now flagged as an error.\n\nThis helps to avoid spurious error expect declarations that may start hiding unexpected errors accidentally in the future.
* bumped rascal-maven-plugin
* removed extra new line after the latest function header
* bumped rascal to 0.30.1

### 0.8.5

* bumped rascal to 0.30.0

### 0.8.4

* fixed bug

### 0.8.3

* removed mysterious dot and fixed capitalization of links with MultipleWordInThem
* commands block had an extra newline always

### 0.8.2

* fixed broken links previously undiscovered

### 0.8.1

* added docs and renamed some docs and added details
* added skipping tutor during release prepare

### 0.8.0

* store important information about licenses and dependencies in .txt files such that downstream websites can include this information in their documentation pages

### 0.7.8

* also ignored questions folder

### 0.7.7

* bumped rascal-maven-plugin to 0.15.4 for workaround in tutor with ignores

### 0.7.6

* added workaround for accidental trailing slashes produced by URIUtil.file
* bumped rascal-maven-plugin to 0.15.3 with the new tutor to compile the tutor

### 0.7.5

* bumped license year and fixed itemized dependency list
* fixed broken links due to  moving course Tutor here
* fixed bug in index generator which forgot to filter ignores and also set errorsAsWarnings to false

### 0.7.4

* Move our versions and java version to properties; fix tutor docs build
* move Tutor docs to tutor

### 0.7.3

* fixed bugs in indexer and added dependency information to module docs

### 0.7.2

* generating slugs to disambiguate package names from module names with the same name modulo case, and some minor improvements

### 0.7.1

* added examples next to demo as keyword to trigger demo feature

### 0.7.0

* extract and use syntax definitions as well in docs
* manually fixed pom after release

### 0.6.6

* split version badges into two separate badges
* different class for version badges
* fixed two bugs wrt Package feature: location of static assets and some module name links were wrong

### 0.6.4

* minor improvements in Package index page

### 0.6.3

* fixed some issues with issues

### 0.6.2

* added demo feature, such that files in demo folders show all the function bodies and improved the generation of package index files with useful information about the package such as the source location, the issues tracker and the so question tag and the pom XML dependency for copy/pasting
* bumped rascal to 0.28.2

### 0.6.1

* better version banner

### 0.6.0

* added "package" feature
* tweaking the version class and more slash fiddling
* fiddling with slashes
* fiddling with the paths and the links
* moved links and relative paths for package courses
* added config options and changed targetFile destinations for package documentation

### 0.5.3

* better error reporting on stdout with cause of failures in code blocks
* removed directory modification time caching; was broken

### 0.5.1

* fixed issue in incremental indexer

### 0.5.0

* incrementalized the compiler too, except for copying resources
* incrementalized the indexer, only new files are parsed and considered for indexing compared to the datetime of the old index.value dump

### 0.4.8

* added the rascal-commands feature to execute code
* sorting out the test functions in a module and documenting those with their bodies because those communicate how to use functions and what to expect of the output

### 0.4.7

* running tutor outside of rascal project requires some fixes in the configuration of the evaluator

### 0.4.6

* fixed compiler errors
* moved back to finalizer because the clean up thread has already unloaded the classes we need to shutdown the external processes

### 0.4.5

* fixed broken links
* added more opportunity to ignore
* fixes #7

### 0.4.4

* fixed initialization bug in version without screenshots
* guarded cleanup against null references
* make tutor also run correctly without screenshot feature, and add cleanup of external processes

### 0.4.1

* added ignore feature using pcfg.ignores
* switched from firefox to chrome to avoid crashing during screenshots of large canvasses

### 0.4.0

* added dummy empty IDEServices just in case some module uses it during documentation construction

### 0.3.5

* fixed reference to library index files

### 0.3.4

* added a sleep to make sure the charts are rendered before the screenshot is taken

### 0.3.3

* better highlighting for function headers and aliases

### 0.3.2

* bumped to rascal 0.26.3
* organized imports

### 0.3.1

* improvement of screenshot feature

### 0.3.0

* added screenshot feature for Content results that appear on the output of the Tutor REPL
* added screenshot feature to tutor
* added selenium dependency
* bumped to rascal 0.26.2
* forgot to add classloader to REPL evaluator that depends only on the explicit pathConfig that is passed to the create function
* improved regex for callouts

### 0.2.3

* fixed callouts in multiline comments and fixed multidigit callouts

### 0.2.2

* callout feature: added a line post-processor stage which can replace call-outs in source text and itemized lists with unicode inverted circled digits
* bumped to rascal 0.26.1 which does not have the original Java classes for the Tutor Repl
* fixed broken image links with empty alt tags, and changed test setup to work in different project
* relocated classes to their right package
* relocated classes to their right package
* added tag name config

### 0.2.1

* Update README.md

### 0.2.0

* added github actions

### 0.1.0

* added ignores
* created dir structure and added pom file
* moved code back to where it belongs
* workaround for .file bug
* divided recursion over input lines over bigger steps to avoid stackoverflows
* fixed loss of error message by removing nested shadowing variable
* fixed missing index files
* improved Hello and the shell printed toomuch
* influence sidebar positions via details meta-data
* revived unicode implementation of subscripts, temporarily
* whitespace
* removed dead code
* fixed or removed all remaining errors, warnings and todos in documentation in this project
* re-implemented the indexer to sanitize it and generate links to index.md files
* added testing feature for compiling a single file and reusing the index
* fixed a snarky bug in de tutor REPL. Reset would leave cruft sometimesin the error stream
* many more slashes
* tweaking the link semantics until it works
* standardizing layout in example modules and removing old tags
* better quoting for error messages in the REPL avoid docusaurus crashes
* fixed small things, coding standard things in the old demos, added more examples, updated code examples which could now be done with new features
* fixed more links and indices
* better link names
* fixed broken itemzied lists in generated index pages
* missed a line in the huge comprehension
* links need ever more attention.
* moved json internals and fixed links in TOCs of non-generated index files
* relative links work well now
* fixed more links
* renaming to avoid name clash (json/io) and rooted all .md links at ./ to help the dino
* fixed minor issues with links and escaping issues in specific files
* give root folders a title
* fixed bugs in links and code blocks in general and some specific issues
* fixed link and removed debug print
* fixed instance of include in the csv doc
* removed TutorHome and replaced a few more include links
* replaced hard asciidoctor includes by specific Rascal includes with parser and test/tag removal feature
* working on include feature
* assets are copied again
* fixed indentation of output
* rewrote .Synopsis to #### Synopsis, etc. etc.
* fixed some errors in index and replace rascal project by snakes-and-ladders in the M3 recipes
* moved Test course out of the source folder and fixed links and code examples here and there
* escaped true and false and some generated titles
* removed double quotes
* added lots and lots of quotes
* fixed details section YAML
* fixed syntax of YAML headers
* fixed more links
* added link resolution for the current course to solve ambiguity
* replaced the last asciidoctor syntax remnants. .Synopsis is now #### Synopsis
* fixed weaving errors
* moved .Details to detail: metadata
* fixed more links
* meta-data instead of markdown titles for rascal modules
* moved keywords and title meta-data to meta-data sections
* fixed typing error
* fixed more links
* changed compiler and linker to generate independent files per concept instead of one file per course. this also implies changes in the error handling code
* fixes due to breaking API in util::Benchmark plus a lot of minor links
* down to 225 errors
* fixed many small issues in docs and doc generator
* only 260 errors left
* added some pitfalls and benefits
* improved ambiguous link reporting and started resolving some of them
* fixing small issues
* commented out experimental file include feature
* added some help for the reader to see what every section is about (module, function, data, alias)
* refactored the ExtractDoc functionality and the ExtractInfo functionality to trace the locations of every line of documentation such that errors in rascal-shell blocks and in concept links are reported in the right file and the right location
* transitioning towards accurate error reporting inside @doc tags
* translated all normal http links from asciidoctor to markdown
* some reporting tricks to help go through the last 300 errors
* down to 300 errors
* tutor compiler seems feature complete. time for manual stuff
* factored indexer out of Compiler and introduced modular indices, and fixed some manual stuff
* simple fix
* fixed several missing details and missing links
* fixing links one-by-one and by allowing more forms (ParseTree::parse next to ParseTree-parse)
* added indexing of rascal modules and their contents, including qualified names for each category, so: constructor:IO can be distinguised from module:IO/;
* fixed some more links
* fixed a lot of links
* some new conversions
* fixing all Libraries links and moving pictures to md5 names instead of uuid for stability
* will call extractInfo more than once during a single run, so added a memo cache
    Also fixed skipping .Details and .Index sections such that unsupported
    unquoted characters are being filtered correctly.
* fixed several issues in the indexing/link system
* fixed admonitions embedded in code blocks
* better section headers
* translated non-rascal code examples from asciidoctor to markdown
* converted missing cases of unsupported markup inside backquotes
* replaces instances of superscript by subscript
* removed all the italics markup inside backquotes because that is not supported
* added support for subscripts (digits and some letters) using  syntax.
* reconverted tables to default first line as header. that happens more often than not.
* added a asciidoctor to commonmark table conversion
* fixed `(((TOC)))` generation for index files that do not list .Details
* fixing links and fixed false complaint about failing code in case of static ambiguity warning
* replaces asciidoctor keyboard macro syntax with backquotes
* missing links are now warnings, not errors, and concepts without .Details section get a generated details list using directory listing
* fixed minor issues in the docs
* reconverted library files because some blocks ended with ----} and we lost the closing bracket
* also replaced source syntax in @doc tags in rascal files to markdown backticks
* temporary transformation script
* rewrote asciidoctor syntax to docusaurus/commonmark in the doc tags of rascal modules in the library
* added TOC feature. not done. also rewrote asciidoctor nested lists syntax
* added `(((TOC)))` feature to replace asciidoctors loctoc feature
* converted more links to new syntax
* working on image linking/asset management
* converted image references
* converting image syntax
* new link syntax supported and fixed some issues in both documentation (ambiguous links) and the compiler
* added link title support
* improved indexing with parent prefix
* allowed for spaces between camelCase words inside links
* added linking to indexed documents with the << >> syntax
* added a concept index that is used to generate unique fragment ids, and can later be used to look them up for internal linking
* a single course will not produce a single .md file
* supporting old-style rascal blocks to ease the transition
* added parser for legacy format
* change output syntax to docusaurus
* hooked in the asciidoctor generator for Rascal to markdown
* minor stuff
* finishing touches for the rascal-shell execution
* renaming for clarity
* added compiler for rascal-shell repls in markdown documents
* another move for clarity
* move refactoring
* big simplification of tutor command executor
* added Rascal bridge to TutorCommandExecutor class
* wiring in the shell into the tutor, again
* started compiler for .rsc files, .concept filed and .md files to docusaurus markdown
* clean up of dead code around old tutor
* needed some more methods to be public
* make sure that (a) BasicIDEServices are registered for the commandline version of Rascal and (b) the edit command is wired to the edit IDEService
* Better fix without exposing the file separator to Rascal
* Replaced literal occurence of forward slash by the actual file separator
* fixed compilation issues
* instead of switching between plaintext and html output, we always output both channels with both mimetypes. the UI decides which output to show and how
* resolved all java compilation warnings
* moved interpreter-independent exception code to its own package
* introduced the function as a Rascal IValue, such that builtin Java methods can produce and call them (using vf.function and IFunction.call) without depending explicitly on an EvaluatorContext. This has consequences for all builtin functions which receive a function value. Before their class type would be IValue.class, now it has become IFunction.class.
* fixed rascal and java compiler warnings
* refactored streams to avoid wrapping by PrintWriters and only work with raw outputstreams
* fixed the bugs in TermREPL and simplified the interface. It was required to add an InputStream to the configuration of an evaluator, to be able to start a nested REPL using a builtin
* Removed legacy file
* Fixed missing returns
* removed dead feature of repository of packages from pathconfig, making recursive search for libraries unnecessary, which contained bugs. Also removed the boot option which is not necessary anymore.
* added import
* moved RascalExtraction module
* attempt to loosen tutor support from RVM compiler internals
* moved utilities of RVM which are still in use to appropriate packages
* removed the RVM (rascal virtual machine)-based compiler experiment and fixed all the dependencies of the interpreter code on pieces of the RVM experiment
* fixed unused variables warnings in many places and dynamic use of static fields
* do not load the question compiler if we do not need it (just for answering questions for example)
* added util::Test for programmatic access to Rascal's test runner and used this to fix the question compiler response to fawlty answers
* final steps to make question compiler work again
* another fix towards gettting the questions compiler online
* fix issue with classpath in question compiler
* fixed question compiler
* enabled testing of questions, in a rudimentary way, using util::Eval
* steps towards bringing question compiler back online
* re-implemented PathConfig.asConstructor in an interpreter and compiler-independent way (depends only on vallang and it must mirror the definition in util::Reflective
* moved tutor from experiments to lang::rascal::tutor
