---
title: Why and how to use different colors in VS Code for different projects
author: Fábio P. Fortkamp
date: '2022-12-02'
slug: color
categories:
  - Articles
tags:
  - vs code
  - color
subtitle: ''
summary: ''
authors: []
lastmod: '2022-12-21T15:10:44-03:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
---

I know what you are going to say: I'm weird, and apparently it makes no sense to
spend time on things like this. But here it is: a post about setting different
color schemes for [VS Code](https://code.visualstudio.com/), depending on which
folder is open.

## Why setting different colors is good for productivity

First, let us say right away: if you spend some any significant time in a
program, making it look more pleasant, so that you'll *want* to spend more time
with it, is super productive. Plus, hacking things is fun, and fun is always a 
good way to spend time.

But there is also a *contextual* component. CGP Grey illustrates how it is
good to compartimentalize your life, to train your brain to associate certain 
environments with a desire to focus on certain things:

{{< youtube snAhsXyO3Ck >}}

In this case, when I see a particular color scheme, I will immediately start to
think about the project associated with those colors. Also,
as I work with different projects alternating them within a given day (sometimes
using different programming languages), assigning a different color scheme to 
each project help me differentiate between them.

## How to set and sync color schemes in VS Code

When you configure the editor's 
[settings](https://code.visualstudio.com/docs/getstarted/settings), VS Code 
saves a JSON file with your customizations in a default location (see the 
aforelinked docs page). One of the settings is the [color  scheme](https://code.visualstudio.com/docs/getstarted/themes). For my default 
color scheme, I like the 
[Solarized Light](https://ethanschoonover.com/solarized/) theme:

![Screenshot of VS Code in the Solarized Light color scheme](images/Code_PGvr0Covqz.png)


Now, how can this setting be changed based on the folder you open? It turns out
you can open a particular folder in VS Code, which it calls a *workspace* 
(workspaces can actually combine different folders). In the Settings UI, you
can set it to customize the *workspace* settings:

![Screenshot of the VS Code settings editor](images/Code_wCsyAXtpD6.png)

Now, when you save the settings, a `settings.json` file is created inside the
folder you are in; in the figure below, I've setup the "local" color theme to
a dark version of the solarized scheme - but this gets loaded only when I open
up that particular folder!

![Screenshot of VS Code in the Solarized Dark color scheme](images/Code_qYRrZ4Z2eM.png)

## My color schemes

I'll illustrate with two more projects to get you inspired. When I want to mess
around with my [dotfiles](https://github.com/fabiofortkamp/dotfiles/), I use
a grey-ish, very utilitarian-looking color scheme (Atom Dark One):

![Screenshot of VS Code in a gray-like color scheme](images/Code_ZErK6i88nf.png)

But when I work in a project involving the [Julia](https://julialang.org/)
language, which is particularly associated with blue-purple colors (check their
website), I configured VS Code with the "Tomorrow Night Blue" theme:

![Screenshot of VS Code in a blue-purple color scheme](images/Code_AKPuxJ5Q4K.png)

This is *very* productive: I can have multiple VS Code windows (working in Julia while tweaking my 
dotfiles), and when I Alt-TAB the different colors are immediately apparent.

Please do tell me if I'm wasting my time...
