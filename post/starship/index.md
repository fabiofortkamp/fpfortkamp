---
title: "Higher productivity for developers with Starship"
date: "2024-04-08"
categories: 
  - "blog"
tags: 
  - "go"
  - "productivity"
  - "python"
  - "shell"
coverImage: "milky-way-starry-sky-night-sky-star-956999.jpeg"
---

If you follow the internet trends around tools for developers, you might have heard of [Starship](https://starship.rs/), a tool that gives useful information quickly for higher productivity for developers.

At first, I got the feeling that Startship is more cosmetic than anything else, but after a few weeks working with it, I noticed that it is indeed a _productivity_ tool in the original sense: low effort, high speed gains in the day-to-day workflow.

## A typical problem that Starship solves

By day, I write mostly Python code, and the tricky thing that people forget is that there is no Python - there are Pythons. Each new Python 3.X version introduces several new features and might break some APIs from other 3.X versions. If I write code for Python 3.12, colleagues of mine that not so tech-savy and have only Python 3.10 in their machines would not be able to use my tools.

A similar problem occur for package versions: different clients use different versions of my company's products, so when debugging I need to be sure of running the correct version.

Enter Starship. When prototyping an application this morning, this is the prompt I got:

ShellSession

```
~/newapp on  main [?] is 📦 v0.1.0 via 🐍 v3.11.8 took 4s
➜
```

This tells me immediately that:

1. I'm on the `newapp` root directory

3. I'm on the main branch

5. There is at least one untracked file in git

7. The package version 0.1.0

9. I'm not in an activated virtual environment, but am running Python 3.11.8

11. The previous command tool 4 seconds to run

Everything substantial that I would do, like activating an environment or bumping up the package version, would reflect immediately in the prompt.

When I switch projects to [use Go](https://obsessedwithprogramming.com/studying-go/) for a new CLI tool that I'm building, now I see this:

ShellSession

```
~/awesome-go-cli on  main via 🐹 v1.21.6
```

and now my brain notices the new animal and knows that I need to think statically-typed.

## Productivity for developers: easy to setup, powerful results

Of course real nerds would set it up with shell variables in the profile and RC files. The real productivity leap is that configuration is minimal:

1. Install Starship with the official [guide](https://starship.rs/guide/)

3. Create your configuration in `~/.config/starship.toml`. Everything you saw above is built-in: there is the entirety of my configuration with comments:

TOML

```

# Replace the '❯' symbol in the prompt with '➜'
[character] # The name of the module we are configuring is 'character'
# The 'success_symbol' segment is being set to '➜' with the color 'bold green'
success_symbol = '[➜](bold green)'
error_symbol = '[➜](bold red)'


[c]
symbol = " "

[directory]
# the default is to truncate the full path in the prompt
# this increases the number of subdirectories before truncation happens
read_only = " 󰌾"
truncation_length = 6
truncation_symbol = "..."
truncate_to_repo = false


[docker_context]
# I rarely use Docker but when I do, I find the Docker additions distracting
disabled = true
```

The TOML file is based on [modules](https://starship.rs/config/) that you customize individually. Notice I did not have to change nor the Python nor the Go modules.

Do you use any shell prompt like this? Leave suggestions for similar productivity tools in the comments!
