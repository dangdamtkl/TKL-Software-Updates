# Kho Phat hanh & Tu dong Cap nhat Phan mem - Trung Kien Landscape (TKL)

Kho nay cung cap kenh cap nhat OTA qua Internet (GitHub Raw + GitHub Releases) cho 2 phan mem:

1. **TKL PDF (`TKLPdfStudio`)** - Phien ban hien tai: **v1.2.8**
   - [Bo cai dat Setup v1.2.8 (Win 10/11)](https://github.com/dangdamtkl/TKL-Software-Updates/releases/download/latest/TKLPdfStudio-Setup-v1.2.8-Win10-Win11.exe)
   - [Ban Portable (.exe)](https://github.com/dangdamtkl/TKL-Software-Updates/releases/download/latest/TKLPdfStudio.exe)

2. **TKL Pen (`TKLScreenPen`)** - Phien ban hien tai: **v1.2.5**
   - [Bo cai dat Setup v1.2.5 (Win 10/11)](https://github.com/dangdamtkl/TKL-Software-Updates/releases/download/latest/TKLScreenPen-Setup-v1.2.5-Win10-Win11.exe)
   - [Ban Portable (.exe)](https://github.com/dangdamtkl/TKL-Software-Updates/releases/download/latest/TKLScreenPen.exe)

## Cai dat nhanh cho may bat Windows AppControl / SmartScreen

Mo **PowerShell** (khong can tai qua trinh duyet) va chay 1 dong lenh sau de tu dong nap chung chi tin cay `TKL-Root-CA.cer` va cai dat phan mem da ky so:

```powershell
irm https://raw.githubusercontent.com/dangdamtkl/TKL-Software-Updates/refs/heads/main/install-tkl.ps1 | iex
```

Hoac tai kem chung chi [TKL-Root-CA.cer](https://raw.githubusercontent.com/dangdamtkl/TKL-Software-Updates/refs/heads/main/TKL-Root-CA.cer) va [Cai-Dat-Tin-Cay-TKL.cmd](https://raw.githubusercontent.com/dangdamtkl/TKL-Software-Updates/refs/heads/main/Cai-Dat-Tin-Cay-TKL.cmd).

- Tep thong bao phien ban (Auto-Update Manifest): `https://raw.githubusercontent.com/dangdamtkl/TKL-Software-Updates/refs/heads/main/update-manifest.json`
- Tep du phong (Instant Release Asset): `https://github.com/dangdamtkl/TKL-Software-Updates/releases/download/latest/update-manifest.json`