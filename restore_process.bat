@echo off

:: NAS sürücüsünü bağla
echo NAS sürücüsü bağlanıyor...
net use Z: /delete
net use Z: \\185.250.241.200\images /user:Network\Gamehub Yigitcan123@ /persistent:no
if errorlevel 1 (
    echo NAS sürücüsüne bağlanılamadı. Lütfen kullanıcı adı ve parolayı kontrol edin.
    pause
    exit /b 1
)

:: XML dosyasını kullanıcı dizinine kopyala
echo XML dosyası kullanıcı dizinine kopyalanıyor...
copy /y "Z:\1.xml" "%USERPROFILE%\1.xml"
if errorlevel 1 (
    echo XML dosyası kopyalanamadı. Lütfen NAS bağlantısını kontrol edin.
    net use Z: /delete
    pause
    exit /b 1
)

:: Macrium Reflect ile XML dosyasını çalıştır
echo Macrium Reflect işlemi başlatılıyor...
"C:\Program Files\Macrium\Reflect\reflect.exe" -e -w -now "%USERPROFILE%\1.xml"
if errorlevel 1 (
    echo Geri yükleme işlemi sırasında hata oluştu.
    net use Z: /delete
shutdown /r /t 0
)

:: NAS bağlantısını kaldır
echo NAS bağlantısı kaldırılıyor...
net use Z: /delete

:: Geri yükleme başarılı, sistemi yeniden başlat
echo İşlem tamamlandı! Sistem yeniden başlatılıyor...

