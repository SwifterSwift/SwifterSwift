#!/bin/bash
#
# Checks that every extension follows the structural rules in CONTRIBUTING.md: one self-contained public member per
# file, no shared declarations, no crashes, a matching test file, and the standard header.
#
# Usage, from the repository root:
#
#     scripts/check-structure.sh
#
set -u
cd "${1:-.}"

problems=0
report() {
    local title=$1
    local matches=$2
    if [ -n "$matches" ]; then
        echo "✗ $title"
        printf '%s\n' "$matches" | sed 's/^/    /'
        problems=$((problems + $(printf '%s\n' "$matches" | wc -l)))
    else
        echo "✓ $title"
    fi
}

sources() { find Sources -name '*.swift' -not -path 'Sources/SwifterSwift/*' | sort; }

report "No typealiases" \
    "$(sources | xargs grep -nE '^\s*(public |internal |private |fileprivate )?typealias ')"
report "No operator or precedence group declarations" \
    "$(sources | xargs grep -nE '^\s*(prefix |postfix |infix )?operator |^\s*precedencegroup ')"
report "No operator implementations" \
    "$(sources | xargs grep -nE 'static (prefix |postfix )?func [^a-zA-Z_( ]')"
report "No type declarations" \
    "$(sources | xargs grep -nE '^\s*(public |internal |private |fileprivate |final )*(struct|class|enum|protocol|actor) [A-Z]')"
report "No private or fileprivate helpers" \
    "$(sources | xargs grep -nE '^\s*(private|fileprivate) ')"
report "No fatalError, preconditionFailure or try!" \
    "$(sources | xargs grep -nE 'fatalError\(|preconditionFailure\(|try!')"
report "No protocol conformances" \
    "$(sources | xargs grep -nE '^(public )?extension [A-Za-z.<>]+ ?: ')"
report "At least one public extension per file" \
    "$(for f in $(sources); do [ "$(grep -cE '^public extension ' "$f")" -lt 1 ] && echo "$f"; done)"
# A file may split one member's overloads across constrained extensions (for example, Equatable and Hashable
# elements), but it must declare a single member name.
report "One member name per file" \
    "$(for f in $(sources); do
        names=$(grep -oE '^    (@[A-Za-z]+(\([^)]*\))? )*(public )?(static |class |mutating |nonmutating |convenience )*(func [A-Za-z_][A-Za-z0-9_]*|var [A-Za-z_][A-Za-z0-9_]*|init|subscript)' "$f" \
            | sed -E 's/.*(func|var) //; s/.*(init|subscript)$/\1/' | sort -u)
        [ "$(printf '%s\n' "$names" | grep -c .)" -gt 1 ] && echo "$f: $(printf '%s ' $names)"
    done)"
report "No get-prefixed function names" \
    "$(sources | xargs grep -nE 'func get[A-Z0-9]')"
report "No DocC symbol links (double backticks), which break when a file is copied on its own" \
    "$(sources | xargs grep -nE '^\s*///.*``' | grep -v '/// ```')"
report "Header comment names the file" \
    "$(for f in $(sources); do head -1 "$f" | grep -qE "^// $(basename "$f" | sed 's/[.+]/\\&/g') - Copyright [0-9]{4} SwifterSwift$" || echo "$f"; done)"
report "Every extension has a test file" \
    "$(for f in $(sources); do
        relative=${f#Sources/}
        module=${relative%%/*}
        test="Tests/${module}Tests/${relative#*/}"
        [ -f "${test%.swift}Tests.swift" ] || echo "$f (missing ${test%.swift}Tests.swift)"
    done)"
report "Tests use Swift Testing, not XCTest" \
    "$(find Tests -name '*.swift' | xargs grep -nE '^\s*import XCTest')"

echo "structure: $(sources | wc -l | tr -d ' ') files checked, $problems problems"
[ "$problems" -eq 0 ]
