@echo off
setlocal EnableDelayedExpansion
title PixelArtistry - Pixal3D Multiview model downloader

echo ============================================================
echo  PixelArtistry - Pixal3D Multiview model downloader
echo ============================================================
echo.

where curl.exe >nul 2>&1
if errorlevel 1 (
    echo [ERROR] curl.exe was not found. It ships with Windows 10 1803 and newer.
    goto :end
)

set "ROOT=%~1"
if not defined ROOT set /p "ROOT=Path to your ComfyUI root folder (the one that contains 'models'): "
set "ROOT=%ROOT:"=%"
if "%ROOT:~-1%"=="\" set "ROOT=%ROOT:~0,-1%"

if not exist "%ROOT%\models\" (
    echo.
    echo [ERROR] No "models" folder found in: !ROOT!
    echo         Point this script at the ComfyUI folder that contains "models".
    goto :end
)
set "M=%ROOT%\models"
echo ComfyUI models folder: %M%
echo.

echo Required models: 8 files, about 25 GB.
echo.
echo Optional: the two Qwen prompt-enhancer models (pe_t2i and pe_i2i, about 8.8 GB each,
echo 17.6 GB together). They are only used when refine_prompt is switched on.
echo The workflow keeps refine_prompt OFF, so you can skip them.
echo.
set "OPT=n"
set /p "OPT=Download the optional prompt enhancers too? [y/N]: "
if /i "!OPT!"=="y" (set "GETOPT=1") else (set "GETOPT=0")
echo.

if "!GETOPT!"=="1" (
    echo Total download size: about 42.6 GB (25 GB required + 17.6 GB optional^)
) else (
    echo Total download size: about 25 GB
)
echo Files that already exist are skipped, so the real download can be smaller.
echo.
set "GO=n"
set /p "GO=Continue? [y/N]: "
if /i not "!GO!"=="y" (
    echo Cancelled.
    goto :end
)

set "QWEN=https://huggingface.co/Comfy-Org/Qwen-Image-2.1/resolve/main"
set "PIX=https://huggingface.co/Comfy-Org/Pixal3D/resolve/main"
set "BIR=https://huggingface.co/Comfy-Org/BiRefNet/resolve/main"

set "FAILED=0"
set "N=0"
if "!GETOPT!"=="1" (set "TOTAL=10") else (set "TOTAL=8")

call :dl diffusion_models      qwen_image_2.1_int8_convrot.safetensors        "%QWEN%/diffusion_models/qwen_image_2.1_int8_convrot.safetensors"        "6.76 GB"
call :dl diffusion_models      pixal3d_multiview_int8_convrot.safetensors     "%PIX%/diffusion_models/pixal3d_multiview_int8_convrot.safetensors"      "5.2 GB"
call :dl text_encoders         qwen3vl_8b_int8_convrot.safetensors            "%QWEN%/text_encoders/qwen3vl_8b_int8_convrot.safetensors"               "8.71 GB"
call :dl vae                   qwen_image_2.1_vae_bf16.safetensors            "%QWEN%/vae/qwen_image_2.1_vae_bf16.safetensors"                         "644 MB"
call :dl vae                   trellis_2_shape_vae_bf16.safetensors           "%PIX%/vae/trellis_2_shape_vae_bf16.safetensors"                         "1.02 GB"
call :dl vae                   trellis_2_texture_vae_bf16.safetensors         "%PIX%/vae/trellis_2_texture_vae_bf16.safetensors"                       "904 MB"
call :dl clip_vision           dino_v3_L_naf_fp32.safetensors                 "%PIX%/clip_vision/dino_v3_L_naf_fp32.safetensors"                       "1.13 GB"
call :dl background_removal    birefnet.safetensors                           "%BIR%/background_removal/birefnet.safetensors"                          "424 MB"

if "!GETOPT!"=="1" (
    call :dl text_encoders     qwen3.5_9b_qwen_image_2.1_pe_t2i.int8_convrot.safetensors "%QWEN%/text_encoders/qwen3.5_9b_qwen_image_2.1_pe_t2i.int8_convrot.safetensors" "8.82 GB"
    call :dl text_encoders     qwen3.5_9b_qwen_image_2.1_pe_i2i.int8_convrot.safetensors "%QWEN%/text_encoders/qwen3.5_9b_qwen_image_2.1_pe_i2i.int8_convrot.safetensors" "8.82 GB"
)

echo.
echo ============================================================
if "!FAILED!"=="0" (
    echo  Done. All models are in place.
    echo  Next: update ComfyUI, restart it, and load the workflow from the workflows folder.
) else (
    echo  Finished with !FAILED! failed download^(s^). Run the script again to retry;
    echo  files that finished are skipped.
)
echo ============================================================
goto :end

:dl
rem %1 = subfolder, %2 = file name, %3 = url, %4 = size text
set /a N+=1
set "DEST=%M%\%~1\%~2"
echo.
echo [!N!/!TOTAL!] %~2 (%~4^)
if exist "%DEST%" (
    echo        Already exists, skipping.
    exit /b 0
)
echo        Downloading to models\%~1 ...
curl.exe -L --fail --create-dirs --retry 3 --progress-bar -o "%DEST%.part" "%~3"
if errorlevel 1 (
    echo        [FAILED] %~2
    if exist "%DEST%.part" del "%DEST%.part"
    set /a FAILED+=1
    exit /b 1
)
move /y "%DEST%.part" "%DEST%" >nul
echo        OK
exit /b 0

:end
echo.
pause
endlocal
