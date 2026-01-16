# Starship prompt.
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# Cargo.
use std/util "path add"
path add (default "~/.cargo" | path join "bin")

# Scripts.
source C:/Users/dbeaupre/AppData/Roaming/nushell/scripts/ff.nu
source C:/Users/dbeaupre/AppData/Roaming/nushell/scripts/fj.nu
