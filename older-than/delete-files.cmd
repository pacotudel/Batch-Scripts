@setlocal
@set FECHA=-8
@cls
@echo -------------------------------
@forfiles /P ".\prueba" /S /M *.* /D %FECHA% /C "cmd /c echo @PATH"
@echo -------------------------------
@forfiles /P ".\prueba" /S /M *.* /D %FECHA% /C "cmd /c echo @FILE"
@rem @forfiles -P ".\prueba" -S -M *.* /D -2 /C "cmd /c echo @FILE"
@rem echo -------------------------------
@rem forfiles /P .\prueba /M *.txt /D -4