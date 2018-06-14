---
title: Contribute
layout: page
navorder: 1
---
# Introduction

You are here to help on VSAlert? Awesome, feel welcome and read the following sections in order to know how to ask questions and how to work on something.

Following these guidelines helps to communicate that you respect the time of the developers managing and developing this open source project. In return, they should reciprocate that respect in addressing your issue, assessing changes, and helping you finalize your pull requests.

VSAlert is an open source project and we love to receive contributions from our community — you! There are many ways to contribute, from writing tutorials or blog posts, improving the documentation, submitting bug reports and feature requests or writing code which can be incorporated back into the library

Please, don't use the issue tracker for support questions. 

## Ground Rules

* Ensure that contributions don't change the overall library structure. Right now, VSAlert is packaged as a statically-linked Objective-C framework, marked up with generics and nullibity for compatibility with Swift. Any changes to this structure should only be part of major version releases.
* Create issues for any major changes and enhancements that you wish to make. Discuss things transparently and get community feedback.
* Don't add any classes to the codebase unless absolutely needed.
* Be welcoming to newcomers and encourage diverse new contributors from all backgrounds. See our [Code of Conduct](https://code.vsanthanam.com/VSAlert/CODE_OF_CONDUCT.html) for more information.

## Your First Contribution

Small contributions such as fixing spelling errors, create an issue report mentioned the desired changes rather than submitting a pull request. As a rule of thumb, changes are obvious fixes if they do not introduce any new functionality or creative thinking. As long as the change does not affect functionality, some likely examples include the following:

* Spelling / grammar fixes
* Typo correction, white space and formatting changes
* Comment clean up

For something that is bigger than a one or two line fix:

1. Create your own fork of the code
2. Do the changes in your fork
3. Submit a pull request

Never contributed to an open source project before? Take a look at [this tutorial](http://makeapullrequest.com).

# Issue Tracking

When filing a new issue, consider using one of the two included templates for bugs and feature requests before writing an issue from scratch.

## Bugs

Please test your insure your bug can be easily replicated across installation techniques (i.e. framework, cocoapods, etc.). If it can't be, please specificy how you installed the library and linked against it in your project. Check the currently open issues to see if your problem has already been filed, and re-open the issue if you're still encountering it after its been closed before.

## Features

Before submitting a feature request, see the [library documentation](https://code.vsanthanam.com/VSAlert/Documentation) to make sure that what you want isn't already possible. 

## Philosophy

When contriubuting to the project, keep in mind the following

* VSAlert is designed to mimic UIAlertController's API as closely as possible. Near drop-in support is what we're going for. Additional features should *extend* the current API, rather than altering it, whenver possible.
* VSAlert should mimic the latest version of UIAlertController in the latest stable release of the iOS SDK. If their API changes, so should ours. The idea is to make migration from UIAlertController to VSAlert as painless as possible
* VSAlert should not require storyboards, XIBs, or any other assets to work. It's entire UI should be handled programatically
* VSAlert's runtime behavior should also mimic UIAlertController. You should be able to present an instance of VSAlertController in all the same runtime circumstances as UIAlertController
* VSAlert should focus on adding visual customization over behavior ones. This isn't a hard and fast rule, but the general idea is to provide users of a UIAlertController with a viable customizable alternative while requiring as little code refactoring as possible.

Thanks for helping make this project awesome!
