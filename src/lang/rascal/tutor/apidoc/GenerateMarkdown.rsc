module lang::rascal::tutor::apidoc::GenerateMarkdown

import List;
import String;
import util::Reflective;

import lang::rascal::tutor::apidoc::DeclarationInfo;
import lang::rascal::tutor::apidoc::ExtractInfo;
import lang::rascal::tutor::Output;
import lang::rascal::tutor::Indexer;
import lang::rascal::tutor::Compiler;
import lang::rascal::tutor::repl::TutorCommandExecutor;
import lang::rascal::tutor::Names;

@synopsis{Generate markdown documentation from the declarations extracted from a Rascal module.}
@description{
    This function takes Rascal files as input, first extracts all declarations including their
    embedded (markdown) documentation tags, and then generates on-the-fly the output markdown
    as a list of lines and error messages. 
    
    This generator reuses the markdown compiler 
    to implement Rascal shell execution and concept linking, etc. This compilation is applied inside of the
    documentation tags that are written by the author of the Rascal code. The trick is to track the
    current line number inside those documentation tags to provide valuable feedback to the user
    of the tutor compiler.
}
list[Output] generateAPIMarkdown(str parent, loc moduleLoc, PathConfig pcfg, CommandExecutor exec, Index ind) {
    try {
        dinfo = extractInfo(moduleLoc);

        // filter the tests
        tests = [t | t:testInfo() <- dinfo];

        isDemo = DeclarationInfo i <- dinfo && i is moduleInfo && i.demo;

        // remove the tests
        dinfo -= tests;

        dtls = sort(dup(["<capitalize(pcfg.currentRoot.file)>:<i.kind>:<i.moduleName>::<i.name>" | DeclarationInfo i <- dinfo, !(i is moduleInfo)]));

        // TODO: this overloading collection should happen in ExtractInfo
        res = [
        ];
        int i = 0;
        while (i < size(dinfo)) {
            j = i + 1;
            list[str] overloads = [];

            if (dinfo[i] has name) {
                overloads = [(isDemo && dinfo[i].fullFunction?) ? dinfo[i].fullFunction : dinfo[i].signature];
                
                // TODO: this only collects consecutive overloads. if a utility function interupts the flow,
                // then we do not get to see the other overloads with the current group. Rewrite to use a "group-by" query.
                // Also this looses any additional documentation tags for anything but the first overloaded declaration
                
                while (j < size(dinfo) && dinfo[i].name == dinfo[j].name) {
                        // this loops eats the other declarations with the same name (if consecutive!)
                        overloads += ((isDemo && dinfo[j].fullFunction?) ? dinfo[j].fullFunction : dinfo[j].signature);
                        j += 1;
                }
            }

            res += declInfo2Doc(parent, dinfo[i], overloads, pcfg, exec, ind, dinfo[i] is moduleInfo? dtls : [], isDemo);
            i = j;
        }

        res += line("### Tests");

        for (di <- tests) {
            res += declInfo2Doc(parent, di, [], pcfg, exec, ind, [], isDemo);
        }

        return res;
    }
    catch Java(_,_):
      return [err(error("parse error in source file", moduleLoc))];
    catch ParseError(loc l):
        return [err(error("parse error in source file", l))];
}

private map[str,str] escapes = ("\\": "\\\\", "\"": "\\\"");

list[Output] declInfo2Doc(str parent, d:moduleInfo(), list[str] overloads, PathConfig pcfg, CommandExecutor exec, Index ind, list[str] dtls, bool demo) =
    [
        out("---"),
        out("title: \"module <escape(d.moduleName, escapes)>\""),
        out("---"),
        Output::empty(),
        out("\<div class=\"theme-doc-version-badge\"\>rascal-<getRascalVersion()><if (pcfg.isPackageCourse) {>, <pcfg.packageName>-<pcfg.packageVersion><}>\</div\>"),
        Output::empty(),
        out("#### Usage"),
        Output::empty(),
        out("`import <replaceAll(d.name, "/", "::")>;`"),
        Output::empty(),
        *tags2Markdown(d.docs, pcfg, exec, ind, dtls, demo),
        out("")
    ];

