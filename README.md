This branch parses the simple test that contains extra stuff before and after the pattern to be matched.

```
a b c u * v * $w -o x. d e f
```

`make` transpiles the above test into:
```
a b c u * v * w -o w * x. d e f
```

whereas `make identity` simply parses the above test and outputs it again.
