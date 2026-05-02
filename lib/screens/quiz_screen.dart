import 'package:flutter/material.dart';
import 'package:paragliding_training/generated_localizations/app_localizations.dart';
import '../models/course_model.dart';

class QuizScreen extends StatefulWidget {
  final CourseQuiz quiz;

  const QuizScreen({super.key, required this.quiz});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  String? _selectedAnswer;
  bool _answered = false;
  int _score = 0;
  bool _done = false;

  QuizQuestion get _currentQuestion =>
      widget.quiz.questions[_currentIndex];

  void _selectAnswer(String optionId) {
    if (_answered) return;
    final correct = optionId == _currentQuestion.correctAnswer;
    setState(() {
      _selectedAnswer = optionId;
      _answered = true;
      if (correct) _score++;
    });
  }

  void _next() {
    if (_currentIndex + 1 >= widget.quiz.questions.length) {
      setState(() => _done = true);
    } else {
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
        _answered = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    if (_done) {
      return _buildResultScreen(context, loc);
    }

    return _buildQuestionScreen(context, loc);
  }

  Widget _buildQuestionScreen(BuildContext context, AppLocalizations loc) {
    final q = _currentQuestion;
    final total = widget.quiz.questions.length;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.quiz),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_currentIndex + 1) / total,
            backgroundColor: colorScheme.surface,
            color: colorScheme.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress label
            Text(
              loc.question(_currentIndex + 1, total),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 12),
            // Question text
            Text(
              q.question,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 20),
            // Options
            ...q.options.map(
              (opt) => _OptionTile(
                option: opt,
                selected: _selectedAnswer == opt.id,
                answered: _answered,
                isCorrect: opt.id == q.correctAnswer,
                onTap: () => _selectAnswer(opt.id),
              ),
            ),
            // Explanation + Next
            if (_answered) ...[
              const SizedBox(height: 20),
              _ExplanationCard(
                correct: _selectedAnswer == q.correctAnswer,
                explanation: q.explanation,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: _next,
                  child: Text(
                    _currentIndex + 1 >= widget.quiz.questions.length
                        ? loc.quizComplete
                        : loc.next,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResultScreen(BuildContext context, AppLocalizations loc) {
    final total = widget.quiz.questions.length;
    final passed = _score >= widget.quiz.passMark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(loc.quizComplete)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                passed ? Icons.emoji_events : Icons.replay,
                size: 72,
                color: passed ? Colors.amber : colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                loc.quizComplete,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              Text(
                loc.yourScore(_score, total),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: passed
                      ? Colors.green.shade100
                      : Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  passed ? loc.passed : loc.failed,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: passed
                        ? Colors.green.shade800
                        : Colors.orange.shade800,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              OutlinedButton.icon(
                onPressed: () {
                  // Pop back to course select (pop all quiz/reading/day screens)
                  Navigator.of(context)
                      .popUntil((route) => route.isFirst || _isCourseSelect(route));
                },
                icon: const Icon(Icons.home),
                label: Text(loc.backToCourses),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isCourseSelect(Route route) {
    return route.settings.name == '/courses';
  }
}

class _OptionTile extends StatelessWidget {
  final QuizOption option;
  final bool selected;
  final bool answered;
  final bool isCorrect;
  final VoidCallback onTap;

  const _OptionTile({
    required this.option,
    required this.selected,
    required this.answered,
    required this.isCorrect,
    required this.onTap,
  });

  Color _bgColor(BuildContext context) {
    if (!answered) {
      return selected
          ? Theme.of(context).colorScheme.primaryContainer
          : Theme.of(context).colorScheme.surface;
    }
    if (isCorrect) return Colors.green.shade100;
    if (selected && !isCorrect) return Colors.red.shade100;
    return Theme.of(context).colorScheme.surface;
  }

  Color _borderColor(BuildContext context) {
    if (!answered) {
      return selected
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.outline;
    }
    if (isCorrect) return Colors.green.shade600;
    if (selected && !isCorrect) return Colors.red.shade600;
    return Theme.of(context).colorScheme.outline.withOpacity(0.3);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: _bgColor(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _borderColor(context), width: 1.5),
        ),
        child: Row(
          children: [
            Expanded(child: Text(option.text)),
            if (answered && isCorrect)
              const Icon(Icons.check_circle, color: Colors.green, size: 20),
            if (answered && selected && !isCorrect)
              const Icon(Icons.cancel, color: Colors.red, size: 20),
          ],
        ),
      ),
    );
  }
}

class _ExplanationCard extends StatelessWidget {
  final bool correct;
  final String explanation;

  const _ExplanationCard({required this.correct, required this.explanation});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: correct ? Colors.green.shade50 : Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: correct ? Colors.green.shade300 : Colors.orange.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                correct ? Icons.check_circle_outline : Icons.info_outline,
                color: correct ? Colors.green.shade700 : Colors.orange.shade700,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                correct ? loc.correct : loc.incorrect,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: correct
                      ? Colors.green.shade700
                      : Colors.orange.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${loc.explanation}: $explanation',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
