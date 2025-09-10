# PDF Renamer

Program Python pentru redenumirea automată a fișierelor PDF pe baza conținutului lor.

## Funcționalități

- Citește PDF-uri dintr-un folder specificat
- Extrage text din PDF-uri folosind două biblioteci (PyMuPDF și PyPDF2)
- Găsește automat numere de factură în text
- Redenumește fișierele în formatul `FACTURA_[numar].pdf`
- Suportă pattern-uri regex personalizate
- Mod dry-run pentru testare fără redenumire

## Instalare

1. Asigură-te că ai Python 3.7+ instalat
2. Instalează dependențele:

```bash
pip install -r requirements.txt
```

## Utilizare

### Comanda de bază

```bash
python pdf_renamer.py /path/to/folder
```

### Opțiuni disponibile

- `--pattern` sau `-p`: Pattern regex personalizat pentru a găsi valoarea în PDF
- `--dry-run` sau `-d`: Testează fără să redenumească fișierele

### Exemple

1. **Procesează toate PDF-urile din folderul curent:**
   ```bash
   python pdf_renamer.py /Users/prundusdaniel/Documents/PDFs
   ```

2. **Folosește un pattern specific:**
   ```bash
   python pdf_renamer.py /Users/prundusdaniel/Documents/PDFs --pattern "FACTURA\\s*(\\d+)"
   ```

3. **Testează fără redenumire (dry run):**
   ```bash
   python pdf_renamer.py /Users/prundusdaniel/Documents/PDFs --dry-run
   ```

4. **Caută numere de invoice în engleză:**
   ```bash
   python pdf_renamer.py /Users/prundusdaniel/Documents/PDFs --pattern "INVOICE\\s*NO\\.?\\s*(\\d+)"
   ```

## Pattern-uri utile

Programul detectează automat următoarele formate:
- `FACTURA 12345`
- `INVOICE NO. 12345`
- `FACTURA NR. 12345`
- `INVOICE 12345`
- Orice număr de cel puțin 4 cifre

Pentru pattern-uri personalizate, folosește sintaxa regex:
- `"FACTURA\\s*(\\d+)"` - pentru "FACTURA 12345"
- `"INVOICE\\s*NO\\.?\\s*(\\d+)"` - pentru "INVOICE NO. 12345"
- `"(\\d{4,})"` - pentru orice număr de cel puțin 4 cifre

## Formatul de redenumire

Fișierele sunt redenumite în formatul:
```
FACTURA_[numar].pdf
```

Exemple:
- `document.pdf` → `FACTURA_12345.pdf`
- `invoice_old.pdf` → `FACTURA_67890.pdf`

## Siguranță

- Programul verifică dacă fișierul de destinație există deja
- Folosește modul dry-run pentru testare
- Păstrează extensia originală a fișierului
- Curăță numele fișierului de caractere invalide

## Rezolvarea problemelor

### Eroarea "Nu s-a putut extrage text din PDF"
- PDF-ul poate fi protejat sau corupt
- Încearcă să deschizi PDF-ul manual pentru a verifica

### Eroarea "Nu s-a găsit valoarea în PDF"
- PDF-ul nu conține numere de factură în formatul așteptat
- Folosește un pattern personalizat cu `--pattern`

### Eroarea "Fișierul există deja"
- Un fișier cu același nume există deja
- Verifică folderul pentru fișiere duplicate

## Dependențe

- `PyPDF2==3.0.1` - Pentru extragerea textului din PDF-uri
- `PyMuPDF==1.23.8` - Pentru extragerea textului din PDF-uri complexe

## Sistem de operare

Programul funcționează pe:
- macOS
- Linux
- Windows

## Licență

Programul este destinat utilizării personale.
