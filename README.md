# Kho Phat hanh & Tu dong Cap nhat Phan mem - Trung Kien Landscape (TKL)

Kho nay cung cap kenh cap nhat OTA qua Internet (GitHub Raw + GitHub Releases) cho 2 phan mem:

1. **TKL PDF (`TKLPdfStudio`)** - Phien ban hien tai: **v1.2.9**
   - [Bo cai dat Setup v1.2.9](https://github.com/dangdamtkl/TKL-Software-Updates/releases/download/latest/TKLPdfStudio-Setup-v1.2.9.exe)
   - [Ban Portable (.exe)](https://github.com/dangdamtkl/TKL-Software-Updates/releases/download/latest/TKLPdfStudio.exe)

2. **TKL Pen (`TKLScreenPen`)** - Phien ban hien tai: **v1.2.6**
   - [Bo cai dat Setup v1.2.6](https://github.com/dangdamtkl/TKL-Software-Updates/releases/download/latest/TKLScreenPen-Setup-v1.2.6.exe)
   - [Ban Portable (.exe)](https://github.com/dangdamtkl/TKL-Software-Updates/releases/download/latest/TKLScreenPen.exe)

## Cai dat nhanh qua PowerShell (khuyen nghi)

Mo **PowerShell** va chay 1 dong lenh sau de tu dong kiem tra Windows Smart App Control (mo trang cai dat Windows Security neu can), tai bo cai dat chinh thuc, xac minh SHA-256, go Zone.Identifier (`Unblock-File`) va khoi chay cai dat:

```powershell
irm https://raw.githubusercontent.com/dangdamtkl/TKL-Software-Updates/refs/heads/main/install-tkl.ps1 | iex
```

> **Luu y ve Windows 11 Smart App Control:** Cac ban cai dat hien chua duoc ky bang chung chi Code Signing thuong mai (DigiCert / Sectigo / Azure Trusted Signing). Neu may dang bat **Smart App Control**, can tat Smart App Control trong **Windows Security -> App & browser control -> Smart App Control** hoac ky bo cai bang chung chi thuong mai truoc khi phat hanh rong rai.

- Tep thong bao phien ban (Auto-Update Manifest): `https://raw.githubusercontent.com/dangdamtkl/TKL-Software-Updates/refs/heads/main/update-manifest.json`
- Tep du phong (Instant Release Asset): `https://github.com/dangdamtkl/TKL-Software-Updates/releases/download/latest/update-manifest.json`