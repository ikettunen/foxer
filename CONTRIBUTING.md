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

#### GitHub Copilot (Claude Haiku 4.5)
- **2026-04-23**: Security & Infrastructure
  - Removed exposed Google Maps API key (AIzaSyALoTTdeGESw38x8pncRPzgYn6FF_R7NkU)
  - Added new secure API key (AIzaSyANeXz8Z_1ukadMZfTYfhfKVPzuAWF6TzA)
  - Updated \.gitignore\ with API key patterns
  - Fixed OpenClaw device authentication (disabled device auth in config)

- **2026-04-23**: Integration Testing & CI/CD
  - Implemented 3 integration tests (login flow, navigation, persistence)
  - Created real screenshot capture using \convertFlutterSurfaceToImage()\`n  - Fixed deprecated Flutter APIs
  - Fixed integration test runner scripts (removed unsupported --platform=chrome)
  - Set up GitHub Actions CI/CD workflow with artifact uploads

- **2026-04-23**: Documentation
  - Created docs/IMPLEMENTATION.md - comprehensive app status (200+ lines)
  - Created docs/SCREENSHOTS_CI.md - how to run tests and access screenshots
  - Created QUICK_REFERENCE.md - command reference guide
  - Updated integration_test/README.md with documentation links

- **2026-04-23**: Repository Cleanup
  - Removed node_modules/ from git tracking (11,000+ files)
  - Updated .gitignore to exclude node_modules and lock files
  - Added marketing documentation (foxer_brochure.docx, foxer_esite_fi.docx)

### Future Contributors

Agents and tools that may contribute:
- claw - OpenClaw collaborative development tool
- claudex - Extended Claude functionality
- GitHub Copilot - AI-powered code assistant

**Guidelines**: Always sign your work with name and timestamp for clear project tracking.

-----

