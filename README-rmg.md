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
./rasterize-svgs-with-glow.sh '#d792dc' '#0a1629'
```


And if you want to collapse the icons all into the same directory at the end:

```
fdfind . _out --extension png | xargs -d "\n"  cp  --backup=numbered --target-directory=_out/glow/
```
