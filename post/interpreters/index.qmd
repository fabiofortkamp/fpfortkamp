---
title: "Software Development Book Review: Writing Interpreters in Go"
date: "2024-04-05"
categories: 
  - "book-recommendations"
  - "learning-interpreters-and-compilers"
tags: 
  - "books"
  - "go"
  - "interpreters"
coverImage: "squirrel-monkey-monkey-climb-feeding-47074.jpeg"
---

[A couple of weeks ago](https://obsessedwithprogramming.com/monkey/), I mentioned _[Writing Interpreters in Go](https://interpreterbook.com/)_, a book that teaches you to write an interpreters for the Monkey programming language. If you write software for a living, you should study this book. **This is a _software development book_ more than an _interpreters book_ that has much to teach.**

## An overview of the book

_Writing Interpreters in Go_ is incredibly well written. The structure is sound, with medium-sized chapters, each one of them focusing on one major task of an interpreter:

1. _Lexing_, reading a program as a string and making sense of each character to produce _tokens._ For instance: "if the current character, than all numbers up to the next whitespace is an integer";

3. _Parsing_, where you combine tokens into an abstract syntax tree (the famous AST)

5. _Evaluating_, where you use the host language (in this case, Go) to convert a "Infix Plus operation a+b" from the AST into an actual instruction `a+b`.

There are also chapters on extending the language from the initial implementation and on defining macros (this is really advanced stuff).

## Differences between programming books and software development books

I'm at a stage in my carrer that I do not need to _programming books_, I need _software development books._ I consider the Go syntax actually quite simple, and appraise the author Thorsten Ball for not wasting time on that. He focuses on the much important issues of program organization, like creating separate modules for each major task. He create modules for the business logic, goes one level up to define a loop that reads input and applies that logic ([parametrizing the I/O](https://obsessedwithprogramming.com/studying-go/)), and then create a `main` module to present this loop to the screen.

I also like how he defines tests very carefully, and is not afraid of testing edge cases. Is it just me, or that are too many testing tutorials with `assert 1 + 1 == 2`?

## Key takeaways from the book

1. When thinking about a concept, start by creating small data structures, like structs, enums or classes. Codify in the program what's on your head;

3. Write tests to define what you want from those data structures, and use the same inputs as the user. If your program takes a filename as an input, then the test should get the filename as an input. This tells you how hard is to actually use your program;

5. Don't be afraid of going to the old-fashioned literature of papers and books. The major algorithm from _Writing Interpreters in Go_, a modern book about a modern language, comes from a paper from the 70s.

Have you read this book? What do you think?
