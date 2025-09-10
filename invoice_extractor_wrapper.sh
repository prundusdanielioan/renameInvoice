#!/bin/bash

# Invoice Data Extractor Wrapper
# Script pentru extragerea datelor complete din facturi PDF

# Culori pentru output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Funcție pentru afișarea help-ului
show_help() {
    echo -e "${BLUE}Invoice Data Extractor${NC}"
    echo "========================"
    echo ""
    echo "Acest script extrage date complete din facturi PDF și creează copii cu nume noi."
    echo ""
    echo -e "${YELLOW}Date extrase:${NC}"
    echo "  • Numele companiei (după labelul 'Nume')"
    echo "  • Data emitere (după labelul 'Data emitere')"
    echo "  • Data scadenta (după labelul 'Data scadenta')"
    echo "  • Total plata (după labelul 'TOTAL PLATA')"
    echo "  • Total TVA (după labelul 'TOTAL TVA')"
    echo ""
    echo -e "${YELLOW}Format nume fișier:${NC}"
    echo "  [Nume_Companie]_[Data]_TOTAL_[Valoare].pdf"
    echo ""
    echo -e "${YELLOW}Utilizare:${NC}"
    echo "  $0 [folder] [opțiuni]"
    echo ""
    echo -e "${YELLOW}Opțiuni:${NC}"
    echo "  --dry-run, -d    Testează fără să copieze fișierele"
    echo "  --save, -s       Salvează datele extrase în fișier"
    echo "  --help, -h       Afișează acest help"
    echo ""
    echo -e "${YELLOW}Exemple:${NC}"
    echo "  $0 /path/to/folder                    # Procesează toate PDF-urile"
    echo "  $0 /path/to/folder --dry-run          # Testează fără copiere"
    echo "  $0 /path/to/folder --save data.txt    # Salvează datele extrase"
    echo ""
}

# Verifică dacă Python este instalat
check_python() {
    if ! command -v python3 &> /dev/null; then
        echo -e "${RED}Eroare: Python3 nu este instalat!${NC}"
        exit 1
    fi
}

# Verifică dacă scriptul Python există
check_script() {
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    PYTHON_SCRIPT="$SCRIPT_DIR/invoice_data_extractor.py"
    
    if [ ! -f "$PYTHON_SCRIPT" ]; then
        echo -e "${RED}Eroare: Scriptul Python nu a fost găsit: $PYTHON_SCRIPT${NC}"
        exit 1
    fi
}

# Verifică dacă folderul există
check_folder() {
    if [ ! -d "$1" ]; then
        echo -e "${RED}Eroare: Folderul '$1' nu există!${NC}"
        exit 1
    fi
}

# Verifică dacă există PDF-uri în folder
check_pdfs() {
    PDF_COUNT=$(find "$1" -name "*.pdf" -type f | wc -l)
    if [ "$PDF_COUNT" -eq 0 ]; then
        echo -e "${YELLOW}Atenție: Nu s-au găsit fișiere PDF în folderul '$1'${NC}"
        exit 0
    fi
    echo -e "${GREEN}Găsite $PDF_COUNT fișiere PDF în folderul '$1'${NC}"
}

# Funcția principală
main() {
    # Verifică argumentele
    if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        show_help
        exit 0
    fi
    
    FOLDER="$1"
    shift
    
    # Verificări preliminare
    check_python
    check_script
    check_folder "$FOLDER"
    check_pdfs "$FOLDER"
    
    # Construiește comanda Python cu activarea mediului virtual
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    PYTHON_SCRIPT="$SCRIPT_DIR/invoice_data_extractor.py"
    VENV_ACTIVATE="$SCRIPT_DIR/venv/bin/activate"
    
    CMD="source \"$VENV_ACTIVATE\" && python3 \"$PYTHON_SCRIPT\" \"$FOLDER\""
    
    # Adaugă opțiunile
    while [[ $# -gt 0 ]]; do
        case $1 in
            --dry-run|-d)
                CMD="$CMD --dry-run"
                echo -e "${YELLOW}*** MOD DRY RUN - Nu se vor copia fișierele ***${NC}"
                ;;
            --save|-s)
                if [ -n "$2" ]; then
                    CMD="$CMD --save \"$2\""
                    shift
                else
                    echo -e "${RED}Eroare: --save necesită un nume de fișier${NC}"
                    exit 1
                fi
                ;;
            *)
                echo -e "${RED}Eroare: Opțiune necunoscută '$1'${NC}"
                show_help
                exit 1
                ;;
        esac
        shift
    done
    
    echo -e "${BLUE}Execută comanda:${NC} $CMD"
    echo ""
    
    # Execută comanda
    eval $CMD
    
    if [ $? -eq 0 ]; then
        echo ""
        echo -e "${GREEN}Procesarea s-a finalizat cu succes!${NC}"
    else
        echo ""
        echo -e "${RED}Procesarea a eșuat!${NC}"
        exit 1
    fi
}

# Execută funcția principală
main "$@"
