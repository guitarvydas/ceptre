# Summary

Wrap all ID's in unicode brackets.  This will make it easier to use Ohm's space-skipping feature, thereby, making grammars more readable.

## Why
For example "abc def" is parsed as:
1. 2 tokens ("abc" "def") if space skipping is disabled (i.e. rules all begin with lower-case letters ; off-the-shelf PEG ; results in noisy grammars, i.e. too much detail)
2 1 token ("abcdef") if space skipping is turned on.

The solution is to insert non-space characters between identifiers, e.g. commas.

## More Possibilities

If you go further, like wraping *every* identifier in brackets, then new possibilities are enabled.  For example, it becomes possible to embed spaces in identifiers - something we don't do because of our bias towards using only 127 characters in the ASCII alphabet.

# Proposed solution:
rewrite incoming text, so that all identifiers are bracketed, e.g. "❲abc❳ ❲def❳".

# First-order 
Build a stand-alone tool to bracket all ids.

Use DW0D to build an app, then use VSH 0D syntax ($ ...) to use the app in further DW0D tools.

This will spawn the bracketing app as a separate process each time, but, you don't care if you are only Designing an app - as long as the result runs "fast enough". Later, maybe, you will want to spend time optimizing the result, but, at first, don't let Optimization interfere with Design.

## Beyond First-Order

Later, if you want to optimize and Production Engineer a given app, copy/paste the bracketer code into a given app.

To go even further, rewrite the bracketer code as a hoary REGEX in some underlying language, or, write the whole preprocessor in the underlying language manually.  For example, in this case, we are using Odin as the underlying language.  We could rewrite the preprocessor in Odin, but, that will take time and should be done only if you *really* need to make this run faster.

At first, this preprocessor doesn't have to run blazingly fast.  This app will only be used - sparingly - by developers.  There is little incentive to spend eons making the code run blazingly fast.  Imagine that you have to pay for this app out of your own pocket - would you choose to spend the $s necessary to make it run in 100ns, or, is 1msec good enough?
