# Historical archive boundary

Legacy chapter snapshot: `5d21f07cf4db8d6ad4a2995249ddcf382745b251`. Each source path and SHA-256 is recorded in
[manifest.json](manifest.json). Git preserves the exact bytes; no deletion or bulk
move is needed to preserve history. Recover with `git show COMMIT:PATH` using this
commit and a manifest path. The snapshot includes all chapters so dependencies
are preserved, not only isolated catalogs.

The old catalogs are historical only for this playtest. Nothing is automatically
carried into the working catalog. Physical Quarto chapter replacement is deferred
until the working rules are validated. This is a versioned archive by reference,
not a claim that the old book has already been rewritten.
