# fpfortkamp

This is the source for the professional website and blog of Fábio P. Fortkamp, available at [fpfortkamp.com](fpfortkamp.com).

This site is built with [R](https://www.r-project.org/) and [blogdown](https://bookdown.org/yihui/blogdown) (which itself is based on [Hugo](https://gohugo.io/)), [RStudio](https://posit.co/download/rstudio-desktop/) is the recommended development environment.

The instructions below apply if you want to mess around locally with the source.

## Installation

To install, open a R session inside the repo (or open the project in RStudio) and run

``` r
install.packages("blogdown")
blogdown::install_hugo("0.92.2")
```

## Development

Open up a (Hugo) server with:

```r
blogdown::serve_site()
```

In RStudio, you can also use the "Addins -> Serve Site" command in the
toolbar (it might ask you to download R packages related to the IDE
integration).

### How to publish a post

A "post" is a folder under `content/post`. In RStudio, click the 
"Addins -> New Post" command to issue a form in which you can insert the details,
 and the file structure will be created for you.
