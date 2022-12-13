---
title: Why a mechanical engineer uses Linux - in Windows
author: Fábio P. Fortkamp
date: '2022-12-02'
slug: linux
categories:
  - Articles
tags:
  - linux
  - python
  - ubuntu
  - windows
  - programming
subtitle: ''
summary: ''
authors: []
lastmod: '2022-12-02T09:45:23-03:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
draft: true
---

## A little bit of backstory

In the academic year of 2009-2010, I went to the 
[University of Porto](https://www.up.pt/portal/en/) to spend a semester abroad:

![Picture of me in a bridge in Porto, Portugal](images/IMG_3859.jpg)

This was life-changing in several ways. It was the first time I left my family
home (since I went to university in my home town), and it was in a different country! I met a lot of people, made several friends,
got the privilege of traveling around Europe being only 21, and grew up as a 
person.

Of course, academically I learned a lot. But I had a small problem: I was too
far advanced in my Mechanical Engineering curriculum here in Brazil, and I had
few options of courses to take in Portugal. This became even harder in the second semester, which
led me to the decision of taking Computer Engineering courses to achieve the
required number of hours in the classroom.

And then I, a Mechanical Engineer student, took classes on Computer Graphics,
Operating Systems, Databases. This experience *made me* the Mechanical Engineer
I am today.

## What is my job title anyway?

When I returned to Brazil, I was ruined. All I could think of was programming, 
and *serious* programming, not the sub par classes I had to take in the first
years of college. I still had to take some classes to finish my degree, and I filled the hours with courses in numerical heat transfer,
numerical structural analysis, computer-aided manufacturing. I began developing
[User-Defined Functions in Fluent](https://www.learncax.com/knowledge-base/blog/by-category/cfd/writing-a-user-defined-function-udf-in-ansys-fluent) in the C programming language (good times).

Before graduating, I took an internship position at 
[KIT](https://www.kit.edu/english/index.php). I worked in a project that 
involved the refrigeration industry, but... as a developer, I guess? 
I spent all days in the VBA (Visual Basic for Applications) editor, implementing
models for compressors, valves, heat exchangers, fluid properties -- and all
inside Excel, so that engineers and managers could do their thing  without having to open Matlab, or Python, and any code editor.

Quick: was I a Mechanical Engineer, or a Software Developer?

## Where does Linux goes into this post?

I reminded of all this because, currently, this is what I get to see in front of me almost
every day:

![Screenshot of the Windows Terminal app showing a Linux session](images/WindowsTerminal_9WqvMbOfEl.png)

I again face the question from above: I spend my days implementing models for
heat transfer and fluid flow processes -- am I an Engineer or a Developer?

My main function in my current job is developing (proprietary) Python software. This
is the most complex code I've ever worked with, and I have to deal with 
collaborating with other people with [Git](https://git-scm.com/), 
keeping track of Python versions (and Python packages versions). I'm also
writing reports in [Quarto](https://quarto.org), and beginning to study some 
[Julia](https://julialang.org/) (more on this in a later post). These are
serious programming tasks, and this requires serious programming tools. 

I'm not saying that you can't do serious development in Windows -- I've done that
my whole career. But I *was trained* to be a programmer in Linux, while taking all those Computer Engineering classes. My assignments were to work with
a terminal app (like the one you see above), type commands in it and then
write code in a text editor. After learning Linux at U. Porto, I couldn't go
back to the Command Prompt in Windows. In later years, I tried out 
[Cygwin](http://www.cygwin.com/) and [Git Bash](https://gitforwindows.org/), 
but these were more hacks than anything else and problems always 
appeared. For instance, you can indeed have a great terminal experience 
(I even wrote 
[my own configuration scripts for using terminals in Windows](https://github.com/fabiofortkamp/secondlaw)), 
but basic tools like `make` aren't included. I love to work with [VS Code](https://code.visualstudio.com/), and it doesn't integrate
well with either Cygwin or Git Bash.

So I decided to try out the [Windows Subsystem for Linux](https://learn.microsoft.com/en-us/windows/wsl/) (WSL),
which allows me to use Windows apps but with the Linux command line and tools. I should have just learned [Powershell](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.3&WT.mc_id=-blog-scottha&viewFallbackFrom=powershell-7.1), but here we are.

By the way: if you getting more serious into programming tasks in Windows,
you should check out [Scott Hanselman's blog](https://www.hanselman.com/blog/taking-your-powershell-prompt-to-the-next-level-with-windows-terminal-and-oh-my-posh-3).

## How to configure it

### Installation

So what is WSL? Basically, it's a different interface with your Windows PC. 

After [installing it](https://learn.microsoft.com/en-us/windows/wsl/install),
what you get is a virtual machine that is running a version of Linux. I went
with the default options: I'm running [Ubuntu](https://releases.ubuntu.com/22.04/)
-- maybe you can see that I even used the official wallpaper from the 
current (22.04) Long-Term-Support (LTS) distribution, *Jammy Jellyfish*. By the
way: I'm running the [Windows Terminal Preview](https://www.microsoft.com/p/windows-terminal-preview/9n8g5rfz9xk3#activetab=pivot:overviewtab),
a very modern terminal app. If you install WSL and this app, a *profile* will be
created, and you can select it when opening a new tab:

![Screenshot of Windows Terminal menu of opening new profiles](images/WindowsTerminal_ovsk3ERpZU.png)

[I've set up Windows Terminal](https://learn.microsoft.com/en-us/windows/terminal/install)
so that the Ubuntu profile is the default one, and also set it to open 
automatically at startup:

![Screenshot of Windows Terminal settings](images/WindowsTerminal_X8MCs4sDVo.png)

And with [this script](https://github.com/fabiofortkamp/secondlaw/blob/master/bin/wterminal.ahk)
(for [AutoHotkey](https://www.autohotkey.com)),
which is also in my [Startup folder](https://support.microsoft.com/en-us/windows/add-an-app-to-run-automatically-at-startup-in-windows-10-150da165-dcd9-7230-517b-cf3c295d89dd), I set up the keystroke Ctrl-Shit-Alt-I to toggle
opening and hiding the terminal.

### Getting around the command line

With WSL, you don't get a full Linux distribution, which its own graphical user interface -- you only have the command line, so it's essential to use it well.

When I was learning Linux, [The Linux Command Line by William Shots](https://linuxcommand.org/tlcl.php) was an essential reference - and it's free! I highly recommend it as a first step.

I've taken one step further from the book above, which uses the bash shell, and set zsh as my default system. [Here's my current configuration](https://github.com/fabiofortkamp/dotfiles), which uses [oh-my-zsh](https://ohmyz.sh/).

### Accessing Windows programs

The beauty of WSL is that it can be thought of as just an interface. For instance, as I said above, I use VS Code, and I downloaded it and installed it as a regular Windows program, and it is in my `PATH` [environment variable](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/) set *in Windows*. But in WSL, if I type `code`, it opens the Windows VS Code app -- it knows there to look at! If I navigate to a certain folder in the WSL shell ([and you navigate the Linux virtual machine directories, as well as the native Windows folder](https://learn.microsoft.com/en-us/windows/wsl/filesystems))

### Python versions

- links

## What does not work so far

- Julia. This is a virtual machine, and memory may become a problem.
