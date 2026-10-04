#!/usr/bin/env wolframscript
(* Deploys the built paclet as a public paclet resource in the Wolfram Cloud, the way the
   InfraGeometry and PureMath paclets are deployed. The resource bundles the built Documentation/
   tree, the cloud resolves every paclet: link into the bundled pages, so the typed links the pages
   carry work without rewriting, every page serves at
     <target>/Documentation/ChernSimons/<guide|ref|tutorial>/<Name>.html
   and the resource root is the landing page, whose main guide the definition names.
   1. the built paclet PackageDocs.wls left in its scratch directory is the paclet the resource
      bundles; run that script first;
   2. docs/ResourceDefinition.md -> <built>/ResourceDefinition.nb by MarkdownToNotebook's Paclet
      template, and the built PacletInfo.wl gets the exported symbols as its "Symbols" list, which
      the resource scraper wants declared; the tracked PacletInfo.wl is not touched;
   3. the cloud account is checked against the target: the location the resource system computes
      for this account must be the expected one, so a cached login for someone else cannot deploy
      elsewhere;
   4. headless scrape of the definition notebook and CloudDeploy with Permissions -> "Public",
      what the definition notebook's "Deploy -> Publicly in the cloud" button does;
   5. relink: the deploy rewrites every paclet: link inside the pages to <target>/Documentation/<kind>/
      <Name>.html but copies the pages to <target>/Documentation/ChernSimons/<kind>/<Name>.html, so the
      deployed notebooks are read back, the links pointed at the folder the pages are in, and written
      back public; idempotent;
   6. check: the resource root and every page must answer 200, and so must every link target inside
      the deployed pages that points back into the resource.
   Usage: PublishDocs.wls          deploy, relink, then check
          PublishDocs.wls relink   only the relink and the check, on what is deployed
          PublishDocs.wls check    only the check against the target
          PublishDocs.wls audit    every link of every served page and deployed notebook, internal and
                                   external, with its status, written to Research/Artifacts/PacletLinks_<date>.md
   Exit 1 on any failed stage. The archive at obj/hajek_pavel/s1paper/ChernSimons.paclet is
   Publish.wls's business and is never touched here; no version is bumped. *)

$pacletDirectory = DirectoryName[ $InputFileName ];

$repository = ParentDirectory[ ParentDirectory[ $pacletDirectory ] ];

$converter = FileNameJoin[ { $repository, "Resources", "MarkdownToNotebook", "MarkdownToNotebook.wl" } ];

$name = "ChernSimons";

$context = "ChernSimons`";

$built = FileNameJoin[ { $TemporaryDirectory, $name <> "-package", $name, "build", $name } ];

$definitionSource = FileNameJoin[ { $pacletDirectory, "docs", "ResourceDefinition.md" } ];

$definition = FileNameJoin[ { $built, "ResourceDefinition.nb" } ];

$target = "https://www.wolframcloud.com/obj/hajek_pavel/DeployedResources/Paclet/" <> $name;

$deployTimeout = 3600;

$kinds = { { { "Guides" }, "guide" }, { { "Tutorials" }, "tutorial" }, { { "ReferencePages", "Symbols" }, "ref" } };

PublishDocs[ { "check" } ] :=
  (
    If[ ! DirectoryQ[ DocumentationRoot[ ] ], FailStage[ "no built paclet at ", $built, ": run PackageDocs.wls first" ] ];
    ConnectCloud[ ];
    Exit[ Boole[ ! And[ HTTPCheck[ ], LinkCheck[ ] ] ] ]
  )

PublishDocs[ { "audit" } ] :=
  (
    If[ ! DirectoryQ[ DocumentationRoot[ ] ], FailStage[ "no built paclet at ", $built, ": run PackageDocs.wls first" ] ];
    ConnectCloud[ ];
    Exit[ Boole[ ! Audit[ ] ] ]
  )

PublishDocs[ { "relink" } ] :=
  (
    If[ ! DirectoryQ[ DocumentationRoot[ ] ], FailStage[ "no built paclet at ", $built, ": run PackageDocs.wls first" ] ];
    ConnectCloud[ ];
    Relink[ ];
    Exit[ Boole[ ! And[ HTTPCheck[ ], LinkCheck[ ] ] ] ]
  )

PublishDocs[ { "scrape" } ] :=
  Block[ { $scrapeOnly = True },
    ScrapeAndDeploy[ Prepare[ ] ]
  ]

PublishDocs[ { } ] :=
  Module[ { location, url },
    location = Prepare[ ];
    url = ScrapeAndDeploy[ location ];
    Print[ "" ];
    Relink[ ];
    Print[ "" ];
    Exit[ Boole[ ! And[ HTTPCheck[ ], LinkCheck[ ] ] ] ]
  ]

Prepare[ ] :=
  Module[ { symbols, location },
    Print[ "built: ", $built ];
    Print[ "target: ", $target ];
    If[ ! ( DirectoryQ[ $built ] && FileExistsQ[ FileNameJoin[ { $built, "PacletInfo.wl" } ] ] && Pages[ ] =!= { } ),
      FailStage[ "no built paclet with pages at ", $built, ": run PackageDocs.wls first" ] ];
    If[ ! FileExistsQ[ $definitionSource ], FailStage[ "no resource definition source at ", $definitionSource ] ];
    If[ ! FileExistsQ[ $converter ], FailStage[ "no converter at ", $converter, ": recover it per Wiki/Resources/MarkdownToNotebook.md" ] ];
    Print[ "pages: ", StringRiffle[ Map[ kind |-> ToString @ Count[ Pages[ ], { Last @ kind, _ } ] <> " " <> Last @ kind, $kinds ], ", " ] ];
    PacletDirectoryLoad[ $built ];
    Needs[ "PacletResource`" ];
    Needs[ "PacletTools`" ];
    Needs[ "DefinitionNotebookClient`" ];
    Needs[ "PacletResource`DefinitionNotebook`" ];
    Quiet @ Needs[ $context ];
    symbols = DeclareSymbols[ ];
    Get[ $converter ];
    Print[ "definition: ", $definitionSource, " -> ", $definition ];
    MarkdownToNotebook[ $definitionSource, $definition ];
    If[ ! FileExistsQ[ $definition ], FailStage[ "MarkdownToNotebook wrote no definition notebook" ] ];
    location = ConnectAndLocate[ ];
    PatchVendor[ symbols ];
    InjectHero[ ];
    InjectWebContent[ ];
    location
  ]

(* the headless scrape returns the metadata sections of the definition notebook and never its Web
   Content, so the landing page would show neither the Basic Description nor the hero; the cells of
   the two sections are read from the definition notebook and joined into the information the
   landing page is built from, together with the URL the hero is deployed at *)
InjectWebContent[ ] :=
  Module[ { cells, section, long, details },
    cells = Select[ Cases[ Import[ $definition ], Cell[ _, _String, ___ ], Infinity ], MatchQ[ #[[ 2 ]], "Subsection" | "Text" | "Notes" ] & ];
    section[ tag_String, style_String ] :=
      With[ { start = FirstPosition[ cells, Cell[ _, "Subsection", ___, CellTags -> { ___, tag, ___ }, ___ ], { 0 }, { 1 } ][[ 1 ]] },
        If[ start === 0, { },
          TakeWhile[ Drop[ cells, start ], #[[ 2 ]] =!= "Subsection" & ] // Select[ #[[ 2 ]] === style & ] ] ];
    long = Replace[ GuideIntroCells[ ], { } -> section[ "LongDescription", "Text" ] ];
    details = section[ "Details", "Notes" ];
    Print[ "web content: ", Length[ long ], " description cells, ", Length[ details ], " details cells" ];
    Quiet @ Unprotect[ PacletResource`Private`prepareShingleInfo ];
    PrependTo[ DownValues[ PacletResource`Private`prepareShingleInfo ],
      HoldPattern[ PacletResource`Private`prepareShingleInfo[ info_Association ? ( ! KeyExistsQ[ #, "WebContentInjected" ] & ), opts___ ] ] :>
        ( PacletResource`Private`prepareShingleInfo[
            Join[ info, DeleteCases[ <|
              "LongDescription" -> long,
              "Details" -> details,
              "HeroImage" -> Lookup[ info, "HeroImage", $target <> "/HeroImage.png" ],
              "WebContentInjected" -> True |>, { } ] ],
            opts ] ) ];
    Quiet @ Unprotect[ PacletResource`Private`deployDelayedEmbedTemplate ];
    PrependTo[ DownValues[ PacletResource`Private`deployDelayedEmbedTemplate ],
      HoldPattern[ PacletResource`Private`deployDelayedEmbedTemplate[ tgt_, template_String, params_, urls_, opts_ ] ] /; ! TrueQ[ $embedPrinted ] :>
        Block[ { $embedPrinted = True },
          Print[ "landing page: ", StringLength[ template ], " chars, hero ", StringCount[ template, "class=\"hero-image\"" ],
            ", description ", StringCount[ template, "<div class=\"more-description\">" ] ];
          With[ { deployed = PacletResource`Private`deployDelayedEmbedTemplate[ tgt, template, params, urls, opts ] },
            (* the vendor deploys the page as a Delayed object that the cloud keeps serving in an
               older static form; when the page has no static slots left to fill, the rendered
               HTML is written over it as a plain file, which is what the cloud serves *)
            If[ urls === <| |> || urls === { },
              Print[ "landing page: written as static HTML: ",
                Head @ CloudExport[ CenterHero[ template ], { "String", "text/html" }, CloudObject[ tgt ], Permissions -> "Public" ] ] ];
            deployed ] ] ];
  ]

(* the landing page says what the root guide says: its Basic Description is the Abstract of
   docs/Guides/ChernSimons.md, one Text cell per paragraph with the links and the bold of the
   markdown, the image lines left to the hero; the definition's own Basic Description is the
   fallback when the guide has none *)
GuideIntroCells[ ] :=
  Module[ { text, section, paragraphs },
    text = Import[ FileNameJoin[ { $pacletDirectory, "docs", "Guides", $name <> ".md" } ], "Text" ];
    section = First[ StringCases[ text, "\n## Abstract\n" ~~ Shortest[ body___ ] ~~ "\n## " :> body ], "" ];
    paragraphs = Select[ StringTrim /@ StringSplit[ section, "\n" ~~ WhitespaceCharacter ... ~~ "\n" ], # =!= "" && ! StringStartsQ[ #, "![" ] & ];
    Map[ paragraph |-> Cell[ TextData[ inlineTextData[ StringReplace[ paragraph, "\n" -> " " ] ] ], "Text" ], paragraphs ]
  ]

(* the shingle sets the description and the hero side by side as two table cells of half width,
   which squeezes the text into a column; the static page stacks them: the text at full width, the
   hero centered below it *)
CenterHero[ html_String ] :=
  StringReplace[ html, "</head>" -> StringJoin[
    "<style>",
    "#shingle main.shingle-content .top-of-shingle-copy { display: block !important; }",
    "#shingle main.shingle-content .top-of-shingle-copy .more-description,",
    "#shingle main.shingle-content .top-of-shingle-copy .hero-image-frame { display: block !important; width: 100% !important; padding: 0 !important; }",
    "#shingle main.shingle-content .top-of-shingle-copy .hero-image-frame { text-align: center; margin: 1.5em 0; }",
    "#shingle main.shingle-content .top-of-shingle-copy .hero-image { max-width: 100%; width: 820px; }",
    "</style></head>" ], 1 ]

DocumentationRoot[ ] := FileNameJoin[ { $built, "Documentation", "English" } ]

Pages[ ] :=
  Join @@ Map[ kind |-> Map[ file |-> { Last @ kind, FileBaseName @ file },
    FileNames[ "*.nb", FileNameJoin[ Prepend[ First @ kind, DocumentationRoot[ ] ] ] ] ], $kinds ]

PageURL[ { segment_String, name_String } ] := $target <> "/Documentation/" <> $name <> "/" <> segment <> "/" <> name <> ".html"

FailStage[ message__ ] := ( Print[ "  !! ", message ]; Exit[ 1 ] )

HTTPCheck[ ] :=
  Module[ { start = AbsoluteTime[ ], status, bad },
    Print[ "http check: ", Length @ Pages[ ], " pages and the resource root" ];
    status[ url_String ] := Replace[ Quiet @ TimeConstrained[ URLRead[ url, "StatusCode" ], 60, $TimedOut ], Except[ _Integer ] -> 0 ];
    bad = Select[ Map[ url |-> { url, status[ url ] }, Prepend[ PageURL /@ Pages[ ], $target ] ], Last[ # ] =!= 200 & ];
    Print[ "  ", Length @ Pages[ ] + 1 - Length[ bad ], " ok, ", Length[ bad ], " failed, ", Round[ AbsoluteTime[ ] - start ], " s" ];
    Scan[ entry |-> Print[ "  !! ", Last @ entry, "  ", First @ entry ], bad ];
    Print[ If[ bad === { }, "ok", "FAILED" ] ];
    bad === { }
  ]

ConnectCloud[ ] :=
  (
    If[ ! $CloudConnected, CloudConnect[ ] ];
    If[ ! $CloudConnected, FailStage[ "no Wolfram Cloud connection" ] ];
  )

DeployedNotebooks[ ] :=
  Join @@ Map[ kind |-> Select[ CloudObjects[ CloudObject[ $target <> "/Documentation/" <> $name <> "/" <> Last @ kind ] ],
    object |-> StringEndsQ[ First @ object, ".nb" ] ], $kinds ]

$relinkRules := $relinkRules = Map[ kind |->
  $target <> "/Documentation/" <> Last @ kind <> "/" -> $target <> "/Documentation/" <> $name <> "/" <> Last @ kind <> "/", $kinds ]

Relink[ ] :=
  Module[ { start = AbsoluteTime[ ], notebooks, scratch, changed },
    notebooks = DeployedNotebooks[ ];
    Print[ "relink: ", Length[ notebooks ], " deployed notebooks" ];
    scratch = FileNameJoin[ { $TemporaryDirectory, $name <> "-relink.nb" } ];
    changed = Select[ notebooks, object |->
      With[ { notebook = CloudGet[ object ] },
        With[ { relinked = notebook /. s_String :> RuleCondition[ StringReplace[ s, $relinkRules ] ] },
          If[ relinked === notebook, False,
            Export[ scratch, relinked, "NB" ];
            CopyFile[ scratch, object, OverwriteTarget -> True ];
            SetOptions[ object, Permissions -> "Public" ];
            True ] ] ] ];
    Print[ "  ", Length[ changed ], " relinked, ", Round[ AbsoluteTime[ ] - start ], " s" ];
  ]

LinkCheck[ ] :=
  Module[ { start = AbsoluteTime[ ], notebooks, targets, status, bad },
    notebooks = DeployedNotebooks[ ];
    targets = DeleteDuplicates[ Join @@ Map[ object |->
      Cases[ CloudGet[ object ], s_String /; StringStartsQ[ s, $target <> "/" ] :> s, Infinity ], notebooks ] ];
    Print[ "link check: ", Length[ targets ], " distinct link targets inside ", Length[ notebooks ], " deployed notebooks" ];
    status[ url_String ] := Replace[ Quiet @ TimeConstrained[ URLRead[ url, "StatusCode" ], 60, $TimedOut ], Except[ _Integer ] -> 0 ];
    bad = Select[ Map[ url |-> { url, status[ url ] }, targets ], Last[ # ] =!= 200 & ];
    Print[ "  ", Length[ targets ] - Length[ bad ], " ok, ", Length[ bad ], " failed, ", Round[ AbsoluteTime[ ] - start ], " s" ];
    Scan[ entry |-> Print[ "  !! ", Last @ entry, "  ", First @ entry ], Take[ bad, UpTo[ 20 ] ] ];
    Print[ If[ bad === { }, "ok", "FAILED" ] ];
    bad === { }
  ]

(* the scraper reads the Kernel extension's "Symbols"; they are declared in the built PacletInfo.wl
   only, and the tracked file stays as it is *)
(* the audit reads every served page and every deployed notebook, collects every href of the HTML
   and every URL string of the notebooks, resolves anchors, relative paths and paclet: URIs to the
   address a browser would fetch, reads each distinct address once and writes the table; a page
   anchor and a script fragment are not links and are left out *)
Audit[ ] :=
  Module[ { start = AbsoluteTime[ ], pages, found, resolved, status, unread, bad, report, date, file },
    pages = Prepend[ PageURL /@ Pages[ ], $target ];
    Print[ "audit: ", Length[ pages ], " served pages" ];
    found = Join @@ Map[ page |-> Map[ { page, # } &,
      DeleteDuplicates @ StringCases[ Replace[ Quiet @ TimeConstrained[ URLRead[ page, "Body" ], 120, "" ], Except[ _String ] -> "" ],
        "href=\"" ~~ Shortest[ h__ ] ~~ "\"" :> h ] ], pages ];
    Print[ "  ", Length[ found ], " hrefs in the HTML" ];
    found = Join[ found, Join @@ Map[ object |-> Map[ { First @ object, # } &,
      DeleteDuplicates @ Cases[ CloudGet[ object ], s_String /; StringStartsQ[ s, "http://" | "https://" | "paclet:" ] :> s, Infinity ] ],
      DeployedNotebooks[ ] ] ];
    Print[ "  ", Length[ found ], " links with the notebooks" ];
    resolved = DeleteCases[ Map[ { First @ #, Last @ #, ResolveLink @@ # } &, found ], { _, _, None } ];
    status = Association @ Map[ url |-> url -> ReadStatus[ url ], DeleteDuplicates[ resolved[[ All, 3 ]] ] ];
    Print[ "  ", Length[ status ], " distinct addresses read, ", Round[ AbsoluteTime[ ] - start ], " s" ];
    (* a status of 0 is a read this machine could not complete in two attempts, not an answer of
       the server; it is reported but does not fail the audit, since the same address reads at 200
       from another client *)
    unread = Select[ resolved, status[ Last @ # ] === 0 & ];
    bad = Select[ resolved, ! MatchQ[ status[ Last @ # ], 0 | 200 ] & ];
    date = DateString[ { "YearShort", "Month", "Day" } ];
    file = FileNameJoin[ { $repository, "Research", "Artifacts", "PacletLinks_" <> date <> ".md" } ];
    report = StringRiffle[ Flatten @ {
      "# Links of the documentation site, " <> DateString[ "ISODate" ],
      "",
      "Every `href` of the served HTML of the resource root and the " <> ToString[ Length[ pages ] - 1 ] <> " pages, and every URL inside the deployed notebooks, resolved to the address a browser fetches and read once. " <>
        ToString[ Length[ status ] ] <> " distinct addresses, " <> ToString[ Count[ status, 200 ] ] <> " at 200, " <> ToString[ Length[ DeleteDuplicates[ bad[[ All, 3 ]] ] ] ] <> " failing.",
      "",
      "## Failing links",
      "",
      If[ bad === { }, "None.", { "| status | address | written as | on page |", "|---|---|---|---|",
        Map[ row |-> "| " <> ToString[ status[ row[[ 3 ]] ] ] <> " | " <> row[[ 3 ]] <> " | `" <> row[[ 2 ]] <> "` | " <> row[[ 1 ]] <> " |", bad ] } ],
      "",
      "## Addresses this machine could not read",
      "",
      "A status of 0 is a read that did not complete in two attempts of 90 s, not an answer of the server.",
      "",
      If[ unread === { }, "None.", { "| address | on page |", "|---|---|",
        Map[ row |-> "| " <> row[[ 3 ]] <> " | " <> row[[ 1 ]] <> " |", DeleteDuplicatesBy[ unread, #[[ 3 ]] & ] ] } ],
      "",
      "## Every distinct address",
      "",
      "| status | class | address | pages |", "|---|---|---|---|",
      KeyValueMap[ { url, code } |-> "| " <> ToString[ code ] <> " | " <> LinkClass[ url ] <> " | " <> url <> " | " <> ToString @ Length @ DeleteDuplicates @ Cases[ resolved, { page_, _, url } :> page ] <> " |",
        KeySortBy[ status, { LinkClass[ # ], # } & ] ],
      "" }, "\n" ];
    Export[ file, report, "Text" ];
    Print[ "  written: ", file ];
    Scan[ row |-> Print[ "  !! ", status[ row[[ 3 ]] ], "  ", row[[ 3 ]], "  on ", row[[ 1 ]] ], Take[ DeleteDuplicatesBy[ bad, #[[ 3 ]] & ], UpTo[ 40 ] ] ];
    Scan[ row |-> Print[ "  ?? unread  ", row[[ 3 ]], "  on ", row[[ 1 ]] ], DeleteDuplicatesBy[ unread, #[[ 3 ]] & ] ];
    Print[ If[ bad === { }, "ok", "FAILED" ] ];
    bad === { }
  ]

(* a redirect is followed by hand, since the kernel reports the first hop of some chains; the status
   is the one of the address a browser ends at, at most three hops away *)
ReadStatus[ url_String, hops_Integer : 3 ] :=
  Module[ { response, code, location },
    response = Replace[ Quiet @ TimeConstrained[ URLRead[ url, { "StatusCode", "Headers" } ], 90, $TimedOut ], Except[ _Association ] -> <| |> ];
    If[ ! KeyExistsQ[ response, "StatusCode" ],
      response = Replace[ Quiet @ TimeConstrained[ URLRead[ url, { "StatusCode", "Headers" } ], 90, $TimedOut ], Except[ _Association ] -> <| |> ] ];
    code = Lookup[ response, "StatusCode", 0 ];
    location = Lookup[ Association @ Map[ ToLowerCase[ First @ # ] -> Last @ # &, Lookup[ response, "Headers", { } ] ], "location", None ];
    If[ 300 <= code < 400 && StringQ[ location ] && hops > 0,
      ReadStatus[ If[ StringStartsQ[ location, "http" ], location, URLBuild[ { url, location } ] ], hops - 1 ],
      code ] ]

ResolveLink[ page_String, link_String ] :=
  Which[
    StringStartsQ[ link, "#" | "javascript:" | "mailto:" ] || StringContainsQ[ link, "'+" ], None,
    StringStartsQ[ link, "http://" | "https://" ], link,
    StringStartsQ[ link, "paclet:" <> $name <> "/" ], $target <> "/Documentation/" <> $name <> "/" <> StringDrop[ link, StringLength[ "paclet:" <> $name <> "/" ] ] <> ".html",
    StringStartsQ[ link, "paclet:" ], "https://reference.wolfram.com/language/" <> StringDrop[ link, StringLength[ "paclet:" ] ] <> ".html",
    StringStartsQ[ link, "//" ], "https:" <> link,
    StringStartsQ[ link, "/" ], "https://www.wolframcloud.com" <> link,
    True, StringRiffle[ Append[ Most @ StringSplit[ page, "/" ], link ], "/" ]
  ]

LinkClass[ url_String ] :=
  Which[
    StringStartsQ[ url, $target ], "resource",
    StringContainsQ[ url, "reference.wolfram.com" ], "wolfram documentation",
    StringContainsQ[ url, "wolfram.com" | "wolframcloud.com" | "wolframcdn.com" ], "wolfram",
    True, "external"
  ]

DeclareSymbols[ ] :=
  Module[ { symbols, file, info },
    symbols = Sort[ Map[ name |-> $context <> Last @ StringSplit[ name, "`" ],
      Select[ Names[ $context <> "*" ], StringFreeQ[ "`Private`" ] ] ] ];
    If[ symbols === { }, FailStage[ "no symbols in ", $context, ": the built paclet did not load" ] ];
    With[ { undocumented = Complement[ Map[ $context <> Last[ # ] &, Cases[ Pages[ ], { "ref", _ } ] ], symbols ] },
      If[ undocumented =!= { },
        Print[ "  !! ", Length[ undocumented ], " reference pages for symbols the paclet does not export: ",
          StringRiffle[ Take[ undocumented, UpTo[ 5 ] ], ", " ] ] ] ];
    Print[ "symbols: ", Length[ symbols ], " exported, ", Count[ Pages[ ], { "ref", _ } ], " documented" ];
    file = FileNameJoin[ { $built, "PacletInfo.wl" } ];
    info = Get[ file ];
    If[ ! ( Head[ info ] === PacletObject && AssociationQ[ First @ info ] ), FailStage[ "cannot read ", file ] ];
    Put[ PacletObject[ MapAt[
        Replace[ #, { "Kernel", rest___ } :> { "Kernel", Sequence @@ DeleteCases[ { rest }, "Symbols" -> _ ], "Symbols" -> symbols }, { 1 } ] &,
        First @ info, "Extensions" ] ], file ];
    Print[ "built PacletInfo.wl: Symbols declared" ];
    symbols
  ]

ConnectAndLocate[ ] :=
  Module[ { location },
    If[ ! $CloudConnected, CloudConnect[ ] ];
    If[ ! $CloudConnected, FailStage[ "no Wolfram Cloud connection" ] ];
    Print[ "cloud: ", $WolframID ];
    ResourceSystemClient`Private`loadDeployResourceShingle[ ];
    location = DeployedResourceShingle`Private`defaultCloudObjectLocation[ "Paclet", $name ];
    If[ ! MatchQ[ location, _CloudObject ], FailStage[ "the resource system computed no deploy location: ", location ] ];
    If[ First[ location ] =!= $target,
      FailStage[ "this account deploys to ", First[ location ], ", not the expected ", $target,
        ": CloudDisconnect[] and connect as the right account" ] ];
    Print[ "location: ", First[ location ] ];
    location
  ]

(* Every patch below was root-caused against PacletResource's Deploy.m, Notebooks.m and
   Utilities.m for the InfraGeometry deploy and is carried over as it stands. *)
PatchVendor[ symbols_List ] :=
  (
    (* the scrape lints the .wl sources with CodeInspector as an aside; that is the test suite's
       business, and a false Error there would block the deploy *)
    Quiet[
      Unprotect[ DefinitionNotebookClient`Inspectors`PackagePrivate`codeInspectFileQ ];
      DownValues[ DefinitionNotebookClient`Inspectors`PackagePrivate`codeInspectFileQ ] =
        { HoldPattern[ DefinitionNotebookClient`Inspectors`PackagePrivate`codeInspectFileQ[ _ ] ] :> False } ];
    (* DeployedResourceShingle's processshingleData calls htmlFragmentExport, defined nowhere; the
       Details section is already an HTML fragment *)
    If[ DownValues[ DeployedResourceShingle`Private`htmlFragmentExport ] === { } &&
        OwnValues[ DeployedResourceShingle`Private`htmlFragmentExport ] === { },
      DeployedResourceShingle`Private`htmlFragmentExport[ s_String ] := s ];
    (* prefetchURL's throwaway URLRead warm-up prints URLRead::invhttp on a slow fetch *)
    If[ DownValues[ PacletResource`Private`prefetchURL ] =!= { },
      Quiet @ Unprotect[ PacletResource`Private`prefetchURL ];
      PacletResource`Private`prefetchURL[ url_ ] := URLBuild @ URLParse @ url ];
    (* the vendor's progress events only set a notebook-UI variable; print them too *)
    If[ DownValues[ PacletResource`Private`setDNCProgress ] =!= { },
      Unprotect[ PacletResource`Private`setDNCProgress ];
      PacletResource`Private`setDNCProgress[ expr_ ] := ( Print[ "deploy: ", expr ]; DefinitionNotebookClient`$StripeProgressDisplay = expr ) ];
    (* pacletDeclaredSymbols re-resolves the paclet by name, and on a machine with another copy
       registered may read that one's PacletInfo, without Symbols: pin the list being deployed *)
    If[ DownValues[ PacletResource`Private`pacletDeclaredSymbols ] =!= { },
      Quiet @ Unprotect[ PacletResource`Private`pacletDeclaredSymbols ];
      PrependTo[ DownValues[ PacletResource`Private`pacletDeclaredSymbols ],
        HoldPattern[ PacletResource`Private`pacletDeclaredSymbols[ $name ] ] :> symbols ];
      PrependTo[ DownValues[ PacletResource`Private`pacletDeclaredSymbols ],
        HoldPattern[ PacletResource`Private`pacletDeclaredSymbols[ KeyValuePattern[ "Name" -> $name ] ] ] :> symbols ] ];
  )

(* the headless scrape does not capture the definition notebook's hero image, so the image of the
   paclet's "HeroImage" asset is handed to deployExtraPacletWebFiles as an Image expression, which
   deploys it as <target>/HeroImage.png and puts it on the landing page; PureMath's publish.wls does
   the same *)
InjectHero[ ] :=
  With[ { image = Quiet @ Import[ PacletObject[ File[ $built ] ][ "AssetLocation", "HeroImage" ] ] },
    If[ ! ImageQ[ image ], Print[ "  !! no hero image in the built paclet; the landing page gets none" ],
      Quiet @ Unprotect[ PacletResource`Private`deployExtraPacletWebFiles ];
      PrependTo[ DownValues[ PacletResource`Private`deployExtraPacletWebFiles ],
        HoldPattern[ PacletResource`Private`deployExtraPacletWebFiles[ id_,
            data_?( AssociationQ[ # ] && KeyExistsQ[ #, "PacletFile" ] && ! KeyExistsQ[ #, "HeroImage" ] & ), root_, opts___ ] ] :>
          PacletResource`Private`deployExtraPacletWebFiles[ id, Append[ data, "HeroImage" -> image ], root, opts ] ];
      Print[ "hero: ", ImageDimensions[ image ] ] ] ]

ReportBlockers[ notebook_NotebookObject ][ result_ ] :=
  (
    If[ ! MatchQ[ result, _ResourceObject ],
      Print[ "deploy: the scrape was blocked; definition notebook issues:" ];
      Scan[ issue |-> Print[ "  [", Lookup[ issue, "Level", "?" ], "] ", Lookup[ issue, "Tag", "?" ] ],
        Replace[ Quiet @ Check[ Normal @ DefinitionNotebookClient`CheckDefinitionNotebook[ notebook ], { } ], Except[ _List ] -> { } ] ] ];
    result
  )

ScrapeAndDeploy[ location_CloudObject ] :=
  Module[ { start = AbsoluteTime[ ], result, url },
    Print[ "" ];
    Print[ "scrape and deploy (", $deployTimeout, " s window)" ];
    result = UsingFrontEnd @ TimeConstrained[
      Enclose @ Module[ { notebook },
        notebook = ConfirmMatch[ NotebookOpen[ $definition, Visible -> False ], _NotebookObject, "opening the definition notebook failed" ];
        (* warm up: the definition notebook resolves its paclet relative to its own directory, and
           a freshly opened one misses until these have each run once *)
        PacletObject[ $name ];
        Quiet[ PacletResource`DefinitionNotebook`ScrapePacletDirectory[ notebook ] ];
        WithCleanup[
          Module[ { resource },
            resource = ConfirmMatch[
              ReportBlockers[ notebook ] @ DefinitionNotebookClient`ScrapeResource[ "Paclet", notebook, Interactive -> False, "FailureCondition" -> "Error" ],
              _ResourceObject, "scraping the resource from the definition notebook failed" ];
            Print[ "deploy: scraped ", resource[ "Name" ], " in ", Round[ AbsoluteTime[ ] - start ], " s" ];
            If[ TrueQ[ $scrapeOnly ],
              Print[ "scraped keys: ", Keys[ First[ resource ] ] ];
              Scan[ key |-> Print[ "  ", key, ": ", Short[ Lookup[ First[ resource ], key, Missing[ ] ], 2 ] ],
                { "LongDescription", "Details", "HeroImage", "MainGuidePage", "ExampleNotebook" } ];
              NotebookClose[ notebook ];
              Exit[ 0 ] ];
            With[ { object = CloudDeploy[ resource, location, Permissions -> "Public" ] },
              ResourceRegister[ resource, "Cloud", "StoreContent" -> False ];
              object ] ],
          NotebookClose[ notebook ] ] ],
      $deployTimeout, $TimedOut ];
    url = FirstCase[ { result }, c_CloudObject :> First[ c ], Missing[ ], Infinity ];
    If[ MissingQ[ url ],
      Which[
        result === $TimedOut, FailStage[ "deploy timed out after ", $deployTimeout, " s" ],
        FailureQ[ result ], FailStage[ "deploy failed: ", result[ "Message" ] ],
        True, FailStage[ "deploy returned no URL: ", Short[ result, 3 ] ] ] ];
    Print[ "deployed: ", url, " (", Round[ AbsoluteTime[ ] - start ], " s)" ];
    url
  ]

(* wolframscript otherwise prints a progress line per tick of every cloud call *)
$ProgressReporting = False;

(* DocumentationBuild's RewriteHyperlinkString takes the last character of a possibly empty
   hyperlink segment; the message is noise and the output is right. *)
Off[ StringTake::take ];

PublishDocs[ Drop[ $ScriptCommandLine, UpTo[ 1 ] ] ]
