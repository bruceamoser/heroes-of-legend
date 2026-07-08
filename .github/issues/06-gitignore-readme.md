## Epic 0 — Infrastructure (#6)

**Dependency:** #1
**Est. Effort:** Small

### Goal
Update the .gitignore and README.md to reflect the current project state and conventions.

### Success Criteria
- .gitignore covers: build artifacts, venv, generated content, IDE files, OS files
- README.md provides a clear project overview for human contributors

### .gitignore Checklist
- [ ] Build artifacts: `starter-kit/`, `starter-kit.zip`
- [ ] Python: `.venv/`, `__pycache__/`, `*.pyc`
- [ ] Generated content: `source-doc/extracted/`
- [ ] IDE: `.vscode/`, `*.code-workspace`
- [ ] OS: `.DS_Store`, `Thumbs.db`
- [ ] Tooling: `tools/`, `.playwright-mcp/`

### README.md Content
- [ ] Project name and tagline
- [ ] What Heroes of Legend is (fantasy TTRPG, 3d6 system)
- [ ] Current phase (core rules design)
- [ ] How to build the PDF (prerequisites + `./build.sh`)
- [ ] Link to `docs/design/implementation-plan.md` for the full plan
- [ ] Link to the original playtest PDF for reference
- [ ] Designer credit (Bruce A. Moser)

### Reference
- Neon Relic README.md: `../neon-relic/README.md`
