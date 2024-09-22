## To run on WSL Ubuntu:

```
apt-get install fd-find resvg cargo imagemagick
cargo install oxipng
```

add ``/home/rich/.cargo/bin` to PATH

## example of use

First

```
./colorize-svgs.sh '#d325e8' 'transparent'
```

And then

```
./rasterize-svgs-with-glow.sh '#ffadec' '#0a1629'
```

