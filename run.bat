@echo off
@setlocal

rem 各種パラメータ
set THIS_DIR=%~dp0
set PYTHON_URL=https://www.python.org/ftp/python/3.9.1/python-3.9.1-embed-amd64.zip
set PYTHON_ZIP=%THIS_DIR%python.zip
set PYTHON_DIR=%THIS_DIR%python\
set APP_SCRIPT_PATH=%THIS_DIR%application.py

rem embeddable python をダウンロード
if not exist %PYTHON_ZIP% (
    bitsadmin.exe /TRANSFER htmlget %PYTHON_URL% %PYTHON_ZIP%
    if errorlevel 1 (
        goto :BAD
    )
) else (
    echo [SKIP] Download embeddable python
)

rem embeddable python を展開
if not exist %PYTHON_DIR% (
    powershell expand-archive %PYTHON_ZIP% %PYTHON_DIR%
    if errorlevel 1 (
        goto :BAD
    )
) else (
    echo [SKIP] Extract embeddable python
)

rem python 実行用に環境変数を展開
call setenv.bat

rem python スクリプトを実行
python %APP_SCRIPT_PATH%

rem 正常終了
:OK
call :FINALLY
exit /b 0

rem 異常終了 
:BAD
call :FINALLY
exit /b 1

rem 終了時必ず通る処理
:FINALLY
exit /b
