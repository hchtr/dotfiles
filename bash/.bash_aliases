typst_watch() {
    local filename="$1"
    if [ -z "$filename" ]; then
        echo "Error: Please provide a filename (e.g., typst_watch document.typ)"
        return 1
    fi

    typst compile "$filename" || return 1
    local pdf_name="${filename%.typ}.pdf"

    zathura "$pdf_name" >/dev/null 2>&1 &
    local zathura_pid=$!

    trap 'kill "$zathura_pid" >/dev/null 2>&1; trap - INT; return' INT

    typst watch "$filename"

    kill "$zathura_pid" >/dev/null 2>&1
    trap - INT
}

