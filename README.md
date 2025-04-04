## Ladybird flake

```console
git clone https://github.com/ttrssreal/ladybird
```

### Ref
`cmake -DCMAKE_BUILD_TYPE=Debug -GNinja -BBuild/debug`

`cmake -DCMAKE_BUILD_TYPE=Debug -GNinja -SMeta/Lagom -BBuild/lagom`

`-DENABLE_LAGOM_CCACHE=True`

`-DENABLE_ADDRESS_SANITIZER=ON -DENABLE_UNDEFINED_SANITIZER=ON`

Generate test targets (Test*):
`-DBUILD_TESTING=True`
