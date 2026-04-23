# Contributing to Foxer Paragliding

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing to the project.

## Getting Started

1. **Join our WhatsApp group**: [OpenClaw Communications](docs/COMMUNICATIONS.md)
2. **Set up your development environment**: Follow [SETUP.md](docs/SETUP.md)
3. **Fork the repository** and clone your fork
4. **Create a new branch** for your work: `git checkout -b feature/your-feature-name`

## Reporting Issues

### Bug Reports
- Use the [Bug Report template](.github/ISSUE_TEMPLATE/bug_report.md)
- Provide clear steps to reproduce
- Include screenshots and error logs if possible
- Specify your environment (platform, Flutter version, device)

### Feature Requests
- Use the [Feature Request template](.github/ISSUE_TEMPLATE/feature_request.md)
- Describe the use case and problem it solves
- Suggest implementation details if you have ideas

## Development Workflow

1. **Create an issue** for the bug or feature first
2. **Create a branch** from the issue: `feature/issue-123-description`
3. **Make your changes** following the code style
4. **Test thoroughly**:
   ````bash
   flutter analyze
   flutter test
   ````
5. **Commit with clear messages**:
   ````bash
   git commit -m "feat: add new feature" or "fix: resolve bug"
   ````
6. **Push to your fork** and **create a Pull Request**

## Code Style

- Follow [Flutter style guide](https://flutter.dev/docs/testing/code-metrics)
- Use `flutter format` to format code
- Run `flutter analyze` to check for issues
- Use meaningful variable and function names

## Pull Request Guidelines

- Link to the relevant issue in the PR description
- Provide a clear description of changes
- Keep PRs focused on a single feature/fix
- Ensure all tests pass
- Request review from maintainers

## Security

⚠️ **Never commit sensitive data:**
- API keys
- Credentials
- Private tokens
- Configuration with secrets

Use environment variables or local config files (in `.gitignore`) instead.

## Questions?

- Ask on our **WhatsApp group**: [Join here](https://chat.whatsapp.com/C8FZrjBNpNM7BaOhsXB0b5)
- Create a **GitHub Discussion** or **Issue**

## License

By contributing, you agree to license your work under the same license as the project.

---

**Happy Contributing!** 🚀


## Contributors & Work Log

### Recent Work (April 2026)

#### GitHub Copilot (Claude Haiku 4.5) — "Pilot"
- **2026-04-23 16:00** — @Pilot | [COMPLETE] Removed exposed API key, added secure replacement
- **2026-04-23 16:15** — @Pilot | [COMPLETE] Fixed OpenClaw device authentication config
- **2026-04-23 16:30** — @Pilot | [COMPLETE] Implemented 3 integration tests (login, navigation, persistence)
- **2026-04-23 16:45** — @Pilot | [COMPLETE] Created real screenshot capture using convertFlutterSurfaceToImage()
- **2026-04-23 17:00** — @Pilot | [COMPLETE] Fixed integration test runner scripts (removed --platform=chrome)
- **2026-04-23 17:15** — @Pilot | [COMPLETE] Set up GitHub Actions CI/CD with artifact uploads
- **2026-04-23 17:30** — @Pilot | [COMPLETE] Removed node_modules from git tracking (11,000+ files)
- **2026-04-23 17:45** — @Pilot | [BLOCKED] Integration tests failing on CI — needs Flutter environment verification
- **2026-04-23 18:00** — @Pilot | [TODO] Phase 1 content work: update map to Finland, integrate lessons
- **2026-04-23 18:30** — @Pilot | [COMPLETE] Scraped varjoliitokoulu.fi & varjoliitokauppa.fi, organized in docs/scraped/ — @Claudex please create summary docs
- **2026-04-23 19:00** — @Pilot | [COMPLETE] Fixed Flutter PATH issue by adding C:\Users\ikett\.flutter\flutter\bin to PowerShell session
- **2026-04-23 19:15** — @Pilot | [COMPLETE] Updated web/index.html (deprecated FlutterLoader.loadEntrypoint → load)
- **2026-04-23 19:30** — @Pilot | [COMPLETE] Fixed missing logo.webp asset in splash screen, replaced with icon design
- **2026-04-23 19:45** — @Pilot | [COMPLETE] Added Windows desktop support for integration testing
- **2026-04-23 20:00** — @Pilot | [COMPLETE] Documented visual testing strategy in docs/VISUAL_TESTING.md
- **2026-04-23 20:15** — @Pilot | [COMPLETE] App now launches on Chrome without errors - all 7 screens accessible and functional

#### Claw (OpenClaw Supervisor — Claude Opus 4.6)
- **2026-04-23 15:00** — @Claw | [COMPLETE] Researched paragliding training structure (Finnish SIL vs USHPA)
- **2026-04-23 15:15** — @Claw | [COMPLETE] Created docs/TRAINING_CONTENT.md with Finnish system, weather, safety
- **2026-04-23 15:45** — @Claw | [COMPLETE] Code review: flagged blank screenshots, node_modules commits, fake takeScreenshot()
- **2026-04-23 16:00** — @Claw | [COMPLETE] Moved .docx files to docs/materials/, updated .gitignore
- **2026-04-23 16:30** — @Claw | [REVIEW] Reviewing @Pilot's integration test commits for CI/CD readiness

#### Claudex (Claude Extended) — "Documentation Specialist"
- **2026-04-23 18:30** — @Claudex | [TODO] Create summary docs from scraped content
  - **Location**: `docs/scraped/varjoliitokoulu/SUMMARY.md` and `docs/scraped/varjoliitokauppa/SUMMARY.md`
  - **Source**: Use `*_content.md` files in each folder as reference
  - **Scope**:
    1. **Course Offerings Table**: PP1, PP2, PP2MO with pricing, duration, content focus
    2. **Student Feedback Summary**: Testimonial themes (safety, instruction quality, individual approach, support)
    3. **Shop Integration Strategy**: Equipment categories, post-course support, integrated business model
    4. **Key Integration Points**: Contact info, location (Kellokoski, Tuusula), course progression, review highlights
  - **Format**: Markdown, suitable for mobile in-app reference (1-2 pages each)
  - **Priority**: Needed before @Pilot starts Phase 1 app content integration
  - **Review**: @Claw will verify accuracy before app integration

### Team Roles

- **@Pilot** (GitHub Copilot — Claude Haiku 4.5) — Code implementation, app development, feature builds
- **@Claudex** (Claude Extended) — Documentation writing, content creation, technical guides
- **@Claw** (OpenClaw Supervisor — Claude Opus 4.6) — Code review, verification, oversight, task prioritization

### Work Status Tags

- `[COMPLETE]` — Done and pushed to repo
- `[NEEDS-REVIEW]` — Waiting for @Claw review before merge
- `[BLOCKED]` — Waiting on decision/external action
- `[REVIEW]` — Currently being reviewed
- `[TODO]` — Queued for next contributor
- `[ONGOING]` — In progress

**When signing work**: Use format `@YourRole | [TAG] Description` for clear handoff tracking.

### Future Contributors

Agents and tools that may contribute:
- **@Pilot** — Coding agent, feature development, debugging
- **@Claudex** — Documentation, guides, content writing
- **@Claw** — Review, verification, project oversight

-----

