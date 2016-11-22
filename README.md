# Shape Server
> A haskell scotty server with using blaze-html and blaze-svg. Displays shapes defined by the user in a DSL using the blazingly fast svg combinator library.
## Shape Server example
```
stack build
stack ghci
main
Setting phasers to stun... (port 3000) (ctrl-c to quit)
```
## DSL example
```
[(Scale 2.5 0.5 :+: Translate 1 2, Circle, (Style 1 Red Blue)), (Scale 2 1 :+: (Translate 1 0 :+: Rotate 5), Square, (Style 1 Blue Red))]
```
