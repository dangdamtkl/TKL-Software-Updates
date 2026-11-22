# Kho Phát hành & Tự động Cập nhật Phần mềm - Trung Kiên Landscape (TKL)

Kho này cung cấp kênh cập nhật OTA qua Internet (GitHub Raw + GitHub Releases) cho 4 phần mềm:

1. **TKL PDF (`TKLPdfStudio`)** - Phiên bản hiện tại: **v2.1.0**
   - [Bộ cài đặt Setup v2.1.0](https://github.com/dangdamtkl/TKL-Software-Updates/releases/download/latest/TKLPdfStudio-Setup-v2.1.0.exe)
   - [Bản Portable (.exe)](https://github.com/dangdamtkl/TKL-Software-Updates/releases/download/latest/TKLPdfStudio.exe)

2. **TKL Pen (`TKLScreenPen`)** - Phiên bản hiện tại: **v1.3.0**
   - [Bộ cài đặt Setup v1.3.0](https://github.com/dangdamtkl/TKL-Software-Updates/releases/download/latest/TKLScreenPen-Setup-v1.3.0.exe)
   - [Bản Portable (.exe)](https://github.com/dangdamtkl/TKL-Software-Updates/releases/download/latest/TKLScreenPen.exe)

3. **TKL Office (`TKLOfficeStudio`)** - Phiên bản hiện tại: **v2.0.0**
   - [Bộ cài đặt Setup v2.0.0](https://github.com/dangdamtkl/TKL-Software-Updates/releases/download/latest/TKLOfficeStudio-Setup-v2.0.0.exe)
   - [Bản Portable (.exe)](https://github.com/dangdamtkl/TKL-Software-Updates/releases/download/latest/TKLOfficeStudio.exe)

4. **TKL Mark (`TKLWatermarkPro`)** - Phiên bản hiện tại: **v1.1.0**
   - [Bộ cài đặt Setup v1.1.0](https://github.com/dangdamtkl/TKL-Software-Updates/releases/download/latest/TKLWatermarkPro-Setup-v1.1.0.exe)
   - [Bản Portable (.exe)](https://github.com/dangdamtkl/TKL-Software-Updates/releases/download/latest/TKLWatermarkPro.exe)

## Cài đặt nhanh qua PowerShell (khuyến nghị)

Mở **PowerShell** và chạy 1 dòng lệnh sau để tự động kiểm tra Windows Smart App Control (mở trang cài đặt Windows Security nếu cần), tải bộ cài đặt chính thức, xác minh SHA-256, gỡ Zone.Identifier (`Unblock-File`) và khởi chạy cài đặt:

```powershell
irm https://raw.githubusercontent.com/dangdamtkl/TKL-Software-Updates/refs/heads/main/install-tkl.ps1 | iex
```

> **Lưu ý về Windows 11 Smart App Control:** Các bản cài đặt hiện chưa được ký bằng chứng chỉ Code Signing thương mại (DigiCert / Sectigo / Azure Trusted Signing). Nếu máy đang bật **Smart App Control**, cần tắt Smart App Control trong **Windows Security -> App & browser control -> Smart App Control** hoặc ký bộ cài bằng chứng chỉ thương mại trước khi phát hành rộng rãi.

- Tệp thông báo phiên bản (Auto-Update Manifest): `https://raw.githubusercontent.com/dangdamtkl/TKL-Software-Updates/refs/heads/main/update-manifest.json`
- Tệp dự phòng (Instant Release Asset): `https://github.com/dangdamtkl/TKL-Software-Updates/releases/download/latest/update-manifest.json`