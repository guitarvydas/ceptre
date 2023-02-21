This branch parses the simple test:

```
u * v * $w -o x.
```

`make` transpiles the above into
u * v * w -o w * x.

whereas `make identity` simply parses the test and outputs it again.

To install, run `make install`.  This will bring in the necessary npm libraries and 