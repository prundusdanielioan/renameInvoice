# Invoice Data Extractor

Program pentru extragerea automată a datelor din facturi PDF și exportul lor în Excel.

## 🚀 Instalare Rapidă

```bash
# Clonează sau descarcă proiectul
cd /path/to/renameInvoice

# Rulează scriptul de instalare
./install.sh
```

## 📋 Date Extrase

Programul extrage următoarele informații din facturi PDF:

- **Numele companiei** (după labelul "Nume")
- **Data emitere** (după labelul "Data emitere")
- **Data scadenta** (după labelul "Data scadenta")
- **Total plata** (după labelul "TOTAL PLATA")
- **Total TVA** (după labelul "TOTAL TVA")
- **Denumirea produsului** (din coloana "Nume articol/Descriere articol")
- **Cod CPV** (după "Cod CPV articol pentru linia X")
- **Cod NC8** (după "Cod NC8 articol pentru linia X")

## 💻 Utilizare

După instalare, poți rula programul din **orice folder**:

### Comenzi de bază

```bash
# Afișează ajutorul
invoice-extractor --help

# Procesează toate PDF-urile dintr-un folder
invoice-extractor /path/to/folder

# Testează fără să copieze fișierele (dry run)
invoice-extractor /path/to/folder --dry-run

# Exportă datele în Excel
invoice-extractor /path/to/folder --excel facturi.xlsx

# Salvează datele extrase într-un fișier text
invoice-extractor /path/to/folder --save data.txt
```

### Exemple practice

```bash
# Procesează PDF-urile din folderul curent
invoice-extractor .

# Procesează PDF-urile din Desktop
invoice-extractor ~/Desktop

# Exportă în Excel cu nume personalizat
invoice-extractor ~/Documents/facturi --excel raport_facturi.xlsx

# Testează fără să modifice fișierele
invoice-extractor ~/Downloads --dry-run --excel test.xlsx
```

## 📊 Format Excel

Fișierul Excel generat conține următoarele coloane:

| Coloană | Descriere |
|---------|-----------|
| Fișier Original | Numele fișierului PDF original |
| Nume Companie | Numele companiei din factură |
| Data Emitere | Data emiterii facturii |
| Data Scadenta | Data scadenței |
| Total Plata | Suma totală de plată |
| Total TVA | Valoarea TVA |
| Denumire Produs | Denumirea produsului |
| Cod CPV | Codul CPV (ex: H87, LTR) |
| Cod NC8 | Codul NC8 (ex: H87, LTR) |
| Status | Succes/Eroare |
| Fișier Nou | Numele noului fișier creat |

## 🔧 Instalare Manuală

Dacă preferi să instalezi manual:

```bash
# 1. Creează mediul virtual
python3 -m venv venv

# 2. Activează mediul virtual
source venv/bin/activate

# 3. Instalează dependențele
pip install -r requirements.txt

# 4. Adaugă alias-ul în ~/.zshrc
echo 'alias invoice-extractor="/path/to/renameInvoice/invoice_extractor_wrapper.sh"' >> ~/.zshrc

# 5. Încarcă configurația
source ~/.zshrc
```

## 📁 Structura Proiectului

```
renameInvoice/
├── invoice_data_extractor.py      # Script principal Python
├── invoice_extractor_wrapper.sh   # Wrapper bash
├── install.sh                     # Script de instalare
├── requirements.txt               # Dependențe Python
├── README.md                      # Această documentație
└── venv/                         # Mediu virtual Python
```

## 🛠️ Dependențe

- **Python 3.7+**
- **PyPDF2** - pentru extragerea textului din PDF
- **openpyxl** - pentru exportul în Excel

## ❓ Troubleshooting

### Programul nu funcționează din alte foldere

```bash
# Verifică dacă alias-ul este setat
grep "invoice-extractor" ~/.zshrc

# Dacă nu există, adaugă-l manual
echo 'alias invoice-extractor="/path/to/renameInvoice/invoice_extractor_wrapper.sh"' >> ~/.zshrc
source ~/.zshrc
```

### Eroare "ModuleNotFoundError"

```bash
# Activează mediul virtual
cd /path/to/renameInvoice
source venv/bin/activate

# Instalează dependențele
pip install -r requirements.txt
```

### Nu se găsesc PDF-uri

- Verifică că folderul conține fișiere `.pdf`
- Verifică că ai permisiuni de citire pentru folder
- Folosește calea completă către folder

## 📝 Log-uri

Programul afișează informații detaliate despre:
- Fișierele găsite și procesate
- Datele extrase din fiecare PDF
- Erorile întâlnite
- Statisticile finale

## 🎯 Caracteristici

- ✅ **Extragere automată** a datelor din PDF
- ✅ **Export Excel formatat** cu header-uri colorate
- ✅ **Funcționare din orice folder** prin alias
- ✅ **Mod dry-run** pentru testare
- ✅ **Logging detaliat** al procesului
- ✅ **Gestionare erori** cu statistici
- ✅ **Instalare automată** prin script

## 📞 Suport

Pentru probleme sau întrebări:
1. Verifică secțiunea Troubleshooting
2. Rulează cu `--dry-run` pentru testare
3. Verifică log-urile pentru detalii despre erori

---

**Notă**: Programul este optimizat pentru facturi în format standard românesc și poate necesita ajustări pentru alte formate.