list[Output] declInfo2Doc(str parent, d:functionInfo(), list[str] overloads, PathConfig pcfg, CommandExecutor exec, Index ind, list[str] dtls, bool demo) =
    [
        out("## function <d.name> {<moduleFragment(d.moduleName)>-<d.name>}"),
        Output::empty(),
        *tags2Markdown(d.docs, pcfg, exec, ind, dtls, demo),
        Output::empty(),
        out("```rascal"),
        *[out(defLine), empty() | ov <- overloads, str defLine <- split("\n", ov)],
        out("```")
    ];   

list[Output] declInfo2Doc(str parent, d:testInfo(), list[str] overloads, PathConfig pcfg, CommandExecutor exec, Index ind, list[str] dtls, bool demo) =
    [
        out("## **test** <d.name> {<moduleFragment(d.moduleName)>-<d.name>}"),
        Output::empty(),
        out("```rascal"),
        *[out(defLine), empty() | ov <- overloads, str defLine <- split("\n", d.fullTest)],
        out("```"),
        Output::empty(),
        *tags2Markdown(d.docs, pcfg, exec, ind, dtls, demo)
    ];       
 
 list[Output] declInfo2Doc(str parent, constructorInfo(), list[str] overloads, PathConfig pcfg, CommandExecutor exec, Index ind, list[str] dtls, bool demo) =
     [];
    
 list[Output] declInfo2Doc(str parent, d:dataInfo(), list[str] overloads, PathConfig pcfg, CommandExecutor exec, Index ind, list[str] dtls, bool demo) =
    [
        out("## data <d.name> {<moduleFragment(d.moduleName)>-<d.name>}"),
        empty(),
        *[
            out("```rascal"),
            *[out(defLine) | str defLine <- split("\n", ov)], 
            out("```"),
            empty()
        | ov <- overloads
        ],
         *tags2Markdown(d.docs, pcfg, exec, ind, dtls, demo)
    ]; 

list[Output] declInfo2Doc(str parent, d:aliasInfo(), list[str] overloads, PathConfig pcfg, CommandExecutor exec, Index ind, list[str] dtls, bool demo) =
    [
        out("## alias <d.name> {<moduleFragment(d.moduleName)>-<d.name>}"),
        empty(),
        out("```rascal"),
        *[out(removeNewlines(ov)), empty() | ov <- overloads],
        out("```"),
        empty(),
        *tags2Markdown(d.docs, pcfg, exec, ind, dtls, demo)
    ];
       
default list[Output] declInfo2Doc(str parent, DeclarationInfo d, list[str] overloads, PathConfig pcfg, CommandExecutor exec, Index ind, list[str] dtls, bool demo) 
    = [err(info("No content generated for <d>", d.src))];

list[Output] tags2Markdown(list[DocTag] tags, PathConfig pcfg, CommandExecutor exec, Index ind, list[str] dtls, bool demo) 
    = [
        // every doc tag has its own header title, except the "doc" tag which may contain them all (backward compatibility)
        *(l != "doc" ? [out("#### <capitalize(l)>"), empty()] : []),
        
        // here is where we get the origin information into the right place for error reporting:
        *compileMarkdown(split("\n", c), s.begin.line, s.offset, pcfg, exec, ind, dtls),

        empty() 

        // this assumes that the doc tags have been ordered correctly already by the extraction stage
        | docTag(label=str l, src=s, content=str c) <- tags
    ];

public str basename(str cn){
  return (/^.*::<base:[A-Za-z0-9\-\_]+>$/ := cn) ? base : cn;
}

str removeNewlines(str x) = visit(x) {
  case /\n/ => " "
};



