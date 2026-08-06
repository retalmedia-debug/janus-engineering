// JANUS commitlint configuration
// Extends Conventional Commits with JANUS-required types
// Services add their own scopes in their service-level commit convention document

/** @type {import('@commitlint/types').UserConfig} */
const config = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'header-max-length': [2, 'always', 100],
    'type-enum': [
      2,
      'always',
      [
        'feat',       // new feature
        'fix',        // bug fix
        'docs',       // documentation only
        'style',      // formatting, no behavior change
        'refactor',   // code restructuring, no behavior change
        'perf',       // performance improvement
        'test',       // adding or fixing tests
        'build',      // build system or tooling
        'ci',         // CI/CD configuration
        'chore',      // maintenance tasks
        'revert',     // reverting a previous commit
        'security',   // security-related change
        'migration',  // database migration files
      ],
    ],
    'scope-case': [2, 'always', 'lower-case'],
    'subject-case': [2, 'always', 'lower-case'],
    'subject-empty': [2, 'never'],
    'subject-full-stop': [2, 'never', '.'],
    'body-leading-blank': [1, 'always'],
    'footer-leading-blank': [1, 'always'],
  },
}

export default config
