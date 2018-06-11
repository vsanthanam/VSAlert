---
title: Quick Start Guide
homepage: true
description: a drop-in replacement in VSAlertController
layout: page
navorder: 0
---

# Overview

VSAlertController is a drop-in replacement for UIAlertController. It's designed to mimic UIAlertController's API as closely as possible, while adding addtional styling & behaviorial customization options. VSAlertController is loosely inspired by codeio's [PMAlertController](https://github.com/pmusolino/PMAlertController), but is written in Objective-C rather than Swift and does not use IB files to build its UI.

# Setup

## Static Framework

1. Download the latest stable release [from GitHub](https://github.com/vsanthanam/VSAlert/releases). It contains a compiled static framework as well as a copy of the relevent documentation.
2. Add  `VSAlert.framework`, and have your target link against the framework during the build process.
3. Reference the library by importing the clang module in relevent files with `@import VSAlert;`.

## CocoaPods

## Direct Source
