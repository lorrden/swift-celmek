# swift-celmek

A port of the celmek library to swift.

The celmek library implements several astronomical algorithms.

| Algorithm | Status
| --- | --- 
| VSOP87 | Done
| ELP2000 82b | Done
| Goffin2000 | Done

## Status

CelMek is very much in development, and the scope has grown to implement more astronomical algorithms.
It is currently NOT in a 1.0 state, so expect that API breakage happens.

A companion app for interactivelly working with this library is developed here:
[https://github.com/lorrden/CelMek-Viewer]

## Evolution

In addition to the celestial mechanics algorithms,
various functionality related to Aerodynamics have been added.
It is probable that we will rename the package `swift-physics` at some point.

## License

Apache 2.0
