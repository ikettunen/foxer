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
   ```bash
   flutter analyze
   flutter test
   ```
5. **Commit with clear messages**:
   ```bash
   git commit -m "feat: add new feature" or "fix: resolve bug"
   ```
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
