# REA Investigation Prompts (REAP) — Reverse Engineering with your Coding Agent

A curated collection of prompts for [REA (Reverse Engineer Anything)](https://rea.tools/) — the toolset that lets your AI coding agent inspect how software works, from native binaries, firmware and kernels to games, Electron apps, APKs and websites.

Prompts are ready to paste into your agent. Replace everything in `<angle brackets>` and keep each request focused on **one feature** — narrow questions get evidence-backed answers.

## Star History

<a href="https://www.star-history.com/?repos=joasasantos%2Frea-prompts&type=date&legend=top-left">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/chart?repos=joasasantos/rea-prompts&type=date&theme=dark&legend=top-left" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/chart?repos=joasasantos/rea-prompts&type=date&legend=top-left" />
   <img alt="Star History Chart" src="https://api.star-history.com/chart?repos=joasasantos/rea-prompts&type=date&legend=top-left" />
 </picture>
</a>

## Install as agent skills (recommended)

`setup.sh` (macOS/Linux) or `setup.bat` (Windows) copies every prompt section into your coding agent's skills folder (`~/.hermes/skills`, `~/.claude/skills`, `~/.codex/skills`, or `~/.gemini/config/skills` for Antigravity):

```bash
./setup.sh              # auto-detect installed agents
./setup.sh antigravity  # or: hermes | claude-code | codex | antigravity | all
```

```bat
setup.bat           :: Windows
```

What you get:

- **`Skills/`** — 26 skill packs, one folder per section (`reap-00-install-and-verify` … `reap-22-go-and-rust-binary-source-recovery`, plus `reap-prompts` index, `reap-wildcard` and `reap-prompt-writing-tips`), each a `SKILL.md` with YAML frontmatter the agent auto-loads when relevant.
- **`system_prompt.md`** — the whole library as a single document you can paste into any agent's system prompt / custom instructions instead of installing skills.
- **`tools/build_skills.py`** and **`tools/build_system_prompt.py`** — regenerate `Skills/` and `system_prompt.md` from `readme.md` (the setup scripts run them automatically; `readme.md` stays the source of truth).

## Sources & credits

- **REA tools & guides:** https://rea.tools/
- **Official prompt gallery:** https://madewithrea.com/prompts
- **Intro thread ("REA is the most dangerous thing on the internet right now")** by codila — https://x.com/0xCodila/status/2109623431763292649
  (quoting Matthew Berman — https://x.com/MatthewBerman/status/2108245653843509415)
- **REAP Name** by https://x.com/zazencodes?s=11
## Table of contents

| # | Section |
|---|---------|
| 0 | [Install & verify](#0-install--verify) |
| 1 | [Getting started](#1-getting-started) |
| 2 | [Feature tracing (any program)](#2-feature-tracing-any-program) |
| 3 | [Native binary exploration](#3-native-binary-exploration) |
| 4 | [Software & feature cloning](#4-software--feature-cloning) |
| 5 | [Games](#5-games) |
| 6 | [Game portability to WASM](#6-game-portability-to-wasm) |
| 7 | [Firmware & embedded](#7-firmware--embedded) |
| 8 | [Android](#8-android) |
| 9 | [Kernel analysis](#9-kernel-analysis) |
| 10 | [Vulnerability research](#10-vulnerability-research) |
| 11 | [Electron & JavaScript](#11-electron--javascript) |
| 12 | [Anti-cheat & protection research](#12-anti-cheat--protection-research) |
| 13 | [DMA & hardware-assisted cheat research (defensive)](#13-dma--hardware-assisted-cheat-research-defensive) |
| 14 | [Software cracking research](#14-software-cracking-research) |
| 15 | [Version comparison & crash work](#15-version-comparison--crash-work) |
| 16 | [Long-running investigations](#16-long-running-investigations) |
| 17 | [Malware analysis](#17-malware-analysis) |
| 18 | [Advanced binary exploration & deobfuscation](#18-advanced-binary-exploration--deobfuscation) |
| 19 | [Kernel & driver exploitation research](#19-kernel--driver-exploitation-research) |
| 20 | [Advanced software cloning & feature reconstruction](#20-advanced-software-cloning--feature-reconstruction) |
| 21 | [Protector & obfuscator research](#21-protector--obfuscator-research) |
| 22 | [Go & Rust binary source recovery](#22-go--rust-binary-source-recovery) |
| — | [Wildcard prompt](#wildcard-prompt-start-here) · [Prompt-writing tips](#prompt-writing-tips-why-these-work) · [Next steps](#next-steps-see-what-people-built-with-rea) |

> ⚠️ **Use responsibly.** Only analyze software you own or are explicitly authorized to test. Anti-cheat, DMA, DRM, kernel and vulnerability prompts below are for **security research, interoperability, CTFs, bug bounties and testing the protection of your own software**. Bypassing protection of software you don't own, cheating in online games, or weaponizing a found vulnerability may violate law and terms of service. Every prompt asks the agent to separate *confirmed facts* from *hypotheses* and to cite evidence — treat that as non-negotiable.

---

## 0. Install & verify

```text
Install REA and connect it to this agent using: npx rea-agents@latest setup

First, show me the installation plan and the configuration changes for my
approval. After the install, verify the connection and list the available
tools and workflows.
```

---

## 1. Getting started

### First exercise — trace a CSV export

```text
Download https://rea.tools/examples/notes-example.zip into a new folder and
extract the contents.

Use REA to investigate what happens when I click "Export notes". Trace the
flow from the button to the file write.

Show where notes.csv is created, which fields it contains, and the files and
functions that prove each step.
```

### First look at an unfamiliar app

```text
Use REA to give me a map of <program>: its main parts, entry points and the
three features worth investigating first. Keep it short and point to evidence
for each claim.
```

---

## 2. Feature tracing (any program)

### Explain one feature

```text
Use REA to investigate how <FEATURE> works in <PATH TO APPLICATION>.

Identify the entry point, the functions involved, the data flow, the
dependencies and the observable effects.

For every conclusion, present evidence: file, function, address or relevant
snippet. Separate confirmed facts, inferences and points that remain unknown.

Do not execute the application in this step.
```

### Trace a button to its effect

```text
Use REA on <app>. Start at the <button name> button and trace what happens
until the result is written, sent or shown. Name every module or function on
the path and what each one does.
```

### Recover a rule and rebuild it

```text
Use REA to find the rule that controls <behaviour> in <program>. Write the
rule in plain words, then build a minimal standalone version I can run, and
give me one input that proves it matches the original.
```

---

## 3. Native binary exploration

### Understand an executable

```text
Analyze <PATH TO EXECUTABLE> with REA.

Identify format, architecture, runtime, libraries, relevant strings and
possible entry points.

Map the main components and explain their responsibilities with evidence.
State which analysis engine is available and its limitations.

Start with static analysis.
```

### Function deep-dive

```text
Use REA on <binary>. Pick the function that handles <operation> and produce:
decompiled pseudocode, its callers and callees, the data structures it reads
or writes, and every string/global it touches. Annotate each finding with the
address range that proves it.
```

### Imports, strings and triage map

```text
Use REA on <binary>. Produce a triage map: file format and architecture,
section layout, linked libraries and imports grouped by capability (network,
filesystem, crypto, process/thread, registry/IPC), interesting strings with
their addresses, and the top candidate entry points for <FEATURE>. Flag any
signs of packing, obfuscation or control-flow flattening.
```

### File-format reverse engineering

```text
Use REA on <program> to work out how it reads and writes <file type>.
Describe the structure field by field, show where each field is parsed, and
write a small reader that prints a sample file.
```

### Protocol / serialization extraction

```text
Use REA on <binary> to recover the wire format used for <feature>'s network or
IPC traffic. Show the marshal/unmarshal functions with addresses, list every
field (size, endianness, encoding), and produce a Python struct/proto
definition plus one example message built from the code's constants.
```

---

## 4. Software & feature cloning

> Clean-room methodology: extract *behavior*, not code. Never copy
> proprietary source, assets, branding or licensing mechanisms.

### Full application clone (behavioral)

```text
Use REA to study <application> as a black box for a clean-room clone.

Produce CLONE_SPEC.md covering: every user-visible feature, screen and state
machine; inputs, outputs and edge cases; file formats and network protocols it
uses; settings and persistence layout; error behaviors.

For each requirement, cite the evidence (function, address, string, captured
request). Mark anything unconfirmed as UNKNOWN. Do not copy code or assets —
I will implement from the spec only.
```

### Clone one feature into my own app

```text
Use REA to recover the exact behavior of <FEATURE> in <application>: trigger,
inputs, processing steps, outputs, side effects and failure modes.

Then implement <FEATURE> from scratch in <MY LANGUAGE/PROJECT> matching that
behavior, with tests derived from the recovered rules. List every observable
difference that remains between my version and the original.
```

### Validate a clone against the original

```text
Compare <MY IMPLEMENTATION> with the observed behavior of <ORIGINAL
APPLICATION>.

Use verify_reconstruction, if available. Check results, errors, limits and
state transitions.

Present passing cases, divergences and behaviors not yet tested. Do not
consider equivalence demonstrated just because a few examples passed.
```

### UI/UX behavior cloning without assets

```text
Use REA on <application> to document its interaction model: layout logic,
keyboard shortcuts, command dispatch, undo/redo semantics and clipboard
formats. Recreate the behavior in <my framework> using only my own visual
assets, matching the documented semantics. Show which original function
proves each documented rule.
```

---

## 5. Games

### Gameplay logic recovery

```text
Use REA to reconstruct <GAME> from its executable. Recover the gameplay logic
in C and test it against the original.

For each mechanic (movement, physics, scoring, spawning), show the function,
the constants and the update loop that prove the rule.
```

### Speed / difficulty rule (dino-style)

```text
Use REA to inspect <game>. Why does <difficulty/speed> change over time? Show
the exact rule and the constants behind it, then build a small standalone
version with an adjustable parameter.
```

### Engine & asset pipeline map

```text
Use REA on <game executable/data folder>. Identify the engine or framework,
the render loop, the update/tick order, how levels and assets are loaded and
serialized, and where gameplay data lives (tables, scripts, archives). Map
each component to functions/addresses and describe the load pipeline step by
step.
```

### Single-player mod support (offline only)

```text
Use REA on <offline single-player game> to locate the code that controls
<weapon stats / spawn rates / economy>. Show the data tables or functions with
addresses. I only want to understand where the values live so I can build my
own offline trainer for personal experimentation — no multiplayer, no
persistence tricks.
```

---

## 6. Game portability to WASM

### Port a native game to the browser

```text
Use REA to analyze <game executable/source> as a portability target for WASM.

Map: the main loop and frame pacing, the rendering backend (OpenGL/DirectX/
SDL/Vulkan calls), filesystem and save paths, threading model, audio output,
input handling, and any platform-specific APIs or inline assembly.

For each, classify as: portable as-is / needs shim / must be rewritten. Cite
the functions and call sites that prove each classification.
```

### Build the port plan

```text
Based on the REA findings for <game>, produce a WASM port plan:
- toolchain choice (Emscripten or manual recompile) and required shims
  (GL→WebGL, SDL→SDL2-compat, pthreads→SharedArrayBuffer/threads);
- the minimal set of source modules to compile;
- how saves move to IndexedDB and assets to fetch/streaming;
- performance risks found in the native code (allocation per frame, busy
  loops, 64-bit assumptions) with function evidence;
- a milestone list ending in a playable index.html.
```

### Port the logic core first (headless)

```text
Use REA to isolate <game>'s pure simulation logic (physics, AI, rules) from
rendering and OS calls. Extract the exact rules with evidence, then implement
that logic core in C/Rust compiled to WASM with a test harness that replays
recorded inputs and compares state hashes against the original behavior.
```

---

## 7. Firmware & embedded

### Firmware image triage

```text
Use REA to analyze <firmware image / bin / img>.

Identify the container format, extract partitions/filesystems (JFFS2, SquashFS,
UBI, cramfs...), map each region to architecture and load address, locate the
kernel and rootfs, and list boot entries, init scripts and services.

Show offsets, entropy observations and the evidence for every claim. Start
with static analysis; do not flash or run anything.
```

### MCU / IoT binary analysis

```text
Use REA on <firmware blob> for a <ARM Cortex-M / MIPS / AVR / ESP32> target.

Find the vector table and reset handler, reconstruct the memory map from
literal pools and peripheral base addresses, identify the RTOS (FreeRTOS,
Zephyr...) from symbol/string fingerprints, and map the main task loop and
peripheral drivers (UART, SPI, I2C, radio stack) with function addresses.
```

### Embedded protocol & update mechanism

```text
Use REA on <firmware> to recover: the network stack usage (hardcoded IPs,
DNS, MQTT/HTTP endpoints, ports), the OTA update path (download URL, signature
check, flash write), and credential material (keys, default passwords, debug
tokens). For each finding give the function/address and say whether the
behavior is confirmed statically or still a hypothesis.
```

---

## 8. Android

### Audit an APK

```text
Use REA to analyze <PATH TO APK>.

List declared permissions, exported components, analytics/tracking SDKs,
domains found and local storage mechanisms.

For each finding, show the corresponding class, method or file.

Distinguish references present in the code from behaviors actually observed.
Do not conclude that a domain is accessed just because it appears in a string.
```

### Trace a feature through Java/Kotlin and native code

```text
Use REA on <APK> to trace <FEATURE> end to end: UI entry point (Activity/
Fragment/Composable), the Java/Kotlin call chain, any JNI boundaries
(RegisterNatives / native library loads), the .so functions involved, and the
final effect (network call, file write, database row). Show class, method and
offset evidence at every hop.
```

### Storage, crypto and secrets review

```text
Use REA on <APK>. Determine how the app stores <data>: SharedPreferences,
SQLite, files, keystore. Recover any embedded crypto (hardcoded keys/IVs,
obfuscation routines) with the class/method that uses them. State whether
data is encrypted at rest and in transit, with evidence, and list concrete
risks.
```

### Obfuscated / packed app triage

```text
Use REA on <APK> that appears obfuscated or packed. Identify the packer or
protector (string/class fingerprints, loader stub in the native libs), map
what is statically visible vs. deferred to runtime, and propose the minimal
safe steps to reach the real dex/native code for analysis.
```

---

## 9. Kernel analysis

### Driver inspection (Windows / Linux)

```text
Use REA on <driver binary: .sys / .ko>.

Identify the format and target OS version, the entry/init routine, the device
object and driver dispatch table, every IOCTL code with its input/output
buffer validation, the callbacks/notifications it registers, and the memory it
reads or writes outside its own allocations.

Map each finding to function/address evidence. Static analysis only — do not
load the driver.
```

### IOCTL attack-surface enumeration

```text
Use REA on <driver>. Enumerate all control codes handled, and for each:
the handler function, how it validates input/output buffers (probe methods,
size checks, IRQL assumptions), and any copy_to_user/copy_from_user or
memcpy with attacker-controlled length. Rank the handlers by risk with
evidence for the ranking.
```

### Kernel subsystem / syscall behavior

```text
Use REA on <kernel binary or module> to explain how <subsystem/syscall>
processes <input>. Trace from the syscall/dispatch entry to the parsing
functions, show bounds checks (or their absence), the data structures
populated, and error paths. Cite addresses for each step.
```

---

## 10. Vulnerability research

### Trust-boundary audit

```text
Use REA to review the security of <authorized application or binary>.

Prioritize trust boundaries, untrusted input, privileged operations,
credential storage, IPC, file handling and command execution.

For each possible vulnerability, present:
- the input origin and the sensitive operation;
- the code path and existing checks;
- preconditions and impact;
- evidence and uncertainties;
- a proposal for controlled validation.

Do not classify a hypothesis as a confirmed vulnerability without sufficient
evidence.
```

### Sink hunt from untrusted input

```text
Use REA on <binary>. List every place untrusted data enters (network sockets,
files, IPC, command-line, clipboard, URL handlers) and follow each source to
dangerous sinks: memcpy/strcpy with unchecked length, system/exec, dynamic
loading, deserialization, path concatenation. For each source→sink path give
the function chain with addresses and state which validation exists in
between.
```

### Patch diffing (1-day to incomplete-fix hunting)

```text
Use REA to compare <vulnerable version> and <patched version> of <component>.

Diff the security-relevant functions: what check was added, where else in the
binary the same pattern exists without the fix, and whether the fix covers
every caller of the vulnerable routine. Report candidate incomplete-fix
locations with function/address evidence, clearly labeled as hypotheses until
validated in a controlled environment.
```

### Crash triage to root cause

```text
Use REA to investigate this crash in <application>.

Available evidence:
<STACK TRACE, LOGS, DUMP OR REPRO STEPS>

Relate the error to the functions involved, formulate hypotheses and indicate
which evidence supports each one.

Propose the smallest experiment needed to distinguish the hypotheses and
validate the cause.
```

### How is my data handled?

```text
I am allowed to analyse <program>. Use REA to find where it stores or sends
<kind of data>. Show the code paths, say whether the data is encrypted at rest
and in transit, and list concrete risks with evidence.
```

---

## 11. Electron & JavaScript

### Electron app anatomy

```text
Use REA to analyze <PATH TO ELECTRON APP>.

Locate the JavaScript files and any app.asar archives. Map the main and
renderer processes, the preload scripts and the IPC channels.

Then trace <FEATURE> from the UI to its implementation, including network
calls and filesystem operations. Show the evidence.
```

### IPC & contextIsolation security review

```text
Use REA on <Electron app>. Enumerate every ipcMain handler and the channels
exposed via contextBridge/preload. For each channel: what arguments it
accepts, whether it reaches shell.openExternal, child_process, fs, or webview
navigation, and what validation exists. Flag any handler where renderer-
controlled input reaches a privileged sink without checks — with file and
function evidence.
```

### Minified / bundled JS feature tracing

```text
Use REA on <app.asar / bundle.js> to trace <FEATURE> through minified code.
Identify the module boundaries, recover the relevant functions with readable
names, follow the data flow from the UI event to the network/filesystem
effect, and produce a call graph. Cite offsets in the bundle for each hop.
```

### Web feature mapping

```text
Use REA to observe <site> while I use <feature>. List the requests, scripts
and state changes involved, then summarise how the feature works and which
parts run on the client versus the server.
```

### Website clone (structure + behavior)

```text
Use REA to inspect https://<site>/. Recover the page structure, the client
routes, the API calls each view makes and the state management pattern.
Rebuild a functional equivalent with my own assets and styling, matching the
observed behavior. List requests and scripts as evidence per view.
```

### Web app API-surface mapping

```text
Use REA on <web app URL> (authorized testing of an app I own or am permitted
to assess). Enumerate the client's full API surface: every endpoint the
bundled JavaScript calls, HTTP method, request/response shape, auth header or
token source, and where in the bundle each call is made (file + offset).
Group endpoints by feature and flag any that are called from the client but
validated only client-side. Separate endpoints proven in code from ones only
seen in traffic.
```

### Source-map & bundle recovery

```text
Use REA on <web app>. Check for exposed source maps (.map references in the
bundles or 404-then-200 probing of known paths). If maps exist, reconstruct
the original module tree, name the components/functions and map the recovered
sources to the shipped bundles. If they don't, de-minify the hot modules for
<FEATURE> by hand: rename locals, split the bundle into logical modules and
produce a readable equivalent. State clearly which names are recovered from
maps versus inferred.
```

### Auth & token flow analysis (web)

```text
Use REA on <web app> to document its authentication flow end to end: where
the login form posts, how tokens are stored (cookie flags HttpOnly/Secure/
SameSite, localStorage, IndexedDB), refresh/renewal logic in the client code,
and which requests attach the token and how. Give the bundle offset proving
each step. Flag client-side-only authorization checks (UI gating without
server validation) as hypotheses to confirm with controlled requests.
```

### WASM module inside a web app

```text
Use REA on <web app / .wasm module>. Identify the toolchain that produced the
WASM (Emscripten, Rust/wasm-bindgen, Go/WASM), map the exported functions and
their JS callers, recover the linear-memory layout and any embedded strings or
data tables. For <FEATURE>, trace the JS→WASM boundary: arguments crossing,
return values and side effects. Cite export indices and JS call-site offsets.
```

### Browser extension (MV3) audit

```text
Use REA on <extension folder / .crx> I own or am authorized to review.
Enumerate manifest permissions, service worker and content-script entry
points, every host the extension can reach, message-passing channels between
content script / worker / page, and any remote code loading (eval, dynamic
script injection, update endpoints). Map each capability to the file and
function that implements it. Distinguish declared permissions from observed
behavior.
```

### PWA / service-worker offline logic

```text
Use REA on <web app> to recover the service worker's behavior: cache strategy
per resource class (cache-first, network-first, stale-while-revalidate), what
data persists offline (IndexedDB stores and their schemas from the code), and
how queued actions sync when connectivity returns. Show the worker file and
the functions proving each rule.
```

---

## 12. Anti-cheat & protection research

> Scope these at **your own machine, your own software, a vendor bug bounty,
> a CTF, or academic study**. Never at other players' live game sessions.

### Map an anti-cheat's detection surface

```text
Use REA to analyze <anti-cheat driver/service binary> on a lab machine I own.

Identify: what it enumerates (processes, modules, handles, callbacks), which
integrity checks it performs, what it hooks or registers with the kernel, and
what data it sends out (endpoints, intervals, payload fields).

For each finding cite the function/address. Separate "code present" from
"behavior observed". Do not run the target game; static analysis first.
```

### Test my own product's protections

```text
I own <my application> and its protection scheme. Use REA to assess it as an
attacker would: locate the license check, the integrity checks, the
anti-debug/anti-VM tricks, and trace what a failed check does. Report which
checks are trivially bypassable, which are load-bearing, and concrete fixes —
each claim backed by file/function/address evidence.
```

### User-mode anti-cheat DLL anatomy

```text
Use REA on <anti-cheat user-mode DLL/service> from a game I own, on a lab
machine, for defensive research. Map: what it enumerates at startup (loaded
modules, handle counts, window titles, device paths), which hooks it installs
(IAT/EAT, inline, syscall stubs), how it detects debuggers and memory
readers, and how it packages + ships detections (endpoint, payload fields,
hashing of module code sections). For each mechanism give the function/
address and say whether it is confirmed statically or needs runtime
observation. Do not attach to or interfere with a live game session.
```

### DRM / license flow analysis (interoperability)

```text
Use REA on <application> to document its licensing flow: where entitlement is
validated, what local and remote checks exist, what state is stored on disk,
and how offline mode behaves. Goal is interoperability and security review of
software I legitimately own. Report facts with evidence; flag anything you
could not confirm.
```

---

## 13. DMA & hardware-assisted cheat research (defensive)

> DMA attacks are a real anti-cheat and platform-security problem. Use these
> to **study how detection works** and to **harden your own product/lab** —
> on machines you own, offline targets, or with vendor authorization. Reading
> another machine's memory over PCIe without authorization is illegal in most
> jurisdictions.

### How DMA memory access works on a target platform

```text
Use REA on <anti-cheat driver / DMA-protection firmware (e.g. Thunderbolt
security, IOMMU/VT-d config)> in my lab.

Explain, with function/address evidence: how the platform restricts external
PCIe memory reads (IOMMU mappings, Thunderbolt ACLs, kernel DMA protection),
what the anti-cheat enumerates to spot a DMA device (PCIe topology, BAR
regions, unknown root ports, timing anomalies), and which checks are
load-bearing versus cosmetic.
```

### Analyze a DMA-cheat toolchain sample (malware-style)

```text
I have a sample <DMA firmware / PCILeech-style driver / user-mode reader> for
defensive research. Use REA to document: how it opens physical memory
(XNVIPHYSTREE-style access, PCIe BAR mapping), how it locates the game process
(PEB walking, page-table traversal), what it reads/writes, and any
anti-detection tricks (pattern scanning avoidance, timing padding). Give the
function chain with addresses for each stage. Do not run it against any live
game — analysis only.
```

### Detection-gap analysis for my own product

```text
Use REA to evaluate how <my application/my anti-cheat component> would react
to external physical memory access: which integrity checks exist, whether
sensitive values sit in predictable memory, what side-channel validation the
server performs. Propose concrete hardening (value obfuscation, server-side
validation, memory layout randomization) mapped to the code locations that
need each change.
```

### FPGA/microcontroller device firmware study

```text
Use REA on <device firmware dump> from a PCIe/USB device I own. Identify the
MCU/FPGA soft-core, the protocol it speaks to the host, the memory-read
primitives it implements, and how it hides from host enumeration. Show
evidence per claim and label anything that needs runtime confirmation.
```

---

## 14. Software cracking research

> For studying protection schemes, crackmes/CTFs, malware-adjacent RE, and
> hardening your own software. Not a guide to pirate other people's products.

### Keygen-repair style analysis (document, don't bypass)

```text
Use REA on <binary> to find the validation routine for <license key / serial>.
Recover the algorithm (decompile it), identify the input encoding, the
checksum/transform steps and the success/failure branches with addresses.
Then write a test harness that exercises the recovered algorithm against
sample inputs. Do not patch or bypass anything — I want the algorithm
documented, not the check removed.
```

### Crackme / CTF challenge solving

```text
Use REA on this crackme: <path>. Enumerate entry points, strings, imports and
any packer/protection indicators. Identify the flag-checking logic, decompile
it, and derive the correct input from the recovered algorithm. Show the full
evidence chain: address → instruction → conclusion.
```

### Protection-diffing between versions

```text
Use REA to compare <protected app v1> and <v2>. Identify what changed in the
protection layer: new integrity checks, new anti-debug tricks, changed
validation paths. Map each change to functions/addresses and explain the
hardening intent.
```

---

## 15. Version comparison & crash work

### Compare two versions

```text
Use the compare_application_versions workflow, if available, to compare
<OLD VERSION> and <NEW VERSION> of <application>.

Identify functional changes, API changes, dependency and permission changes,
and possible security fixes.

Map each change to the corresponding functions or files and explain the
impact. Differentiate build changes from behavior changes.
```

---

## 16. Long-running investigations

### Continue where you left off

```text
Review the evidence and notes of this investigation.

Use audit_residual_unknowns, if available, to list what has not been
demonstrated yet.

Prioritize the next analyses by how much they can reduce uncertainty. Update
an INVESTIGATION.md file with findings, evidence, discarded hypotheses and
next steps.
```

---

## 17. Malware analysis

> Authorized contexts: your own incident response, a sandboxed lab, threat-intel
> work, or samples you have explicit permission to handle. Never run malware on
> a production machine; these prompts are static-first and ask for runtime
> observation only inside an isolated VM.

### Static triage and capability map

```text
Use REA on this malware sample: <PATH> (collected for authorized incident
response / threat-intel analysis).

Produce a triage report: file type, compiler/packer indicators, first-run
artifacts, imports grouped by malicious capability (persistence, credential
theft, keylogging, screen capture, network C2, process injection, defense
evasion), suspicious strings with addresses, and any embedded configs
(URLs, wallet addresses, mutexes, encryption keys).

For every capability claim, cite the function/address that proves it. Separate
confirmed static findings from behaviors that still need sandbox confirmation.
Do not execute the sample in this step.
```

### C2 protocol and config extraction

```text
Use REA on <malware sample> to recover its command-and-control protocol.

Find the C2 endpoint construction (hardcoded strings, DGA, XOR/base64-encoded
buffers — show the decode routine and its key), the beacon format (fields,
encoding, encryption), the tasking commands the bot accepts and what each one
does, and any fallback infrastructure.

Output: a written protocol spec, a Python parser for a captured beacon if you
have one, and the addresses proving each field. Label anything inferred.
```

### Persistence, injection and evasion inventory

```text
Use REA on <malware sample>. Enumerate every persistence mechanism (registry
Run keys, scheduled tasks, services, startup folder, WMI subscriptions),
every injection technique (CreateRemoteThread, APC, process hollowing, DLL
side-loading) and every evasion trick (anti-VM checks, anti-debug, sandbox
timing checks, sleep evasion, AMSI/ETW patching).

For each: the function/address, the exact API calls used, and the trigger
condition. Rank them by which runs first in the execution flow.
```

### YARA / IOC generation from recovered code

```text
Use REA on <malware sample> and, from the functions you have already located,
generate detection artifacts: YARA rules built on stable code sequences (not
obfuscated strings), a list of file/registry/network IOCs with the addresses
where each appears, and a threat-hunt query outline. Explain why each pattern
is family-stable versus sample-specific.
```

### Family correlation between samples

```text
Use REA to compare <sample A> and <sample B>. Identify shared code: matching
functions (by structure, not just hash), common string-encoding routines,
shared C2 protocol fields, reused constants or PDB paths.

Conclude whether they are the same family, same builder, or unrelated, with
the function-pair evidence behind each claim.
```

### Loader / dropper stage chain

```text
Use REA on <loader sample>. Reconstruct the stage chain: what the first-stage
stub does (process hollowing, DLL side-loading, reflective loading,
APC injection — show the API sequence with addresses), where the second-stage
payload comes from (embedded blob offset, download URL, decode routine), and
how integrity/decryption of the payload is verified before transfer of
execution. Deliver a stage diagram: stage → mechanism → artifact → evidence
address. Do not execute the sample.
```

### Sandbox-evasion decision tree

```text
Use REA on <malware sample>. Find every environment check that gates
execution: VM/GPU/CPU fingerprinting, disk-size and MAC-prefix checks,
debugger and analysis-tool enumeration, timing-based sleep inflation,
human-interaction probes (mouse jitter, cursor checks). Map each check to the
branch it controls and the threshold constants it compares against, with
addresses. Produce a decision tree: which conditions must hold for the
payload to run — useful for building a detonation environment, not for
evasion.
```

### Ransomware / wiper behavior documentation (defensive)

```text
Use REA on <ransomware sample> for authorized incident response. Document the
encryption routine as code: algorithm and mode (from API calls or embedded
primitives), key generation and where the key/material leaves (C2, embedded,
discarded), file-targeting rules (extension allow/deny lists, path exclusions
with addresses), shadow-copy and backup destruction calls, and ransom-note
generation logic. Deliver an IOC + behavior report with evidence per claim;
do not attempt key recovery or decryption.
```

---

## 18. Advanced binary exploration & deobfuscation

### Control-flow flattening recovery

```text
Use REA on <binary>. The function(s) handling <FEATURE> appear
control-flow-flattened (dispatcher state variable, giant switch/branch chain).

Identify the state variable, map each state to its real block, and reconstruct
the original logical flow as pseudocode or a graph. Show the address ranges for
the dispatcher, the states, and the reconstructed sequence. Note which parts
remain ambiguous.
```

### String and constant decryption pass

```text
Use REA on <binary>. Locate the string-decryption routine(s) (per-call
decoding, single init loop, or lazy decryption), recover the algorithm and
keys with addresses, then produce a decrypted string table: offset, encoded
form, decoded form, and the function(s) that reference each string. If the
scheme is uniform, write a script that reproduces the decryption offline.
```

### Opaque predicates and dead-code stripping

```text
Use REA on <binary> around <function/address range>. Identify opaque
predicates (always-true/false branches built from constant arithmetic or
self-referencing checks) and dead code inserted to mislead analysis.

For each: the address, why it is provably constant, and which branch is real.
Produce a cleaned control-flow view of the function with the noise removed,
keeping the evidence for every removal decision.
```

### Virtualized / threaded code identification

```text
Use REA on <binary>. Determine whether <function> is native or runs inside a
VM-style handler (opcode dispatch loop, context structure, handler table).

Map the handler table: opcode → handler address → operation class (load,
store, arithmetic, branch, call). Estimate how many distinct opcodes exist and
which original operations you can already recognize. Do not attempt to defeat
the protection — I want the structure documented first.
```

### Mixed-mode binary: managed + native boundary

```text
Use REA on <application> that mixes .NET/Java managed code with native
libraries. Locate every P/Invoke, JNI, or COM boundary relevant to <FEATURE>,
trace the call from managed code into the native function and back, and
document what data crosses each boundary in what form. Cite managed
method tokens/names and native addresses for each hop.
```

### Struct & type recovery from access patterns

```text
Use REA on <binary>. Pick the structure that <function> operates on and
reconstruct it field by field: every access offset in the code proves a
field's position, and the width of each load/store proves its size. Infer
field semantics from how each is used (counter, pointer, flag, length,
callback). Emit a C header with recovered struct definitions, named fields
and a comment per field citing the address range that proves it. Propose
type annotations I can load into the decompiler.
```

### Calling-convention & stack-frame reconstruction

```text
Use REA on <binary> around <function/address>. The decompiler mis-models
this function. Reconstruct the real frame: prologue/epilogue, saved
registers, local slots, stack canary handling, and the argument registers/
stack slots at entry. Determine the calling convention from how callers pass
arguments and how the callee cleans the stack. Rewrite the signature and
re-decompile with the corrected frame; show the instruction evidence for each
frame slot.
```

### Cross-binary function matching (diffing two builds)

```text
Use REA to match functions between <binary v1> and <binary v2> of the same
program. Use structural similarity (CFG shape, instruction counts, call
graph, string/global references), not just hashes, so compiler reordering
doesn't break the mapping. Produce a matched-pairs table with confidence,
then list the functions that changed most between versions and what the
change appears to be (added check, new branch, refactored loop) with
addresses on both sides.
```

---

## 19. Kernel & driver exploitation research

> Authorized contexts only: your own vulnerable driver, a CVE you are validating
> for a bug bounty, a CTF kernel challenge, or defensive hardening review.
> "Exploitation research" here means proving reachability of a flaw and
> documenting the primitive — not building public weaponized exploits.

### Vulnerable-driver primitive analysis (BYOVD-style, own driver)

```text
Use REA on <driver .sys> that I own/am authorized to assess (e.g. a known
vulnerable driver used in my lab).

Document the read/write primitive: which IOCTL gives arbitrary physical or
virtual memory R/W, exactly how the handler validates (or fails to validate)
the input buffer, the struct layout the driver expects, and the shortest
reproducible sequence that demonstrates the primitive against my own test
buffer. Give handler addresses and the missing check that makes it possible.
```

### CVE reachability validation on a patched build

```text
Use REA on <kernel binary / module version X> to check whether the fix for
<CVE-ID> is complete for this build.

Locate the patched function, verify the added check exists and covers every
caller path that reaches it, then search the rest of the binary for the same
unchecked pattern (similar copy, same struct, different entry point). Report:
fix present/absent, any bypass path found, and any sibling location still
missing the check — each labeled hypothesis vs confirmed, with addresses.
```

### Race condition / TOCTOU hunt in a driver

```text
Use REA on <driver>. Find handlers that touch shared state (global buffers,
device extension fields, linked lists) from multiple IRQLs or concurrent IOCTLs.

Identify where a check and the subsequent use are separated without a lock or
atomic reference (TOCTOU), or where a use-after-free window opens between
close/unload and a pending operation. For each candidate: the two racing code
paths with addresses, the shared object, and the smallest controlled test that
would confirm or refute the race.
```

### Kernel attack-surface ranking

```text
Use REA on <kernel module / driver>. Enumerate every user-reachable entry point
(IOCTLs, syscalls, netlink/socket handlers, minifilter callbacks), and for each
record: input validation depth (probe method, size checks, pointer
dereference), state it touches, and privilege context.

Rank the entry points by exploitable-risk with evidence for the ranking, and
name the top 3 worth a deeper source-level or crash-driven look.
```

### Windows/Linux kernel structure recovery

```text
Use REA on <kernel image / driver>. Reconstruct the key data structures used by
<subsystem>: field-by-field layout inferred from access offsets in the code,
with the address of every access that proves each field's offset and width.
Annotate the decompiler output with recovered struct names and types.
```

### Reference-count / lifetime bug hunt (UAF candidates)

```text
Use REA on <driver / kernel module>. For every object type that is allocated
and later freed (look for the alloc/free or ref-count increment/decrement
pairs), trace whether any code path can use the object after its last
release: missing reference taken before storing a pointer, decrement-then-use
ordering, callbacks registered without a hold. For each candidate: the
alloc/free/use address triple, the path that reaches the stale use, and the
smallest controlled test that would confirm it. Label every finding as
hypothesis until validated.
```

### Windows syscall / SSDT surface walk

```text
Use REA on <ntoskrnl / win32k image or a documented syscall number> to
explain how <NtUserXxx/NtXxx> handles attacker-controlled arguments: the
entry stub, parameter validation (probe, capture, alignment), the user-mode
structures it reads, and the kernel objects it touches. Show the dispatch
path with addresses and flag any argument that reaches a sensitive operation
without a visible check. Static analysis only.
```

---

## 20. Advanced software cloning & feature reconstruction

> Clean-room rules unchanged: extract behavior and interfaces, never code,
> assets, branding or licensing mechanisms. Interoperability and research use.

### Full protocol reimplementation for interoperability

```text
Use REA on <application> to recover its <network protocol / file format>
completely enough to interoperate: every message or record type, field
layouts, endianness, state machine transitions, handshake/auth sequence,
error codes and keep-alive behavior.

Deliver: a machine-readable spec (JSON Schema or protobuf), a working
client/server implementation in <language> that speaks the recovered protocol
against the original application, and a test log proving each message type
round-trips. Cite the marshal/unmarshal functions with addresses for every
field. Mark anything untested as UNKNOWN.
```

### Algorithm extraction to a standalone library

```text
Use REA on <application>. Isolate the pure algorithm behind <feature> (its
math, tables, constants and edge-case handling) from all UI, I/O and platform
code. Reimplement it from scratch in <language> as a library with a public API
matching the observable behavior, then run a differential test: same inputs
through original and clone, compare outputs across normal, boundary and
malformed cases. Report the match rate and every divergence.
```

### State machine / business-logic reconstruction

```text
Use REA on <application> to document the state machine governing <workflow>:
enumerate states (from enums, flags, or dispatch tables with addresses),
transitions, guards, and side effects per transition. Render it as a diagram
plus a table, then implement the same machine in <my project> and write tests
that replay every transition you documented.
```

### Plugin/extension ABI reconstruction

```text
Use REA on <host application> to recover its plugin interface: the exported
functions a plugin must provide, the callback table the host passes in, the
struct versions, and how plugins are discovered and loaded. Build a minimal
working plugin for my own feature using only the recovered ABI, and document
each ABI element with the address that proves it.
```

### Behavioral equivalence harness

```text
Build a differential-testing harness between <MY CLONE> and <ORIGINAL
APPLICATION>: derive the observable-behavior matrix from the CLONE_SPEC.md
already produced (inputs, outputs, errors, state transitions, file formats),
run both sides against the same corpus, and emit a divergence report. Do not
declare equivalence from spot checks — the report must cover every spec item,
with PASS / FAIL / NOT-TESTED per item.
```

---

## 21. Protector & obfuscator research

> Scope: protectors on **software you own** (hardening assessment), malware
> samples, crackmes/CTFs, or vendor-authorized research. These prompts ask the
> agent to *identify, characterize and document* protections and to plan
> analysis — not to produce weaponized bypasses of third-party commercial
> software.

### Protector fingerprinting

```text
Use REA on <binary>. Determine whether it is protected/packed and by what:
UPX (section names, entry stub, low entropy after unpacking), VMProtect/Themida
(.vmp/.themida sections, huge virtualized functions, handler tables), Arxan
(embedded watermark checks, code mutation markers), .NET obfuscators
(SmartAssembly/GuardSquare-style renamed types, control-flow-encoded methods),
Android packers/hardening (Appdome/WhiteCrypt-style native stubs, extra .so
loaders, DexGuard string encryption).

Report: which protector(s), the version indicators you can see, which sections
are original vs. synthetic, and which code regions are protected versus plain.
Cite section headers, addresses and string fingerprints for each conclusion.
```

### UPX / simple packer: unpack-and-verify

```text
Use REA on <packed binary>. Confirm the packer (UPX header, stub
characteristics), then produce the unpacked image: either a clean static
unpack or the reconstructed original sections from the runtime layout. Verify
the result — entry point, imports rebuilt, section entropy — and diff the
unpacked binary's capability map against the packed one so nothing was lost.
Document each step with addresses.
```

### VMProtect / Themida region mapping (own software or CTF)

```text
Use REA on <binary I own or a crackme> that uses VM-style protection.

Map the protection surface without trying to defeat it: locate the VM entry
stubs, the context structure, the handler dispatch table, and classify which
functions are virtualized versus native. For the virtualized regions, estimate
the opcode set size and identify handlers you can already recognize (memory
read/write, arithmetic, branch). Deliver a coverage map: function → protected
or plain → confidence, with evidence. This map is the input for a later
deobfuscation plan, not a bypass.
```

### Anti-debug / anti-VM / anti-tamper inventory

```text
Use REA on <binary> to inventory its self-protection checks: anti-debug
(Peek/Push/IsDebuggerPresent, timing checks, hardware-breakpoint flags),
anti-VM (registry/firmware artifacts, MAC/vendor strings, CPUID tricks),
integrity checks (self-hashing regions, CRC tables), and tamper responses
(silent flags vs. crash vs. report-to-server).

For each check: the function/address, what triggers it, and what happens on
failure. Then — for software I own — state which checks are load-bearing for
security and which are cosmetic, with recommended fixes.
```

### Appdome / WhiteCrypt / Proton Shield-style mobile hardening study

```text
Use REA on <APK/AAB> that uses a commercial hardening layer (Appdome-style
runtime protection, WhiteCrypt-style embedded crypto, DexGuard/GuardSquare-style
Java obfuscation).

Document: where the hardening stub lives (loader .so, injected classes, manifest
hooks), what it wraps (DEX decryption, string decryption, root/hook/emulator
detection), which original classes are deferred to runtime, and what remains
statically analyzable. Identify the detection callbacks the protection exposes
to the app. Give file/class/address evidence per finding and label anything
that needs dynamic confirmation in an isolated lab device.
```

### Arxan-style watermark & mutation analysis

```text
Use REA on <binary I own or am authorized to study> suspected of embedding
code-mutation watermarks (Arxan-style per-copy variants).

Identify the mutation sites: instruction-level variants between two builds of
the same function, redundant/mutated code inserted at call sites, and the
verification routine that reads the watermark. Explain how the scheme
distinguishes copies and which regions are watermark-bearing versus real
logic, with addresses for each variant pair. Goal: understand the attribution
mechanism for a security review of my own product.
```

### Protection hardening assessment for my own product

```text
I own <my application> and its protection stack (<protector names>). Use REA to
assess the protection as an attacker would measure it: coverage (what % of
license-critical and security-critical code is actually protected vs. plain),
layered checks (which fail silently vs. loudly), the weakest protected path to
<the feature being protected>, and anti-analysis depth.

Deliver a risk-ranked report: each weakness with function/address evidence,
the protection feature that should have covered it, and a concrete hardening
recommendation. Document weaknesses; do not produce a working bypass.
```

---

## 22. Go & Rust binary source recovery

> Go and Rust ship rich metadata in their binaries (Go: pclntab, moduledata,
> full type/goroutine runtime; Rust: panic strings, `core::` symbols, crate
> names, monomorphized function names). Recovery here means reconstructing
> *structure and logic* — readable pseudocode, package/module layout, type
> definitions — not literally the original `.go`/`.rs` files. Say so honestly
> in the report. Scope: binaries you own or are authorized to analyze.

### Go binary: symbol & package map

```text
Use REA on <Go binary (.exe or Linux ELF) built with Golang>.

Recover the package layout from the pclntab / moduledata: every function
symbol with its full package path (main.*, vendor/*, dependency modules),
the Go version and build ID, and the dependency list embedded in the binary.
Map main.main and main.init to their call graph. Deliver a package tree with
function counts per package and the addresses proving each symbol.
```

### Go binary: function-level logic recovery

```text
Use REA on <Go binary>. For the functions in package <package or main> that
implement <FEATURE>, produce readable pseudocode: recover the Go calling
convention (stack-based args, ABIInternal registers), map defer/panic
handling, goroutine/channel operations (runtime.chanrecv/chansend sites) and
interface dispatch (itab/iface calls). Reconstruct each function's signature
from argument loads and return stores. Cite address ranges per recovered
statement group; separate confirmed logic from inference.
```

### Go binary: type & struct reconstruction

```text
Use REA on <Go binary>. Walk the Go type metadata (runtime.types / itab
tables) reachable from <FEATURE>'s code path and reconstruct the struct
definitions: field offsets, widths and likely types from how each field is
accessed, plus interface method sets from itabs. Emit Go-style type
declarations with a comment citing the metadata address that proves each
field. Note where GC bitmaps or padding make a field uncertain.
```

### Rust binary: crate & symbol map

```text
Use REA on <Rust binary (.exe or Linux ELF)>. Identify the Rust version and
profile (debug vs release: presence of panic-location strings, `core::fmt`
shims) from embedded metadata and panic strings. Enumerate crate names from
symbol paths and panic locations (file paths leaked in `#[track_caller]`
strings), map monomorphized generics back to their generic parents, and
produce a crate/module tree with the addresses proving each entry.
```

### Rust binary: logic recovery with trait-dispatch awareness

```text
Use REA on <Rust binary>. For the functions implementing <FEATURE>, produce
readable pseudocode that accounts for Rust idioms: Result/Option propagation
(branch-on-discriminant patterns), drop glue and ownership transfers,
vtable-based trait-object dispatch (recover the vtable at its data address
and name each slot), iterator adapters (inlined loop state machines), and
panic/fmt call sites as string anchors. Reconstruct signatures from the
Itanium/mangling where symbols survive; where stripped, infer from register
usage. Cite addresses per claim and mark inferred names as hypotheses.
```

### Stripped Go/Rust binary: metadata-first triage

```text
Use REA on <stripped Go or Rust binary>. Before touching code, extract what
survives stripping: Go pclntab still yields full function names and line
tables even after `strip`/`-ldflags -s -w` (locate the tab via runtime
pointers and rebuild the symbol table); Rust panic strings and file paths
still name crates and source files. Rebuild the function-name → address map
from whichever metadata is present, then start the <FEATURE> trace from the
recovered names. Report exactly which metadata you found and what is
irrecoverably gone.
```

### Binary-to-source fidelity report

```text
Based on the REA findings for <Go/Rust binary>, write a RECOVERY_REPORT.md:
for each recovered module, state whether the reconstruction is (a) symbol-
exact (names from metadata), (b) structure-exact (types/fields proven by
access offsets), or (c) behavior-only (pseudocode with inferred names).
Include the reconstructed source tree layout, per-file confidence level, and
the evidence addresses behind each classification. Do not present inferred
code as the original source.
```

---

## Wildcard prompt (start here)

```text
Use REA to understand how <FEATURE> works in <PATH TO APPLICATION>.

Check first which tools are actually available. Start with static analysis
and trace the feature down to the responsible functions.

Present evidence for each conclusion, separate facts from hypotheses, and
record the limitations. At the end, generate a behavioral specification and
propose tests to verify it.
```

---

## Prompt-writing tips (why these work)

1. **One feature per prompt.** Broad "explain the whole app" questions return shallow maps; narrow ones return call chains and addresses.
2. **Demand evidence.** Every prompt here requires file/function/address citations — it stops the agent from confabulating.
3. **Separate fact / inference / unknown.** The three-bucket format keeps hypotheses honest.
4. **Static first.** Say "do not execute the application" until you actually need runtime observation.
5. **End with a deliverable.** SPEC.md, a reader script, a port plan, a minimal rebuild — a concrete artifact forces the agent to verify its own claims.
6. **State the scope out loud.** "Lab machine I own", "offline single-player", "document, don't bypass" — the framing keeps results usable for research and reporting.

## Next steps: see what people built with REA

Ran one of these prompts? See what others are doing with REA at **[madewithrea.com](https://madewithrea.com)**, a community directory of REA investigations, rebuilds, integrations and tools, sorted by use case (native binaries, Android, games, firmware, Electron and more).

- Browse real builds for ideas on what to point REA at next.
- Built something with a prompt from this repo? [Submit the link](https://madewithrea.com/submit) to get it listed.

## License

Prompts in this repo: MIT. REA itself and its docs: see https://rea.tools/.
