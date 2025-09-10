#!/bin/bash

# Invoice Data Extractor - Script de instalare
# Acest script instalează programul pentru a fi folosit din orice folder

# Culori pentru output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Invoice Data Extractor - Instalare${NC}"
echo "======================================"
echo ""

# Verifică dacă Python este instalat
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Eroare: Python3 nu este instalat!${NC}"
    echo "Instalează Python3 și încearcă din nou."
    exit 1
fi

echo -e "${GREEN}✅ Python3 este instalat${NC}"

# Obține directorul curent
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo -e "${BLUE}Directorul programului: ${SCRIPT_DIR}${NC}"

# Creează mediul virtual dacă nu există
if [ ! -d "$SCRIPT_DIR/venv" ]; then
    echo -e "${YELLOW}📦 Creez mediul virtual...${NC}"
    cd "$SCRIPT_DIR"
    python3 -m venv venv
    echo -e "${GREEN}✅ Mediu virtual creat${NC}"
fi

# Activează mediul virtual și instalează dependențele
echo -e "${YELLOW}📦 Instalez dependențele...${NC}"
cd "$SCRIPT_DIR"
source venv/bin/activate
pip install -r requirements.txt
echo -e "${GREEN}✅ Dependențe instalate${NC}"

# Face script-ul executabil
chmod +x "$SCRIPT_DIR/invoice_extractor_wrapper.sh"
echo -e "${GREEN}✅ Script-ul este executabil${NC}"

# Verifică dacă alias-ul există deja
if grep -q "alias invoice-extractor=" ~/.zshrc 2>/dev/null; then
    echo -e "${YELLOW}⚠️  Alias-ul 'invoice-extractor' există deja în ~/.zshrc${NC}"
    echo -e "${YELLOW}   Vrei să îl actualizez? (y/n)${NC}"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        # Șterge alias-ul vechi
        sed -i '' '/alias invoice-extractor=/d' ~/.zshrc
        echo -e "${GREEN}✅ Alias-ul vechi a fost șters${NC}"
    else
        echo -e "${YELLOW}⚠️  Păstrez alias-ul existent${NC}"
        exit 0
    fi
fi

# Adaugă alias-ul în .zshrc
echo "alias invoice-extractor=\"$SCRIPT_DIR/invoice_extractor_wrapper.sh\"" >> ~/.zshrc
echo -e "${GREEN}✅ Alias-ul 'invoice-extractor' a fost adăugat în ~/.zshrc${NC}"

# Încarcă configurația
source ~/.zshrc
echo -e "${GREEN}✅ Configurația a fost încărcată${NC}"

echo ""
echo -e "${GREEN}🎉 Instalarea s-a finalizat cu succes!${NC}"
echo ""
echo -e "${BLUE}Cum să folosești programul:${NC}"
echo ""
echo -e "${YELLOW}1. Din orice folder, rulează:${NC}"
echo "   invoice-extractor --help"
echo ""
echo -e "${YELLOW}2. Pentru a procesa PDF-urile dintr-un folder:${NC}"
echo "   invoice-extractor /path/to/folder"
echo ""
echo -e "${YELLOW}3. Pentru a exporta în Excel:${NC}"
echo "   invoice-extractor /path/to/folder --excel facturi.xlsx"
echo ""
echo -e "${YELLOW}4. Pentru a testa fără să copieze fișierele:${NC}"
echo "   invoice-extractor /path/to/folder --dry-run"
echo ""
echo -e "${BLUE}Date extrase:${NC}"
echo "  • Numele companiei"
echo "  • Data emitere și data scadenta"
echo "  • Total plata și total TVA"
echo "  • Denumirea produsului"
echo "  • Cod CPV și Cod NC8"
echo ""
echo -e "${GREEN}Programul este gata de utilizare! 🚀${NC}"
