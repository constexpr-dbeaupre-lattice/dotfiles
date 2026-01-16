# Starship prompt.
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# Cargo.
use std/util "path add"
path add (default "~/.cargo" | path join "bin")

# Conda.
$env.PATH = ($env.PATH | append "C:/Users/dbeaupre/scoop/apps/miniconda3" | append "C:/Users/dbeaupre/scoop/apps/miniconda3/current/Scripts" | append "C:/Users/dbeaupre/scoop/apps/current/Library/bin")

# Scripts.
source C:/Users/dbeaupre/AppData/Roaming/nushell/scripts/ff.nu
source C:/Users/dbeaupre/AppData/Roaming/nushell/scripts/fj.nu
