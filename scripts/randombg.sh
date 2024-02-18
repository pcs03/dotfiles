if [[ $# -lt 1 ]] || [[ ! -d $1 ]]; then
    echo "Usage:
    $0 <dir containing images>"
    exit 1
fi

find "$1" -type f \
    | while read -r img; do
        echo "$((RANDOM % 1000)):$img"
    done \
    | sort -n | cut -d ':' -f2- | head -n 1
